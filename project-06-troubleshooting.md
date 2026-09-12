## Project 6: Diagnosing and Fixing a Broken Service

**What I practiced:**
- Deliberately breaking a service configuration to practice diagnosis
- Reading `systemctl status` output to distinguish "service failed" from "service still running on old config"
- Using `journalctl -xeu` to find the specific error message behind a failure
- Using `nginx -t` to test configuration validity without affecting the running service
- Fixing the root cause and verifying the fix at multiple levels (config test, service status, actual HTTP request)

**Commands used:**
systemctl status, journalctl -xeu, nginx -t, systemctl reload, rm, curl

**What I learned:**
- Nginx validates config before applying a reload — a bad reload does NOT take down a working service; it just refuses to apply the new config, leaving the last-known-good version running
- `systemctl status` and `journalctl -xeu` show different things: status gives current state and recent log lines inline, while journalctl gives the fuller log history for a service
- `nginx -t` isolates the "is this config valid" question from "is the service currently running" — testing before reloading avoids taking a working service down over a typo
- A fix isn't confirmed until it's verified at every relevant layer: config test passing, service status showing active/running, AND an actual request succeeding — any one of these alone could be misleading
- `less` (used internally by `systemctl status` for paged output) needs `q` to exit — getting "stuck" in a pager is a common beginner moment, not a real error

**Why this matters for DFIR:**
This is the core troubleshooting/incident-response loop in miniature: something breaks, you gather evidence from multiple sources (status, logs, config test) rather than guessing, you identify root cause precisely (exact file and line), you fix only what's broken, and you verify the fix actually worked rather than assuming it did. The distinction between "failed" and "still partially working on old state" is also a realistic incident nuance — real systems often degrade rather than go fully down.
