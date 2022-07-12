#include <IRremote.h>


IRrecv irrecv(A0);
decode_results results;
uint8_t packetPos = 0;
uint8_t yy;
uint8_t mm;
uint8_t dd;
uint8_t steps;


void setup()
{
  Serial.begin(9600);
  irrecv.enableIRIn(); // Start the receiver
}


void loop() {
  if (irrecv.decode(&results)) {
    // Process a full packet.
    if (packetPos > 0) {
      if (packetPos == 1) {
        yy = results.value;
      } else if (packetPos == 2) {
        mm = results.value;
      } else if (packetPos == 3) {
        dd = results.value;
      } else if (packetPos == 4) {
        steps = results.value;
      } else if (packetPos == 5) {
        // Validate end token.
        if (results.value != 0x00FF00FF) {
          Serial.print("Invalid end token: ");
          Serial.println(results.value);
  
          yy = mm = dd = steps = 0x0;
        
        } else {
          printPacket();
          sendToC64();
        }

        packetPos = -1;
      }

      packetPos++;
      irrecv.resume();
    }
    
    // Check for a start token.
    if (results.value == 0xFF00FF00 && packetPos == 0) {
      packetPos = 1;
      irrecv.resume();
    }

  }
}


void printPacket() {
  Serial.print("YY: ");
  Serial.println(yy);

  Serial.print("MM: ");
  Serial.println(mm);

  Serial.print("DD: ");
  Serial.println(dd);

  Serial.print("Step count: ");
  Serial.println(steps);
}


void sendToC64() {
  // TODO:
}
