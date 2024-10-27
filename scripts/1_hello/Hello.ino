#include "Keyboard.h"

// MACROS =====================================================================
void enter() {
  Keyboard.press(KEY_RETURN);
  delay(500);
  Keyboard.releaseAll();
}

void printAndWait(char *input, unsigned long delay) {
  Keyboard.print(input);
  delay(500);
}

// MAIN =======================================================================
void setup() {
  Keyboard.begin();
  delay(1000);

  Keyboard.press(KEY_LEFT_GUI);
  Keyboard.press(' ');
  delay(500);
  Keyboard.releaseAll();

  printAndWait("Terminal", 500)
  enter();

  printAndWait("ls", 500)
  enter();

  Keyboard.end();
}
#include "Keyboard.h"

// MACROS =====================================================================
void enter() {
  Keyboard.press(KEY_RETURN);
  delay(500);
  Keyboard.releaseAll();
}

void printAndWait(char *input, unsigned long delayTime) {
  Keyboard.print(input);
  delay(delayTime);
}

// MAIN =======================================================================
void setup() {
  Keyboard.begin();
  delay(1000);

  // Open spotlight search
  Keyboard.press(KEY_LEFT_GUI);
  Keyboard.press(' ');
  delay(500);
  Keyboard.releaseAll();

  // Open the terminal
  printAndWait("Terminal", 500);
  enter();

  // Type "ls" command
  printAndWait("ls", 500);
  enter();

  Keyboard.end();
}

void loop() {

}