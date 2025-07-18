# PICO-8 v0.2.6b 0day VM Escape + RCE Exploit

PICO-8 v0.2.6b contains a remote code execution vulnerability due to a buffer overflow in `normalise_pico8_path()`. Attackers
can exploit this vulnerability to escape the PICO-8 VM and execute arbitrary code on the host system as the local user. User
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
TODO

## Exploit
At a high level, the exploit works like this:
1. ROP stage 1: overflow the buffer and pivot the stack to the second ROP stage embedded in our exploit script
2. ROP stage 2: call `VirtualProtect()` to mark the page of memory containing our embedded shellcode as executable
3. Jump to our embedded shellcode end execute it

## Conclusion
TODO
