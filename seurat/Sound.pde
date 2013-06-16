
import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;


 class NoteSequence {
    
    // float pulse4(float delay, float noteSpacing, float pitch, float pulseDuration,  int numberOfPulses, float minFreq, float maxFreq) { 
    float delay;
    float noteSpacing;    
    float startingPitch;   
    float noteDuration;
    int numberOfNotes;   
    float minPitch;        
    float maxPitch;       
    int [ ] score;
    float volume;
    int meter;
    int notesPerBeat;
    Sound sound;
    
    NoteSequence(Sound sound_) {
      
      sound = sound_;
      volume = 1;
      
    }
    
    
    float playFromScore(float [] intervals, int direction, int beatsPerPhrase_, float startingPitch_, int phase) {
    if (sound.phaseIsActive( phase , score)) {
        return  play(intervals, 0, beatsPerPhrase_, startingPitch_);  
      } else {
        return startingPitch_;
      }
    }
    
    
    float play(float [] intervals, int direction, int beatsPerPhrase_, float startingPitch_) { 

      numberOfNotes = notesPerBeat*beatsPerPhrase_;
      startingPitch = startingPitch_;
      
      float p = startingPitch;
      for (int i = 0; i < numberOfNotes; i++) {
        
        int  index = int(random(0, intervals.length));
        float interval = intervals[index];
          
        float r = random(0,1);
        if (direction == 0)  {
          if (r < 0.5) {
             p = p*interval;
          } else {
            p = p/interval;
          }
        }
        
        if (direction == 1) {
          p = p*interval;
        }
        
        if (direction == -1) {
          p = p/interval;
        }
        
        if (p < minPitch) {
          p = 1.5*p;
        }
        if (p > maxPitch) {
          p = p/1.5;
        }
        
        // Introduce a rest
        float localVolume = volume;
        float rest = random(0,1);
        if (rest < 0.1) {
          localVolume = 0;
        }
        
        if (i % meter == 0) { // Introduce meter
          localVolume = 1.5*localVolume;
        }
        
       // Shape phrase
       /*
       float b = (1 + sin(3.1416*i/numberOfNotes))/2;
       localVolume = b*b*localVolume;
       */
        
       sound.out.playNote( delay + i*noteSpacing, noteDuration, new ToneInstrument( p, localVolume, sound.out ));
        
      }
     return p;
    }
  
    
    void playNotes(float [] notes, int index, int numberOfNotes, int direction, float transpositionFactor) {
      
      int count = 0;
      
      if (numberOfNotes < 1) {
        numberOfNotes = notes.length;
      }
      
      if (index < 0) {
        index = int(random(0,notes.length));
      }
      
      while (count < numberOfNotes) {
        
        float p = notes[index];
        p = transpositionFactor*p;
        sound.out.playNote( delay + count*noteSpacing, noteDuration, new ToneInstrument( p, volume, sound.out ));
        count++;
        
        if (direction > 0) {
          index++;
        } else {
          index--;
        }
        
        if (index < 0) {
          index = notes.length - 1;
        }
        
        if (index >= notes.length) {
          index = 0;
        }
      }
      
      
    }
    
  } // end class NoteSequence

class Sound {

  Minim minim;
  AudioOutput out;

  float baseVolume = 2;
  float volume = baseVolume;
  
  // Notes and intervals:
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
  float Db = Cs;
  float D = hs*Cs;
  float Ds = hs*D;
  float Eb = Ds;
  float E = hs*Ds;
  float F = hs*E;
  float Fs = hs*F;
  float Gb = Fs;
  float G = hs*Fs;
  float Gs = hs*G;
  float Ab = Gs;
  float A = hs*Gs;
  float As = hs*A;
  float Bb = As;
  float B = hs*As;
  float C2 = hs*B;
  float D2 = 2*D;
  float D2s = 2*Ds;
  float E2 = 2*E;
  float F2 = 2*F;
  float F2s = 2*Fs;
  float G2 = 2*G;
  float G2s = 2*Gs;
  float A2 = 2*A;
  float A2s = 2*As;
  float B2 = 2*B;
  float C3 = 2*C2;

  
  float intervals[ ] = { hs, hs, ws, ws, ws, m3, M3, p4, p5, m6, M6 };
  float intervals2[ ] = { m3, M3, m3, M3, m3, M3, m3, M3, m3, M3, M3 };
  
  
  int sopranoScore[] = {0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1 };
  int tenorScore[] = { 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0 };
  int bassScore[] = { 0, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0 };
  
