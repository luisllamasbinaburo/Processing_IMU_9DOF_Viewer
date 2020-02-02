import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;

Serial arduinoPort;
float roll, pitch, yaw;

void setup()
{
  size (1280, 768, P3D);
  arduinoPort = new Serial(this, "COM4", 115200); // starts the serial communication
  arduinoPort.bufferUntil('\n');
  }

void draw()
{
  drawBackground();
    
  rotateY(radians(-yaw)); 
  rotateX(radians(-pitch));
  rotateZ(radians(-roll));

  drawCube();
}

void drawBackground() {
  translate(width/2, height/2, 0);
  background(#374046);
  fill(200, 200, 200); 
  textSize(32);
  text("Roll: " + int(roll) + "     Pitch: " + int(pitch) + "     Yaw: " + int(yaw) , -200, -320);
}

void drawCube() {
  strokeWeight(1);
  stroke(255, 255, 255);
  fill(#607D8B); 
  box (500, 40, 300);
  
  strokeWeight(4);
  stroke(#E81E63);
  line(0, 0, 0, 300, 0, 0);
  stroke(#2196F2);
  line(0, 0, 0, 0, -70, 0);
  stroke(#8BC24A);
  line(0, 0, 0, 0, 0, 200);
}

void serialEvent (Serial myPort) { 
  String data = myPort.readStringUntil('\n');
  if (data != null) {
    data = trim(data);
    String items[] = split(data, ';');
    if (items.length > 1) {
      roll = float(items[0]);
      pitch = float(items[1]);
      yaw = float(items[2]);
    }
  }
}
