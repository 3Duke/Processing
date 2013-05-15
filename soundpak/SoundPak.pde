/* pitchNameExample
   is an example of using the pitch names for notes instead
   of the frequency in Hertz or the midi note number.  This is
   achieved in the pitchNameInstrument using the ofPitch() and
   asHz() methods of the Frequency class.
   author: Anderson Mills
   Anderson Mills's work was supported by numediart (www.numediart.org)
*/

// import everything necessary to make sound.
import ddf.minim.*;
import ddf.minim.ugens.*;

// create all of the variables that will need to be accessed in
// more than one methods (setup(), draw(), stop()).
Minim minim;
AudioOutput out;

// setup is run once at the beginning
void setup()
{
  // initialize the drawing window
  size( 512, 200, P2D );
  
  String [ ] notes  = {"C3", "D3", "E3"};
  float [ ] durations = { 1.0, 0.5, 0.5};
  // float [ ] bar = { 0.9 };
  NoteSequence ns1 = new NoteSequence( notes, durations, 6, "foo");
  
  float [ ] freqs = { 256, 356, 456 };
  float [ ] durations2 = { 0.2, 0.1, 0.1};
  NoteSequence ns2 = new NoteSequence( freqs, durations2, 9, "bar");
  
  NoteSequence ns3 =  ns1.copy();
  ns3.reverse_(); 
  ns3.name = "foobar";
 

  // initialize the minim and out objects
  minim = new Minim( this );
  out = minim.getLineOut( Minim.MONO, 2048 );
  
  // pause time when adding a bunch of notes at once
  // This guarantees accurate timing between all notes added at once.
  out.pauseNotes();
  
  // set the tempo for the piece
  out.setTempo( 90.0 );
  
  // a pause before the music starts
  out.setNoteOffset( 2.0 );

  // using a single parameter to control the amplitude (volume) of all notes
  float vol = 0.33;
  
  ns2.transposeDown("OC");
  ns2.timeScale = 0.5;
  
  Voice voice = new Voice(ns1, "Test voice");
  // voice.transposeUp("UN");
  // voice.transposeNotes();
  // voice.appendPiece(ns2);
  // voice.appendPiece(ns3);
  
  Voice voice2 = voice.copy(voice, "Test voice 2");
  voice2.transposeUp("M3");
  voice2.transposeNotes();
  
  Voice voice3 = voice.copy(voice, "Test voice 3");
  voice3.transposeUp("P5");
  
  Voice voice4 = voice.copy(voice, "Test voice 4");
  voice4.transposeUp("M7");
  
  voice.report();
  voice2.report();
  // voice3.report();
  // voice4.report();
  
  voice.play(0, 1.0);
  voice2.play(voice.duration(), 1.0);
  // voice3.play(0, 1.0);
  // voice4.play(0, 1.0);
  

  // finally, resume time after adding all of these notes at once.
  out.resumeNotes();
 }

// draw is run many times
void draw()
{
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

// stop is run when the user presses stop
void stop()
{
  // close the AudioOutput
  out.close();
  // stop the minim object
  minim.stop();
  // stop the processing object
  super.stop();
}
