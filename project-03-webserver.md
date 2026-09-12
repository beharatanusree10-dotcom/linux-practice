## Project 3: Hosting a Web Server (nginx)

**What I practiced:**
- Installing and managing a service (`apt install nginx`, `systemctl status`)
- Verifying a service is actually running and responding (`curl`)
- Checking process ownership to confirm least-privilege setup (`ps aux`)
- Identifying open ports and which process owns them (`ss -tulnp`)
- Replacing default content with a custom page

**Commands used:**
sudo apt install, systemctl status, curl, ps aux, sudo ss -tulnp, echo, sudo tee

**What I learned:**
- Nginx runs as a master/worker process model: the master process starts as `root` (needed to bind to port 80, a privileged port), but the actual worker processes that handle web requests run as the unprivileged `www-data` user — this is least-privilege in practice, not just theory
- `ss -tulnp` shows every listening port and which process owns it — this is one of the first commands to run when investigating what's running on a system, or checking for something that shouldn't be there
- Ports below 1024 (like 80 and 22) require root to bind, which is why the nginx master process needs elevated privileges even though the workers don't
- `sudo tee` is used instead of `sudo echo >` because redirection (`>`) happens in the *shell*, which isn't run as root even when the command before it has `sudo` — `tee` solves this by receiving root privileges itself

**Why this matters for DFIR:**
Knowing what's normal (root master process, unprivileged workers, expected open ports) is what makes it possible to spot what's abnormal later — an investigator checking `ps aux` or `ss -tulnp` on a compromised system is looking for exactly these baselines to know something is out of place.
