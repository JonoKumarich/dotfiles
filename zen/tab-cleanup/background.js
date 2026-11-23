const MAX_IDLE_MS = 12 * 60 * 60 * 1000;

const isStale = (tab, now) =>
  !tab.pinned && !tab.active && !tab.audible && now - tab.lastAccessed > MAX_IDLE_MS;

async function cleanup() {
  const now = Date.now();
  const stale = (await browser.tabs.query({})).filter((tab) => isStale(tab, now));
  if (stale.length) await browser.tabs.remove(stale.map((tab) => tab.id));
}

browser.alarms.create("cleanup", { periodInMinutes: 5 });
browser.alarms.onAlarm.addListener(cleanup);
cleanup();
