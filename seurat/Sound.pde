
import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

class Sound {
  
  Minim minim;
  AudioOutput out;
  
  Sound() {
    
    minim = new Minim( this );
    out = minim.getLineOut( Minim.MONO, 1024 );
  }
 
  void pulse(float pitch, float pulseFreq, float pulseWidth, float delay) {
    
      out.playNote( delay, pulseWidth, pitch  );  
  }
  
  void play() {
  
  int effectiveFrameRate = 4; // + 4*int(abs(sin(TWO_PI*(frameCount/1000)))); 
  
  // freq1 = hue of frame 0, pulseWidth = 
  float freq1 = map( frameSet.frame[0].hue_(), 0, 360, 60, 120 );
  float pulseWidth1 = map( frameSet.frame[0].particles[0].x, 0, frameSet.frame[0].w, 0.1, 0.4 );
  
  float freq2 = map( frameSet.frame[0].hue_(), 0, 360, 120, 240 );
  float pulseWidth2 = map( frameSet.frame[0].particles[0].y, 0, frameSet.frame[0].h, 0.05, 0.2 );
  
  float freq3 = map( frameSet.frame[1].hue_(), 0, 360, 90, 180 );
  float pulseWidth3 = map( frameSet.frame[1].particles[0].x, 0, frameSet.frame[0].w, 0.1, 0.4 );
  
  float freq4 = map( frameSet.frame[1].hue_(), 0, 360, 180, 360 );
  float pulseWidth4 = map( frameSet.frame[1].particles[0].y, 0, frameSet.frame[0].h, 0.05, 0.2 );
  
  if (frameCount % effectiveFrameRate == 0) {
    
    pulse(freq1, 0, pulseWidth1, 0);
    pulse(freq2, 0, pulseWidth2, 0.05);
    if (frameCount > frameSet.frame[1].phase) {
      pulse(freq3, 0, pulseWidth3, 0.25);
      pulse(freq4, 0, pulseWidth4, 0.20);
    }
  }  // play
}

  void stop(){
    out.close();
    minim.stop();
  }
  
}
