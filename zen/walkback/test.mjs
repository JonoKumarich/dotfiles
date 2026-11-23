import { readFileSync } from "node:fs";
import vm from "node:vm";
import assert from "node:assert";

const source = readFileSync(new URL("walkback.uc.js", import.meta.url), "utf8");

class Tab {
  constructor(id, openerTab = null) {
    Object.assign(this, { id, openerTab, localName: "tab", isConnected: true, selected: false, pinned: false, closing: false });
    this.attrs = new Map();
    this.style = new Map();
    this.style.setProperty = this.style.set;
    this.style.removeProperty = this.style.delete;
  }
  getAttribute(name) { return this.attrs.get(name) ?? null; }
  setAttribute(name, value) { this.attrs.set(name, String(value)); }
  removeAttribute(name) { this.attrs.delete(name); }
}

async function boot(tabs = [], stored = new Map(), excluded = []) {
  const listeners = {};
  const gBrowser = {
    tabs,
    tabContainer: { addEventListener: (type, fn) => (listeners[type] = fn) },
    _findTabToBlurTo: () => "fallback",
  };
  const ctx = {
    console,
    gBrowser,
    delayedStartupPromise: Promise.resolve(),
    document: { getElementById: (id) => tabs.find((tab) => tab.id === id) ?? null },
    gZenWorkspaces: { promiseInitialized: Promise.resolve(), getTabsToExclude: () => excluded },
    SessionStore: {
      promiseAllWindowsRestored: Promise.resolve(),
      getCustomTabValue: (tab, key) => stored.get(tab)?.[key] ?? "",
      setCustomTabValue: (tab, key, value) => stored.set(tab, { ...stored.get(tab), [key]: value }),
      deleteCustomTabValue: (tab) => stored.delete(tab),
    },
  };
  vm.runInNewContext(source, ctx);
  await new Promise((resolve) => setImmediate(resolve));

  const open = (id, opener) => {
    const tab = new Tab(id, opener);
    tabs.push(tab);
    listeners.TabOpen({ target: tab });
    return tab;
  };
  const close = (tab) => {
    tab.closing = true;
    listeners.TabClose({ target: tab });
    const next = gBrowser._findTabToBlurTo(tab);
    tabs.splice(tabs.indexOf(tab), 1);
    return next;
  };
  const move = (tab) => listeners.TabMove({ target: tab });
  return { open, close, move };
}

const depth = (tab) => tab.style.get("--walkback-depth") ?? 0;

{
  const { open, close } = await boot();
  const a = open("a");
  const b = open("b", a);
  const c = open("c", b);
  assert.deepEqual([depth(a), depth(b), depth(c)], [0, 1, 2]);

  c.selected = true;
  assert.equal(close(c), b, "closing the active child returns to its parent");

  const d = open("d", b);
  assert.equal(close(b), "fallback", "a background tab defers to Zen's choice");
  assert.equal(depth(d), 1, "children of a closed tab move up to its parent");
  d.selected = true;
  assert.equal(close(d), a);
}

{
  const { open, close, move } = await boot();
  const a = open("a");
  const b = open("b", a);
  const c = open("c", b);
  move(b);
  assert.deepEqual([depth(b), depth(c)], [0, 1], "a moved tab leaves the tree and its children move up");
  b.selected = true;
  assert.equal(close(b), "fallback", "a moved tab no longer walks back");
}

{
  const excluded = [];
  const { open, close } = await boot([], new Map(), excluded);
  const a = open("a");
  const b = open("b", a);
  const c = open("c", b);
  excluded.push(b);
  c.selected = true;
  assert.equal(close(c), a, "skips ancestors in another workspace");
}

{
  const { open, close } = await boot();
  const pinned = open("p");
  pinned.pinned = true;
  const child = open("c", pinned);
  assert.equal(depth(child), 0, "children of pinned tabs start unindented");
  child.selected = true;
  assert.equal(close(child), pinned, "but still walk back to the pinned tab");
}

{
  const a = new Tab("a");
  const b = new Tab("b");
  const c = new Tab("c");
  const stored = new Map([[b, { "walkback-parent": "a" }], [c, { "walkback-parent": "b" }]]);
  await boot([a, b, c], stored);
  assert.deepEqual([depth(a), depth(b), depth(c)], [0, 1, 2], "rebuilds the tree from the saved session");
}

console.log("ok");
