
import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;


class Sound {

  Minim minim;
  AudioOutput out;
  
  float volume = 1;
  
  float C0 = 256;
  float C = 256;
  float hs = 1.05946309435930;
  float ws = hs*hs;
  float m3 = hs*ws;
  float M3 = ws*ws;
  float p4 = M3*hs;
  float tt = p4*hs;
  float p5 = tt*hs;
  float m6 = p5*hs;
  float M6 = m6*hs;
  float m7 = M6*hs;
  float M7 = m7*hs;
 float oct = 2; 
  
  
  float Cs = hs*C;
  float D = hs*Cs;
  float Ds = hs*D;
  float E = hs*Ds;
  float F = hs*E;
  float Fs = hs*F;
  float G = hs*Fs;
  float Gs = hs*G;
  float A = hs*Gs;
  float As = hs*A;
  float B = hs*As;
  float C2 = hs*B;
  float D2 = 2*D;
  
  

  Sound() {

    minim = new Minim( this );
    out = minim.getLineOut( Minim.MONO, 1024 );
  }

  void pulse(float pitch, float pulseFreq, float pulseWidth, float delay) {

    out.playNote( delay, pulseWidth, pitch  );
    println(pitch);
  }
  
  void pulse2(float pitch, float pulseFreq, float pulseWidth, float delay, float ptLength) {
    
    float select = random(0,6);
    if (select < 1) {
      C = 0.5*C0;
    } else if (select < 2) {
      C = 2*C0/3;
    } else if (select < 3){
      C = C0;
    } else if (select < 4) {
      C = 5*C0/6; 
    }
    else if (select < 5) {
      C = 4*C0/3.0;
    } else {
      C = 3*C0/2; 
    }
    
    
    ptLength = 1 + 8*phase*ptLength;

    float noteSpacing = random(0.1, 0.2);
    for (int i = 0; i < 4*random(ptLength); i++) {
      out.playNote( delay + i*noteSpacing, pulseWidth, new ToneInstrument( pitch, volume, out ));
    }
   
   //  println(pitch);
  }
  
  void pulse3(float pitch, float pulseFreq, float pulseWidth, float delay, float ptLength, float interval) {
    
    float select = random(0,5);
    if (select < 1) {
      C = 0.5*C0;
    } else if (select < 2) {
      C = 4*C0/3.0;
    } else if (select < 3){
      C = C0;
    } else if (select < 4) {
      C = 5*C0/26; 
    } else {
      C = 3*C0/2; 
    }
    
    
    ptLength = 1 + 8*phase*ptLength;

    float noteSpacing = random(0.1, 0.2);
    float p = pitch;
    for (int i = 0; i < 4*random(ptLength); i++) {
      float r = random(0,1);
      if (r < 0.5) {
         p = p*interval;
      } else {
        p = p/interval;
      }
      out.playNote( delay + i*noteSpacing, pulseWidth, new ToneInstrument( p, volume, out ));
    }
   
   //  println(pitch);
  }
  
 
  

  void play() {

    int effectiveFrameRate = 90; // + 4*int(abs(sin(TWO_PI*(frameCount/1000)))); 
    
    if (phase > -1) {
   

    // freq1 = hue of frame 0, pulseWidth = 
    float f1 = map( frameSet.frame[0].hue_(), 0, 360, 60, 120 );
    float freq1 = C; if (f1 < 100) { freq1 = C; } else { freq1 = E; }
    float pulseWidth1 = map( frameSet.frame[0].particles[0].x, 0, frameSet.frame[0].w, 0.4, 0.6 );
    float t1 = map( frameSet.frame[0].particles[0].x, 0, frameSet.frame[0].w, 0, 1 );

    float f2 = map( frameSet.frame[0].hue_(), 0, 360, 120, 240 );
    float freq2 = C; if (f2 < 180) { freq1 = G; } else { freq1 = As; }
    float pulseWidth2 = map( frameSet.frame[0].particles[0].radius, frameSet.minRadius, frameSet.maxRadius, 0.4, 0.6 );
    float t2 = map( frameSet.frame[0].particles[0].radius, frameSet.minRadius, frameSet.maxRadius, 0,1 );

    float f3 = map( frameSet.frame[1].hue_(), 0, 360, 90, 180 );
    float freq3 = C; if (f3 < 100) { freq1 = G; } else { freq1 = B; }
    float pulseWidth3 = map( frameSet.frame[1].particles[0].x, 0, frameSet.frame[0].w, 0.1, 0.4 );
    float t3 = map( frameSet.frame[1].particles[0].x, 0, frameSet.frame[0].w, 0, 1);

    float f4 = map( frameSet.frame[1].hue_(), 0, 360, 180, 360 );
    float freq4 = C; if (f1 < B) { freq1 = 180; } else { freq1 = D2; }
    float pulseWidth4 = map( frameSet.frame[1].particles[0].y, 0, frameSet.frame[0].h, 0.05, 0.2 );
    float t4 = map( frameSet.frame[1].particles[0].y, 0, frameSet.frame[0].h, 0, 1 );
    
    

    if (frameCount % effectiveFrameRate == 0) {
      println("1");
      pulse2(freq1, 0, pulseWidth1, 0, t1);
      pulse2(freq2, 0, pulseWidth2, 0.1, t2);
      if (phase > 0.5 ) {
        println("2");
        pulse3(freq3, 0, 0.4, 5, t3, hs);
        pulse3(freq4, 0, pulseWidth4, 5.20, t4, ws);
      }
      if (phase > 1) {
        pulse3(freq3, 0, 0.4, 10, t3, m3);
        pulse3(freq4, 0, pulseWidth4, 10.20, t4, M3);
      }
    }  // play
    
    }
  }

  void stop() {
    out.close();
    minim.stop();
  }
}
