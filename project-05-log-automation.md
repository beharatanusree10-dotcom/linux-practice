## Project 5: Automated Failed-Login Detection with Cron

**What I practiced:**
- Writing a bash script to parse logs and extract structured data (`grep`, regex)
- Counting and aggregating results (`sort`, `uniq -c`)
- Setting a threshold to distinguish normal activity from suspicious activity
- Scheduling recurring automation with `cron`
- Debugging a real cron failure caused by a relative path

**Commands used:**
nano, chmod +x, grep -oP, sort, uniq -c, crontab -e, crontab -l, logger

**What I learned:**
- `grep -oP` with a lookbehind pattern (`(?<=from )`) extracts just the matching part of a line (the IP), not the whole line — useful for pulling structured data out of unstructured log text
- `sort | uniq -c` is a simple but powerful pattern for counting occurrences of repeated values (here, how many times each IP appears)
- Cron jobs do **not** run from your home directory the way an interactive shell does — a relative path (`linux-practice/script.sh`) means nothing to cron and fails silently, with no error shown at the terminal
- I hit this exact bug for real: replacing my working crontab entry with a relative path caused the job to silently do nothing, which I only caught by re-checking `crontab -l` and thinking through why it wouldn't work
- Always use full absolute paths (`/home/ubuntu/...`) in cron jobs and scripts that cron will run
- `logger` can inject realistic test log entries safely, using reserved documentation IP ranges (`203.0.113.0/24`, `198.51.100.0/24`), without needing to fake an actual attack

**Why this matters for DFIR:**
This is essentially a miniature intrusion-detection tool: parsing raw logs, identifying a pattern (repeated failures from one source), and flagging it automatically instead of relying on someone to notice manually. The cron relative-path bug is also a realistic lesson — a security automation tool that silently fails to run is arguably worse than no automation at all, since it creates false confidence that monitoring is happening.
