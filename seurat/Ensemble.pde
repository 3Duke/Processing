

class Ensemble {

  Score opus;
  Sound sound;

  int beatsPerPhrase;
  float bpm;

  Ensemble( Score opus_, Sound sound_, int beatsPerPhrase_, float bpm_) {

    opus = opus_;
    sound = sound_;

    beatsPerPhrase = beatsPerPhrase_;
    bpm = bpm_;
    
    float bps = bpm/60.0;
    float beatSpacing = 1/bps;
  
    println("bpm = "+nfc(bpm,2));
    println("bps = "+nfc(bps,2));
    println("beatSpacing = "+nfc(beatSpacing,4));
    
    for (int i = 0; i < opus.numberOfParts(); i++) {
      
      Generator g = opus.generator[i];
      
      g.sound = sound;
      println("g.notesPerBeat = "+nfc(g.notesPerBeat));
      g.noteSpacing = beatSpacing/g.notesPerBeat;
      println("g.noteSpacing = "+nfc(g.noteSpacing,4));
      println("g.relativeNoteDuration = "+nfc(g.relativeNoteDuration,4));
      g.noteDuration = g.relativeNoteDuration*g.noteSpacing;
      println("g.noteDuration = "+nfc(g.noteDuration,4));
     
    }
  } // end constructor
  
  void play() {  
    
     int framesPerPhrase = int(60*frameRate*beatsPerPhrase/bpm); 
        
    if (frameCount % framesPerPhrase == 0) {
      play1();    
    }
  }

  void play1() {

    beatsPerPhrase = 25;
    
    int numberOfSections = opus.numberOfSections();
    int localPhase = phase % numberOfSections;

    for (int i = 0; i < opus.score.length; i++) { // loop over parts, eg SATB

      Part part = opus.score[i];
      Generator generator = opus.generator[i];

      if (part.plays(localPhase)) {
        int bpp =  int(random(8, beatsPerPhrase) + generator.beatsOfPhraseOverlap);
        generator.play(bpp);
      } 
      else {
        // println(part.name + ": 0");
      }
    }
  }
  
} // end class Player
