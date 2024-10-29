## Fetch.ino
Payload for mac that opens the terminal and fetches a hosted program using curl. It then makes sure it is executable and then runs the payload before deleting the files involved.

Just to keep things clean i made a hidden `.notSus` folder. In the case that things are not properly deleted at the end at least hiding the file might reduce the chance that the user notices their system has been tampered with.

The example here uses a very simple bash script that just echoes two lines to the terminal, but given the fact that you're able to basically host and pull any file to execute, you are able to do much more complicated things by modifying the contents of the `hosted_payload.sh` file.

Unfortunately you can't really use environment variables (to my knowledge) for arduino programs so guess we're exposing the attacker's IP address. You would probably attack with an expendable virtual machine address though.

### Usage
1) Copy the `server/` directory to the attacker machine
2) Modify `Fetch.ino` to contain your attacker's IP address (or the IP of where you've hosted the payload)
3) Load the `Fetch.ino` file into your arduino micro/leonardo
4) Host the payload by running `host_payload.sh` (it will clean up the hosting process and tmp directory after terminating the program)
5) Plug the arduino into your target mac!