# PICO-8 v0.2.6b VM Escape + RCE Exploit

PICO-8 v0.2.6 contains a remote code execution vulnerability due to a buffer overflow in `normalise_pico8_path()`. Attackers
can exploit this vulnerability to escape the VM and execute arbitrary code on the host system as the local user. User
interaction is required to exploit this vulnerability, as the user must load and run a malicious cartridge file to trigger
the exploit.
