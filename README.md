# retrosystem16
This is a learning project for me to explore assembly for bare metal x86.

Long Term Design goals:
+ Fat12 support and memory management capability
+ 16 bit terminal based OS
+ Basic programs designed for the OS
+ (maybe) a custom interpreter or port an open source interpreter over for something like BASIC.

Commands Implemented:
+ "version" prints out version number of program.
+ "bootscreen" prints out the welcome screen.

Might be putting a pause on the project.  I am having a really tough time getting the second sector to be read with BIOS INT 13h AH=2 and I have college.  Boot.asm in the main folder is fully functioning with the two commands currently implemented.  Unstable has my broken bootloader and my kernel file which essentially is boot.asm without the bootable code and limitations.  I might come back to this project eventually either after I learn more assembly or if I end up getting some help.(Perhaps I'll fork a gpl v3 licensed bootloader for use in this project.)