  float tempoFactor = 1;
  
  int scoreLength = 13;
  
  
  // TEMPO PARAMETERS:
  int beatsPerPhrase = 30;
  float bpm = 92;  // beats per minute
  
  // float minutesPerPhrase = beatsPerPhrase/bpm;
  // float secondsPerPhrase = 60*minutesPerPhrase;
  // float framesPerPhrase = framesPerSecond/secondsPerPhrase --- defined later
  // float framesPerPhrase = 1/(frameRate*secondsPerPhrase)
  // float framesPerPhrase = bpm/(60*frameRate*beatsPerPhrase) <<<< KEY FORMULA
  
  
  /*
  int sopranoScore[] = { 1, 0 };
  int tenorScore[] = { 0, 1, 1 };
  int bassScore[] = { 0, 0, 1, 1, 0, 1, 1 };
  
  int scoreLength = 2*3*7;
  */
 
  
  float CM7[] = { C, E, G, B, C2 };
  float bassLine1[] = { C, E, G, B,     C2, C, G, E,     F, A, C, Bb,    F2, D2, A, Fs,   D, G, D, B, G};
  float bassLine[] = { C, E, G, B,     C2, Bb, A, Ab,    G, Gb, F, E,     Eb, D, Db};


  // High and low frequencies for parts
  float sopranoLow = 120;
  float sopranoHigh = 3840;
  
  float tenorLow = 120;
  float tenorHigh = 360;
  
  float bassLow = 30;
  float bassHigh = 120;
  
 
  
  
  Sound() {

    minim = new Minim( this );
    out = minim.getLineOut( Minim.MONO, 1024 );
  
  }
  
  boolean phaseIsActive ( int phase, int[] part ) {
   
   int index = phase % part.length;
   
   if (part[index] == 1) {
     
     return true;
     
   } else {
     
     return false;
     
   }
   
  }

  void pulse(float pitch, float pulseFreq, float pulseWidth, float delay) {
    
    // emit pulse of given pitch and duration (pusleWidth) after given delay

    out.playNote( delay, pulseWidth, pitch  );
    
  }
  
  
   float selectFrequency() {
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
      return C;
   }
  
  void pulseTrain2(float delay, float noteSpacing, float pitch, float pulseDuration, int numberOfPulses) {
       
  // play pulse train of given lenght (ptLength), pitch, and pulseWidth
    
    for (int i = 0; i < numberOfPulses; i++) {
      out.playNote( delay + i*noteSpacing, pulseDuration, new ToneInstrument( pitch, volume, out ));
    }
   
   //  println(pitch);
  }
  
   
  
  float sopranoFreq = (3.0/2)*selectFrequency();
  float bassFreq = selectFrequency()/2;
  float tenorFreq = selectFrequency();
  
  void test() {
    
      
      float freq = 440;
    
      NoteSequence soprano = new NoteSequence(sound);
      soprano.noteSpacing = 2;
      soprano.noteDuration = 1;
      soprano.minPitch = sopranoLow;
      soprano.maxPitch = sopranoHigh;
      
      int beatsPerPhrase = 5;
      float framesPerPhrase = bpm/(60*frameRate*beatsPerPhrase);
     
      if (frameCount % framesPerPhrase == 20) {
        soprano.playNotes(CM7, 0, 4, 1, 1.0/2);
       // void playNotes(float [] notes, int index, int numberOfNotes, int direction) 
      } 
      // float play(float [] intervals, int direction, int numberOfNotes_, float startingPitch_, int beatsPerMeasure)
       
       
      
    
  }
   
