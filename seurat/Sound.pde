
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
    float restProbability;
    float doubleNoteProbability;
    int beatsOfPhraseOverlap;
    Sound sound;
    
    NoteSequence(Sound sound_) {
      
      sound = sound_;
      volume = 1;
      restProbability = 0.1;
      
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
        float localVolume = volume*sound.volume;
        float rest = random(0,1);
        if (rest < restProbability) {
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
        
       
       float r2 = random(0,1);
       if (r2 < doubleNoteProbability) {
         float r3 = random(0,1);
         if (r3 > 0.3) {
           sound.out.playNote( delay + i*noteSpacing, noteDuration/2.0, new ToneInstrument( p, localVolume, sound.out ));
         }
         sound.out.playNote( delay + (i +0.5)*noteSpacing, noteDuration/2.0, new ToneInstrument( p, localVolume, sound.out ));
       } else {
         sound.out.playNote( delay + i*noteSpacing, noteDuration, new ToneInstrument( p, localVolume, sound.out ));
       }
       
        
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
  
  NoteSequence soprano, alto, tenor, bass;

  float baseVolume = 1;
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
  
  
  int silent []      = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
  int all []         =  { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
  
  /*
  int sopranoScore[] =  silent; //{ 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1 };
  int altoScore[]    =  { 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 1 };
  int tenorScore[]   =  { 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0 };
  int bassScore[]    =  { 0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1 };
  */
  
  //{ 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1 };
  int sopranoScore[] =  { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1 };
  int altoScore[]    =  { 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0 };
  int tenorScore[]   =  { 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1 };
  int bassScore[]    =  { 0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1 };
  
  float sopranoFreq, altoFreq, tenorFreq, bassFreq;
  
  float tempoFactor = 1;
  
  int scoreLength = 26;
  
  
  // TEMPO PARAMETERS:
  int beatsPerPhrase; // = 15;
  float bpm; // = 112;  // beats per minute
  int framesPerPhrase = 1; // set later
 
  
  float CM7[] = { C, E, G, B, C2 };
  float bassLine1[] = { C, E, G, B,     C2, C, G, E,     F, A, C, Bb,    F2, D2, A, Fs,   D, G, D, B, G};
  float bassLine[] = { C, E, G, B,     C2, Bb, A, Ab,    G, Gb, F, E,     Eb, D, Db};
    
  
  Sound( int beatsPerPhrase_, float bpm_) {
    
    beatsPerPhrase = beatsPerPhrase_;
    bpm = bpm_;

    minim = new Minim( this );
    out = minim.getLineOut( Minim.MONO, 1024 );
    
    sopranoFreq = 540;
    altoFreq = 360;
    tenorFreq = 180; 
    bassFreq = 90;
    
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
  
  void setSoprano( float beatSpacing) {
    
      soprano = new NoteSequence(sound);
      soprano.notesPerBeat = 4;
      soprano.noteSpacing = beatSpacing/soprano.notesPerBeat; // triplets
      soprano.volume = 0.26;
      soprano.noteDuration = 0.005;
      soprano.minPitch = 405;
      soprano.maxPitch = 810;
      soprano.meter = 4;
      soprano.restProbability = 0.16;
      soprano.doubleNoteProbability = 0.1;
      soprano.beatsOfPhraseOverlap = 5;
      soprano.score = sopranoScore;
    
  }
  
  void setAlto( float beatSpacing) {
    
      alto = new NoteSequence(sound);
      alto.notesPerBeat = 2;
      alto.noteSpacing = beatSpacing/alto.notesPerBeat; // triplets
      alto.volume = 0.36;
      alto.noteDuration = 0.005;
      alto.minPitch = 270;
      alto.maxPitch = 540;
      alto.meter = 4;
      alto.restProbability = 0.16;
      alto.doubleNoteProbability = 0.1;
      alto.beatsOfPhraseOverlap = 10;
      alto.score = altoScore;
    
  }
  
  void setTenor(float beatSpacing) {
    
    tenor = new NoteSequence(sound);
      tenor.notesPerBeat = 2;
      tenor.noteSpacing = beatSpacing/tenor.notesPerBeat; // triplets
      tenor.volume = 0.66;
      tenor.noteDuration = 0.1;
      tenor.minPitch = 90;
      tenor.maxPitch = 360;
      tenor.meter = 4;
      tenor.restProbability = 0.13;
      tenor.doubleNoteProbability = 0.06;
      tenor.beatsOfPhraseOverlap = 8;
      tenor.score = tenorScore;
  }
  
  void setBass(float beatSpacing) {
    
      bass = new NoteSequence(sound);
      bass.notesPerBeat = 1;
      bass.noteSpacing = beatSpacing/bass.notesPerBeat; // triplets
      bass.volume = 2;
      bass.noteDuration = 0.005;
      bass.minPitch = 30;
      bass.maxPitch = 120;
      bass.meter = 5;
      bass.restProbability = 0.06;
      bass.doubleNoteProbability = 0.06;
      bass.beatsOfPhraseOverlap = 10;
      bass.score = bassScore;
      
  }
  
  void setupVoices() {
      
      float bps = bpm/60.0;
      float beatSpacing = 1/bps;
     
      setSoprano(beatSpacing);
      setAlto(beatSpacing);
      setTenor(beatSpacing);
      setBass(beatSpacing);  
  }
  
  int direction() {
    
    // Determine direction of Brownian path through the interval array:
      // -1 for down, 0 for no direciotn, +1 for up.
      float r2 = random(0,3);
      int direction_ = 0;
      
      if (r2 < 1) {
        direction_ = -1;
      } else if (r2 < 2) {
        direction_ = 0;
      } else {
        direction_ = 1;
      }
      
      return direction_;
  }
   
  void play() {
    
    
    framesPerPhrase = int(60*frameRate*beatsPerPhrase/bpm);     
  
    if (frameCount % int(framesPerPhrase) == 0)  {
          
      int bpp =  int(random(8,beatsPerPhrase) + soprano.beatsOfPhraseOverlap); 
      sopranoFreq = soprano.playFromScore(intervals, 0, bpp, sopranoFreq, phase);
      
      bpp =  int(random(8,beatsPerPhrase) + alto.beatsOfPhraseOverlap); 
      altoFreq = alto.playFromScore(intervals, direction(), bpp, altoFreq, phase);
      
      bpp =  int(random(8,beatsPerPhrase) + tenor.beatsOfPhraseOverlap); 
      tenorFreq = tenor.playFromScore(intervals, direction(), bpp, tenorFreq, phase);
        
      bpp =  int(random(8,beatsPerPhrase) + bass.beatsOfPhraseOverlap); 
      bassFreq = bass.playFromScore(intervals, 0, bpp, bassFreq, phase);
         
    } 
  }
  

  void stop() {
    out.close();
    minim.stop();
  }
  
}
