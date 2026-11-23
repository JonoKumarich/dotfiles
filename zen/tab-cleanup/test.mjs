import { readFileSync } from "node:fs";
import vm from "node:vm";
import assert from "node:assert";

const noop = () => {};
const ctx = { browser: { alarms: { create: noop, onAlarm: { addListener: noop } }, tabs: { query: async () => [], remove: noop } } };
vm.runInNewContext(readFileSync(new URL("background.js", import.meta.url), "utf8") + ";this.isStale = isStale;", ctx);

const now = 100 * 60 * 60 * 1000;
const old = { pinned: false, active: false, audible: false, lastAccessed: now - 13 * 60 * 60 * 1000 };
assert.ok(ctx.isStale(old, now));
assert.ok(!ctx.isStale({ ...old, lastAccessed: now - 60 * 1000 }, now));
assert.ok(!ctx.isStale({ ...old, pinned: true }, now));
assert.ok(!ctx.isStale({ ...old, active: true }, now));
assert.ok(!ctx.isStale({ ...old, audible: true }, now));
console.log("ok");
