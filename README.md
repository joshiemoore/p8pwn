# PICO-8 v0.2.6b 0day VM Escape + RCE Exploit

PICO-8 v0.2.6b contains a remote code execution vulnerability due to a buffer overflow in `normalise_pico8_path()`. Attackers
can exploit this vulnerability to escape the PICO-8 VM and execute arbitrary native code on the host system as the current user. User
interaction is required to exploit this vulnerability, as the user must load and run a malicious cartridge file to trigger
the exploit.

If you have questions, comments, or hatred to share, please DM me on instagram [@joshiemoore](https://instagram.com/joshiemoore).
Followers are more likely to have their questions answered. Also, feel free to reach out if you would like to pay me to work
on something, I'm currently available for new opportunities. 

**DISCLAIMER:** Crime is illegal. This exploit and writeup are being shared publicly for the purpose of fun and education.
It's about the journey, not the destination! I am not responsible for anything you choose to do with the materials and
information contained in this repo. DFIU!

https://github.com/user-attachments/assets/3b4b1f4a-03c1-4a65-be86-adc91cc3703d

## Vulnerability
PICO-8 v0.2.6b installs pico8.exe, a 32-bit Windows binary with no ASLR or stack canaries.

The core vulnerability is a buffer overflow in `normalise_pico8_path()`. This function takes the user-supplied path string
passed to `LS()` and converts it to a canonical absolute path that the PICO-8 can reason about internally. So it resolves
subdirectories, `../`, etc.

When you pass in a path containing subdirectories, like `AAAA/BBBB/CCCC`, the path is traversed, and each subdirectory name
in the path gets `memcpy()`'d into the buffer `local_51c`, one at a time:

<img width="822" height="38" alt="buffers" src="https://github.com/user-attachments/assets/ed232818-4607-4a0d-a067-57b7aeac4e44" />

<img width="447" height="311" alt="part1" src="https://github.com/user-attachments/assets/b83c32cd-d32a-4d93-85bf-8416400e789f" />

Each subdirectory is then `strcpy()`'d into the buffer `local_41d` at the current index into the normalized path:

<img width="736" height="311" alt="part2" src="https://github.com/user-attachments/assets/65b77a21-aeac-4436-9254-ab47631f8282" />

And so we build the full normalized path in `local_41d`. The issue is that there are no length limits or bounds checks on any of
this, so if you pass in a path containing numerous subdirectories with long names, you can overflow `local_41d` and smash the stack.
However, each directory name can only be up to 255 bytes (including the ending "/"), or `strcpy()` will end up never
hitting a null byte, and will instead start copying from from `local_51c` into `local_41d`, then it will reach `local_41d` and just
keep on copying what it already copied until it reaches an unmapped page and triggers an AV. So if you want to actually control
the overflow of `local_41d`, you have to use several subdirectories with each being up to 255 bytes long.

## Exploit
At a high level, the exploit works like this:
1. ROP stage 1: overflow the buffer and pivot the stack to the second ROP stage embedded in our exploit script
2. ROP stage 2: call `VirtualProtect()` to mark the page of memory containing our embedded shellcode as executable
3. Jump to our embedded shellcode end execute it

## Conclusion
TODO
