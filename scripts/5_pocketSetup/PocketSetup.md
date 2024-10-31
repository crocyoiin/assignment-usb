## QuickSetup.ino
Sets up a temporary directory for you to work in when you plug in the rubber ducky and starts a background process to detect the removal of the USB. Once removed, a cleanup script will be run to send all files in the temporary directory to your machine via netcat, and then remove the temp working directory

- would try windows or other machines but i cant really test since i don't got one rip

From experimenting with background processes in the setup script for the assignment exfiltration payload and running commands in the reverse shell payload
- cleanup scripts