  void play() {
    
    
    int maxNoteSequenceLengthParameter = 12;
   
    // Impose periodic amplitude profile
    if (frameCount % period < onPeriod) {
      float a = sin(3.1416*(frameCount % onPeriod)/onPeriod);
      volume = a*a*baseVolume;
    } else {
      volume = 0;
    }

   
     /// Modulus 150 work
    
    int beatsPerPhrase = 10;
    float framesPerPhrase =   60*frameRate*beatsPerPhrase/bpm;                 // bpm/(60.0*frameRate*beatsPerPhrase);
    
    // if ((frameCount % int(noteFrameSize/tempoFactor) == 20) && (frameCount % period < onPeriod)) {
      
  
    if (frameCount % int(framesPerPhrase) == 0)  {
      
      /*
      println("\n@@@ framesPerPhrase: "+nfc(int(framesPerPhrase)));
      println("frameRate: "+nfc(frameRate));
      println(" ");
      */
      
      float bps = bpm/60.0;
      float beatSpacing = 1/bps;
      
      println("@ framecount "+nfc(frameCount)+", bpm = "+nfc(bpm,2));
    
      
      // int numberOfPulses = 1 + frameCount % 64;
      
      int bpp =  (8 + int(random(0,maxNoteSequenceLengthParameter) + 0.01));  // 20 beats max
      println("bpp: "+nfc(bpp,1));
      
      NoteSequence soprano = new NoteSequence(sound);
      soprano.notesPerBeat = 3;
      soprano.noteSpacing = beatSpacing/soprano.notesPerBeat; // triplets
      soprano.volume = 0.66;
      soprano.noteDuration = 0.005;
      soprano.minPitch = sopranoLow;
      soprano.maxPitch = sopranoHigh;
      soprano.meter = 3;
      soprano.score = sopranoScore;
      
      sopranoFreq = soprano.playFromScore(intervals, 0, bpp, sopranoFreq, phase);
      
      NoteSequence tenor = new NoteSequence(sound);
      tenor.notesPerBeat = 3;
      tenor.noteSpacing = beatSpacing/tenor.notesPerBeat; // triplets
      tenor.volume = 0.66;
      tenor.noteDuration = 0.1;
      tenor.minPitch = tenorLow;
      tenor.maxPitch = tenorHigh;
      tenor.meter = 4;
      tenor.score = tenorScore;
      
      bpp =  (8 + int(random(0,maxNoteSequenceLengthParameter) + 0.01));  // 20 beats max
      
      tenorFreq = tenor.playFromScore(intervals, 0, bpp, tenorFreq, phase);
      
      // Determine direction of Brownian path through the interval array:
      // -1 for down, 0 for no direciotn, +1 for up.
      float r2 = random(0,3);
      int direction = 0;
      
      if (r2 < 1) {
        direction = -1;
      } else if (r2 < 2) {
        direction = 0;
      } else {
        direction = 1;
      }
     
      // numberOfPulses = (8 + int(random(0,8) + 0.1));
      bpp = (8 + int(random(0,maxNoteSequenceLengthParameter) + 0.01));  // 20 beats max
      
      NoteSequence bass = new NoteSequence(sound);
      bass.notesPerBeat = 1;
      bass.noteSpacing = beatSpacing/bass.notesPerBeat; // triplets
      bass.volume = 2  ;
      bass.noteDuration = 0.005;
      bass.minPitch = bassLow;
      bass.maxPitch = bassHigh;
      bass.meter = 5;
      bass.score = bassScore;
            
      bassFreq = bass.playFromScore(intervals, direction, bpp, bassFreq, phase);
      // bass.playNotes(bassLine, -1, numberOfPulses/2, 1, 1.0/2);      
    } 
  }
  

  void stop() {
    out.close();
    minim.stop();
  }
  
}
