## Project 2: Permissions on "Evidence" Files

**What I practiced:**
- File permissions and ownership (`ls -l`, `chmod`, `chown`)
- Creating a second user (`sudo adduser`) and a shared group (`groupadd`, `usermod -aG`)
- Restricting folder access to only the owner and group members (`chmod 770`)
- Protecting an "original evidence" file as read-only while keeping a separate editable working copy
- Verifying permission changes by testing them, not just reading them

**Commands used:**
mkdir, touch, echo, cp, chmod, chown, sudo adduser, groupadd, usermod, newgrp, ls -la

**What I learned:**
- `ls -l` shows permissions in the first column (e.g. `-rw-r--r--`) — owner, group, others
- `chmod` sets permissions numerically (e.g. `440`, `660`, `770`) or symbolically
- Group membership doesn't take effect in an already-open shell — `newgrp` (or a new session) is needed
- `chmod 440` removes all write access, even for the file's own owner — proven by testing `echo >> file` and getting "Permission denied"
- `chown user:group` changes both ownership and group in one command

**Why this matters for DFIR:**
Real evidence handling requires the original file to stay untouched and provably unaltered, while investigators work from a copy. Setting the original to `440` (read-only, even for the owner) enforces that at the OS level rather than relying on discipline alone — the same principle used in real chain-of-custody procedures.
