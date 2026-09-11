# Linux Practice

Hands-on Linux practice building toward digital forensics.

## Project 1: Terminal Navigation & File Operations

**What I practiced:**
- Basic navigation (`pwd`, `ls -la`)
- Creating nested directory structures (`mkdir -p`)
- File operations: copying, moving, and renaming files
- Safe deletion practices using `man` pages before running destructive commands

**Commands used:** 

pwd,ls -la,mkdir -p,touch,cp,mv,man,rm-r


**What I learned:**
- `cp` duplicates a file (original stays in place); `mv` relocates or renames it (original is gone)
- `rm -r` is required to delete directories — `rm` alone only removes files
- `man rm` showed the `-i` flag, which prompts for confirmation before each deletion — useful for avoiding accidental data loss, especially relevant to forensic work where evidence integrity matters

