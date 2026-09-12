## Project 4: Securing SSH with Key-Based Authentication

**What I practiced:**
- Generating an SSH key pair (`ssh-keygen -t ed25519`)
- Installing a public key on a remote system's `authorized_keys` file
- Testing key-based login before making any config changes
- Disabling password authentication in `sshd_config`
- Verifying the change actually took effect, not just assuming it worked

**Commands used:**
ssh-keygen, cat, nano, ssh, sudo systemctl restart ssh, ssh -o PubkeyAuthentication=no

**What I learned:**
- SSH key auth works as a matched pair: the private key stays on the client machine and is never shared; only the public key gets copied to the server's `~/.ssh/authorized_keys`
- `authorized_keys` can hold multiple keys (one per line) — adding a new one means appending, not overwriting existing entries
- Config changes to `/etc/ssh/sshd_config` require a service restart (`systemctl restart ssh`) to take effect
- Always keep an existing session open before disabling password auth — if key login were broken, an open session is the only way back in without external access to the VM
- Testing a security control by trying to defeat it (`-o PubkeyAuthentication=no` to force password-only) is the only way to actually confirm it works, rather than assuming a config change did what it was supposed to

**Why this matters for DFIR:**
Understanding exactly how SSH authentication works — and how to verify a security control rather than trust it blindly — is directly relevant to incident response, where you'd need to determine whether an attacker got in via a stolen key, a guessed password, or a misconfiguration. This project also reinforced a core investigative habit: verify, don't assume.
