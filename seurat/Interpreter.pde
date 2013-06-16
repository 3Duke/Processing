
String [ ] opNames = { 
  "alpha", "color", "radius", "shape", "framerate", "colorvelocity", "currentradius" };
// alpha: 0
// color: 1
// radius: 2 // radius 1.0 10.0
// shape: 3  // shape quad
// framerate: 4
// colorvelocity: 5
// currentradius: 6

String [ ] shapes = { 
  "circle", "triangle", "square", "quad", "*", "s", "L", "W"
};

int index(String probe, String [ ] names) {

  int index = -1;

  for (int i = 0; i < names.length; i++) {

    if (probe.equals(names[i])) {
      index = i;
      break;
    }
  }
  return index;
}

class Instruction {

  int opcode;
  String name;
  String [] args;
  int frame; 


  Instruction( String input) {

    args = splitTokens(input, " ");
    name = args[1];
    opcode = index(name, opNames);
    frame = int(args[0]);
  }
} // end class Instruction


class Interpreter {

  Instruction [] program; // program = array of instructions
  int programLength;
  int instructionPointer;
  Instruction currentInstruction;
  boolean running;
 
  
   Interpreter(String fileName) {
    
    String lines[] = loadStrings(fileName);
      println(fileName+" has " + lines.length + " lines:\n");
      for (int i = 0 ; i < lines.length; i++) {
        println(lines[i]);
      }
      println("\n");
      
     Instruction [] prog = new Instruction[lines.length];
     
     for (int i = 0; i < lines.length; i++) {
        prog[i] = new Instruction(lines[i]); 
     }
     
     program = prog;
     
    programLength = program.length;
    instructionPointer = 0;
    currentInstruction = program[instructionPointer];
    running = true;
  }
  
  
  Interpreter( Instruction[] prog_ ) {

    program = prog_;
    programLength = program.length;
    instructionPointer = 0;
    currentInstruction = program[instructionPointer];
    running = true;
  }

  void run(int currentFrame) {

    if (running && (currentFrame == currentInstruction.frame)) {

      execute(currentInstruction);

      instructionPointer++;

      if (instructionPointer == programLength) 
      {
        running = false;
        println("Interpreter: HALT");
      } 
      else 
      {
        currentInstruction = program[instructionPointer];
      }
    }
  }

  void execute( Instruction instr ) {

    println("At "+frameCount+", executed "+instr.name);
    switch(instr.opcode) {

    case 0:
      frameSet.frameAlpha = int(instr.args[2]);
      break;

    case 1: // set color tori
      int r1 = int(instr.args[2]);
      int g1 = int(instr.args[3]);
      int b1 = int(instr.args[4]);
      int r2 = int(instr.args[5]);
      int g2 = int(instr.args[6]);
      int b2 = int(instr.args[7]); 
      colorMode(RGB, 255, 255, 255, 255);
      frameSet.c1 = color(r1, g1, b1, 255);
      frameSet.c2 = color(r2, g2, b2, 255);
      frameSet.setColorTori2();
      controller.colorBox1.setColor(frameSet.c1);
      controller.colorBox2.setColor(frameSet.c2);
      break;

    case 2: // set maxRadius an minRadius
      frameSet.minRadius = float(instr.args[2]);
      frameSet.maxRadius = float(instr.args[3]);
      controller.radiusSlider.setValue(frameSet.maxRadius);
      controller.radiusSlider.setValue2(frameSet.minRadius);
      break;

    case 3: // set shape
      frameSet.setParticleType(index(instr.args[2], shapes));
      break;

    case 4: // set frameRate
      responder.manageFrameRate(float(instr.args[2]));
      controller.speedSlider.setValue(frameSet.baseFrameRate); 
      break;

    case 5: // set color velocity
      frameSet.colorVelocity = float(instr.args[2]);
      controller.colorVelocitySlider.setValue(frameSet.colorVelocity);
      frameSet.setParticleColorVelocities(frameSet.colorVelocity);
      
      
    case 6: // set current radius
      frameSet.setParticleRadii(float(instr.args[2]), 0.95);
      break;
    
    
    } // end switch
  }  // end execute
} // end class Interprete
