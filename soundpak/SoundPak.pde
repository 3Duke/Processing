/* 
   
*/

import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput out;

int p = 1;
String className;




void setup()
{
  
  String className = this.getClass().getName();
  println("className: "+className);
  
         // Class clazz = Class.forName("Demo");
        // Demo demo = (Demo) clazz.newInstance();
 

  size( 512, 200, P2D );
  minim = new Minim( this );
  out = minim.getLineOut( Minim.MONO, 2048 );
  
  /////////////////////////////////////////////////////////////////////
  // Set up the music
  
  String [ ] notes  = {"C3", "D3", "E3"};
  float [ ] durations = { 1.0, 0.5, 0.5};
  // float [ ] bar = { 0.9 };
  NoteSequence ns1 = new NoteSequence( notes, durations, 6, "foo");
  ns1.instrumentName = "FooInstrument";
  NoteSequence ns1b = new NoteSequence( notes, durations, 6, "foo");
  ns1b.instrumentName = "SPInstrument";
  
  float [ ] freqs = { 256, 356, 456 };
  float [ ] durations2 = { 0.2, 0.1, 0.1};
  NoteSequence ns2 = new NoteSequence( freqs, durations2, 20, "bar");
  ns2.instrumentName = "SPInstrument";
  
  NoteSequence ns3 =  ns1.copy();
  ns3.reverse_(); 
  ns3.name = "foobar";
 // ns2.transposeDown("UN");
  // ns2.timeScale = 0.5;
  
  Voice voice = new Voice(ns1, "Test voice");
  // voice.appendPiece(ns2);
  // voice.appendPiece(ns3);
  Voice voice1b = new Voice(ns1b, "Test voice B");
 
  // Voice voice2 = new Voice(ns2, "Test voice 2"); 
  Voice voice2 = voice.copy(voice, "Test voice 2");
  // voice2.transposeUp("OC");
  
  // Voice voice3 = voice.copy(voice, "Test voice 3");
  // voice3.transposeUp("P5");
  
  // Voice voice4 = voice.copy(voice, "Test voice 4");
 // voice4.transposeUp("M7");
  
  voice.report();
  voice1b.report();
  // voice3.report();
  // voice4.report();
  
   /////////////////////////////////////////////////////////////////////
 
  // pause time when adding a bunch of notes at once
  // This guarantees accurate timing between all notes added at once.
  out.pauseNotes();
  
  // set the tempo for the piece
  out.setTempo( 90.0 );
  
  // a pause before the music starts
  out.setNoteOffset( 2.0 );

  // using a single parameter to control the amplitude (volume) of all notes
  float vol = 0.33;
   
  
  //voice.play(0, 1.0);
  // voice1b.play(voice.duration(), 1.0);
  voice1b.play(0, 1.0);
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  voice2.play(voice.duration(), 1.0);
  // voice3.play(0, 1.0);
  // voice4.play(0, 1.0);

  // finally, resume time after adding all of these notes at once.
  out.resumeNotes();
 }

// draw is run many times
void draw()
{
  drawWaveform();
  
}

void drawWaveform() {
  
   // erase the window to black
  background( 64, 64, 192 );
  // draw using a white stroke
  stroke( 64, 192, 64 );
  // draw the waveforms
  for( int i = 0; i < out.bufferSize() - 1; i++ )
  {
    // find the x position of each buffer value
    float x1  =  map( i, 0, out.bufferSize(), 0, width );
    float x2  =  map( i+1, 0, out.bufferSize(), 0, width );
    // draw a line from one buffer position to the next for both channels
    line( x1, 50 + out.left.get(i)*50, x2, 50 + out.left.get(i+1)*50);
    line( x1, 150 + out.right.get(i)*50, x2, 150 + out.right.get(i+1)*50);
  } 
  
}


void stop()
{
  out.close();
  minim.stop();
  super.stop();
}
