
import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

int direction() {
    
    // Determine direction of Brownian path through the interval array:
      // -1 for down, 0 for no direciotn, +1 for up.
      float r2 = random(0, 1);
      int direction_ = 0;
      
      if (r2 < 0.5) {
        direction_ = 1;
      } else {
        direction_ = -1;
      }
      
      return direction_;
  }
  
 class ScorePart {
   
   boolean plays;
   
   ScorePart ( String e ) {
     if (e.equals("1")) {
       plays = true;
     } else {
       plays = false;
     }
   } 
   
 } // end class ScorePart
 
 class Score {
   
   ScorePart [ ] score;
   
   Score ( String text ) {
    
    String [ ] symbols = split(text, " ");
    int n = symbols.length;
    score = new ScorePart[n];
    
    for (int i = 0; i < symbols.length; i++) {
     score[i] = new ScorePart(symbols[i]); // expects "1" or "0"
    } 
     
   } // end initializer Score
   
   void display() {
     println("displaying score:");
     for (int i = 0; i < score.length; i++) {
       if (score[i].plays == true) {
         print("1 ");
       } else {
         print ("0 " );
       }
       println("");
     }
   } //end display
   
 } // end class Score
 
  
 class NoteSequence {
      
    float delay;
    
    float noteSpacing;    
    float noteDuration;
    int numberOfNotes; 
    int meter;
    int notesPerBeat;
    float restProbability;
    float doubleNoteProbability;
    float pickupProbability = 0.02;
    
    float startingPitch;
    float currentPitch;
    float lastPitch;
    float minPitch;        
    float maxPitch;
    float newIntervalArrayProbability = 0.2;
    float newIntervalProbability = 0.5;
    float newPitchDirectionProbability = 0.3;
    
    float [][] intervalArray;
    int intervalArrayIndex;
    int intervalIndex;
    int currentDirection;
    float currentInterval;
    
    int [ ] score;
    int beatsOfPhraseOverlap;
    
    float volume;
    
    Sound sound;
    
    ////////////////////////////////////
    
    NoteSequence(Sound sound_) {
      
      sound = sound_;
      volume = 1;
      restProbability = 0.1;
      
    }
    
    
    void playFromScore(int beatsPerPhrase_, int phase) {
      
    if (sound.phaseIsActive( phase , score)) {
        play(beatsPerPhrase_);  
      } 
    }
     
  void play(int beatsPerPhrase_) { 
    
      // println("\n\nPLAY:\n");
      sound.out.pauseNotes();
      
      
      numberOfNotes = notesPerBeat*beatsPerPhrase_;
      // startingPitch = startingPitch_;
      
      lastPitch = startingPitch;
      // println("Starting pitch: "+nfc(lastPitch,1));
      currentDirection = direction();
      intervalArrayIndex = 0;
      intervalIndex = 0;
      currentInterval = sound.hs;
      
      int numberOfRepeatedNotes = 0;
      
      for (int i = 0; i < numberOfNotes; i++) {
        
        float r = random(0,1);
        
        /////////////// Choose interval and direction ///////////////
        
        if (r < newIntervalArrayProbability) { // choose new interval array
            intervalArrayIndex = int(random(0, intervalArray.length));
        }
        
        r  = random(0,1);
        if (r < newIntervalProbability) { // Choose new interval 0.5)
          intervalIndex = int(random(0, intervalArray[intervalArrayIndex].length));
          currentInterval = intervalArray[intervalArrayIndex][intervalIndex];
        }     
        
        if (r < newPitchDirectionProbability) { // Change direction 0.3
          currentDirection = direction(); 
        }
        
        
        // print("indices = "+nfc(intervalArrayIndex)+", "+nfc(intervalIndex)+" -- ");
        
        if (currentDirection == 1) {
          currentPitch = lastPitch*currentInterval;
        }
        
        if (currentDirection == -1) {
          currentPitch = lastPitch/currentInterval;
        }
             
        if (currentPitch < minPitch) {
          currentPitch = 1.5*currentPitch;
        }
        if (currentPitch > maxPitch) {
          currentPitch = currentPitch/1.5;
        }
        
        // println(nfc(lastPitch,2)+", "+nfc(currentPitch,2));
        
        // Limit the number of times a note can be repeated:
        if (lastPitch == currentPitch) {
          numberOfRepeatedNotes++;
          if (numberOfRepeatedNotes > 1) {
            r = random(0,1);
            if (r < 0.5) {
              currentPitch = currentPitch*sound.hs;
              currentDirection = 1;
            }
            else {
              currentPitch = currentPitch/sound.hs;
              currentDirection = -1;
            }
          }
          numberOfRepeatedNotes = 0;
        }
  
        
        /////////////// End: choose interval and direction ///////////////
        
        // Introduce a rest
        float localVolume = volume*sound.volume;
        float rest = random(0,1);
        if (rest < restProbability) {
          localVolume = 0;
        }
        
        if (i % meter == 0) { // Introduce meter
          localVolume = 1.75*localVolume;
        }
       
       
       r = random(0,1);
       if (r < doubleNoteProbability) {
           sound.out.playNote( delay + i*noteSpacing, noteDuration/2.0, new ToneInstrument( currentPitch, localVolume, sound.out ));
           sound.out.playNote( delay + (i +0.5)*noteSpacing, noteDuration/2.0, new ToneInstrument( currentPitch, localVolume, sound.out ));
        }
        else if (r < doubleNoteProbability + pickupProbability) 
        {
          sound.out.playNote( delay + (i +0.5)*noteSpacing, noteDuration/2.0, new ToneInstrument( currentPitch, localVolume, sound.out ));
        }
        else
        { // play single note
           sound.out.playNote( delay + i*noteSpacing, noteDuration, new ToneInstrument( currentPitch, localVolume, sound.out ));
         }
         lastPitch = currentPitch;
      } // end loop
     startingPitch = lastPitch;
     
     sound.out.resumeNotes();
    } // end play
  
  /////////////////////////
    
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
  float un = 1;
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

  
  float intervals23456[ ] = { hs, ws, m3, M3, p4, p5, m6, M6 };
  float intervals2[ ] = { hs, ws };
  float intervals3[ ] = { m3, M3 };
  
  float [][] ia2 = { intervals2 };
  float [][] ia3 = { intervals3 };
  float [][] ia23 = { intervals2, intervals3 };
  float [][] ia23b = { intervals2, intervals2, intervals2, intervals3 };
  float [][] ia23456 = { intervals23456 };
  
  int rest [ ]       = { 0, 0 };
  int silent []      = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
  int all []         =  { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
  
  /*
  int sopranoScore[] =  silent; //{ 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1 };
  int altoScore[]    =  { 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 1 };
  int tenorScore[]   =  { 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0 };
  int bassScore[]    =  { 0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1 };
  */
  
  //{ 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1 };
  
  int soprano1 []    =  { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }; 
  int soprano2 []    =  { 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1 };
  int soprano3 []    =  { 1, 1 };
  int alto1 []       =  { 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 1 }; 
  int alto2 []       =  { 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0 };
  int alto3 []       =  { 1, 1 };
  int tenor1 []      =  { 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0 }; 
  int tenor2 [ ]     =  { 0, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1 };
  int tenor3 [ ]      =  { 1, 1 };
  int bass1 []       =  { 0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1 }; 
  int bass2 []       =  { 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1 };
  int bass3 [ ]      =  { 1, 1 };
  
  
  int sopranoScore[] = concat(concat( soprano1, soprano2), soprano3);
  int altoScore[]    = concat(concat( alto1, alto2), alto3);
  int tenorScore[]   = concat(concat( tenor1, tenor2), tenor3);
  int bassScore[]    = concat(concat( bass1, bass2), bass3);

  
  /* 
  // TEST
  int sopranoScore[] = silent;
  int altoScore[]    = silent;
  int tenorScore[]   = all;
  int bassScore[]    = all;
  */
  
  float sopranoFreq, altoFreq, tenorFreq, bassFreq;
  
  float tempoFactor = 1;
  
  int scoreLength = bassScore.length;
  
  
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
      soprano.noteDuration = 0.15*soprano.noteSpacing;
      soprano.minPitch = 405;
      soprano.maxPitch = 1012.5;
      soprano.meter = 5;
      soprano.restProbability = 0.16;
      soprano.doubleNoteProbability = 0.05;  // 0.1;
      soprano.beatsOfPhraseOverlap = 5;
      soprano.score = sopranoScore;
      
      soprano.startingPitch = 540;
      soprano.intervalArray = ia23;
    
  }
  
  void setAlto( float beatSpacing) {
    
      alto = new NoteSequence(sound);
      alto.notesPerBeat = 2;
      alto.noteSpacing = beatSpacing/alto.notesPerBeat; // triplets
      alto.volume = 0.36;
      alto.noteDuration = 0.5*alto.noteSpacing; // 0.005;
      alto.minPitch = 270;
      alto.maxPitch = 675;
      alto.meter = 3;
      alto.restProbability = 0.16;
      alto.doubleNoteProbability = 0.05;  // 0.1;
      alto.beatsOfPhraseOverlap = 10;
      alto.score = altoScore;
      
      alto.startingPitch = 270;
      alto.intervalArray = ia23;
    
  }
  
  void setTenor (float beatSpacing) {
    
    tenor = new NoteSequence(sound);
      tenor.notesPerBeat = 2;
      tenor.noteSpacing = beatSpacing/tenor.notesPerBeat; // triplets
      tenor.volume = 0.66;
      tenor.noteDuration = 0.25*tenor.noteSpacing; // 0.1;
      tenor.minPitch = 90;
      tenor.maxPitch = 360;
      tenor.meter = 4;
      tenor.restProbability = 0.13;
      tenor.doubleNoteProbability = 0.025; //0.06;
      tenor.beatsOfPhraseOverlap = 8;
      tenor.score = tenorScore;
      
      tenor.startingPitch = 180;
      tenor.intervalArray = ia23b;
  }
  
  void setBass(float beatSpacing) {
    
      bass = new NoteSequence(sound);
      bass.notesPerBeat = 1;
      bass.noteSpacing = beatSpacing/bass.notesPerBeat; // triplets
      bass.volume = 1;
      bass.noteDuration = 0.2*bass.noteSpacing; // 0.005;
      bass.minPitch = 30;
      bass.maxPitch = 120;
      bass.meter = 5;
      bass.restProbability = 0.15; // 0.06
      bass.doubleNoteProbability = 0.025; // 0.06;
      bass.beatsOfPhraseOverlap = 10;
      bass.score = bassScore;
      
      bass.startingPitch = 90;
      bass.intervalArray = ia23456;
      
  }
  
  void setupVoices() {
      
      float bps = bpm/60.0;
      float beatSpacing = 1/bps;
     
      setSoprano(beatSpacing);
      setAlto(beatSpacing);
      setTenor(beatSpacing);
      setBass(beatSpacing);  
  }
  
  
   
  void play() {
    /*
    float [][] intervals1 = { seconds };
  float [][] intervals2 = { thirds };
  float [][] intervals3 = { seconds, thirds };
  float [][] intervals4 = { seconds, thirds, hs2M6 };
  */
    
    framesPerPhrase = int(60*frameRate*beatsPerPhrase/bpm);     
  
    if (frameCount % int(framesPerPhrase) == 0)  {
          
      int bpp =  int(random(8,beatsPerPhrase) + soprano.beatsOfPhraseOverlap); 
      soprano.playFromScore(bpp, phase);
      
      bpp =  int(random(8,beatsPerPhrase) + alto.beatsOfPhraseOverlap); 
      alto.playFromScore(bpp, phase);
      
      bpp =  int(random(8,beatsPerPhrase) + tenor.beatsOfPhraseOverlap); 
      tenor.playFromScore(bpp, phase);
        
      bpp =  int(random(8,beatsPerPhrase) + bass.beatsOfPhraseOverlap); 
      bass.playFromScore(bpp, phase);
         
    } 
  }
  

  void stop() {
    out.close();
    minim.stop();
  }
  
}
