// ==UserScript==
// @name        walkback
// @description Indents tabs under the tab that opened them, and returns to that tab when you close one
// ==/UserScript==

(async () => {
  const PARENT = "walkback-parent";
  const DEPTH = "walkback-depth";
  const MAX_DEPTH = 64;

  const parentOf = (tab) => {
    const id = tab.getAttribute(PARENT);
    const parent = id && document.getElementById(id);
    return parent?.localName === "tab" ? parent : null;
  };

  function* ancestors(tab) {
    let parent = parentOf(tab);
    for (let n = 0; parent && n < MAX_DEPTH; n++, parent = parentOf(parent)) yield parent;
  }

  const setParent = (tab, parent) => {
    if (parent?.id) {
      tab.setAttribute(PARENT, parent.id);
      SessionStore.setCustomTabValue(tab, PARENT, parent.id);
    } else {
      tab.removeAttribute(PARENT);
      SessionStore.deleteCustomTabValue(tab, PARENT);
    }
  };

  // Pinned and essential tabs live in their own section, so indentation restarts below them.
  const depthOf = (tab) => {
    let depth = 0;
    for (const parent of ancestors(tab)) {
      if (parent.pinned) break;
      depth++;
    }
    return depth;
  };

  // ponytail: recomputes every tab on each open/close, which is fine for a few hundred tabs
  const refresh = () => {
    for (const tab of gBrowser.tabs) {
      const depth = depthOf(tab);
      if (depth) {
        tab.setAttribute(DEPTH, depth);
        tab.style.setProperty("--walkback-depth", depth);
      } else {
        tab.removeAttribute(DEPTH);
        tab.style.removeProperty("--walkback-depth");
      }
    }
  };

  const restoreLink = (tab) => {
    const id = SessionStore.getCustomTabValue(tab, PARENT);
    if (id) tab.setAttribute(PARENT, id);
  };

  const onOpen = ({ target: tab }) => {
    const opener = tab.openerTab;
    if (!opener || opener === tab || !opener.isConnected) return;
    setParent(tab, opener);
    refresh();
  };

  const promoteChildren = (tab) => {
    const grandparent = parentOf(tab);
    for (const other of gBrowser.tabs) {
      if (other !== tab && parentOf(other) === tab) setParent(other, grandparent);
    }
  };

  // Runs before Zen picks the next tab, and leaves the closing tab's own link intact for that pick.
  const onClose = ({ target: tab }) => {
    promoteChildren(tab);
    refresh();
  };

  const onMove = ({ target: tab }) => {
    promoteChildren(tab);
    setParent(tab, null);
    refresh();
  };

  const onRestore = ({ target: tab }) => {
    restoreLink(tab);
    refresh();
  };

  await delayedStartupPromise;
  await Promise.all([SessionStore.promiseAllWindowsRestored, gZenWorkspaces.promiseInitialized]);

  for (const tab of gBrowser.tabs) restoreLink(tab);
  refresh();

  const findTabToBlurTo = gBrowser._findTabToBlurTo;
  gBrowser._findTabToBlurTo = function (tab, exclude = []) {
    if (tab.selected) {
      const skip = new Set([...exclude, ...gZenWorkspaces.getTabsToExclude(tab)]);
      for (const parent of ancestors(tab)) {
        if (!parent.closing && !skip.has(parent)) return parent;
      }
    }
    return findTabToBlurTo.call(this, tab, exclude);
  };

  gBrowser.tabContainer.addEventListener("TabOpen", onOpen);
  gBrowser.tabContainer.addEventListener("TabClose", onClose);
  gBrowser.tabContainer.addEventListener("TabMove", onMove);
  gBrowser.tabContainer.addEventListener("SSTabRestoring", onRestore);
})().catch((error) => console.error("[walkback]", error));
