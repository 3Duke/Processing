

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

    if (debug) {
      println("bpm = "+nfc(bpm, 2));
      println("bps = "+nfc(bps, 2));
      println("beatSpacing = "+nfc(beatSpacing, 4));
    }

    for (int i = 0; i < opus.numberOfParts(); i++) {

      Generator g = opus.generator[i];

      g.sound = sound;
      g.noteSpacing = beatSpacing/g.notesPerBeat;
      g.noteDuration = g.relativeNoteDuration*g.noteSpacing;
    }
  } // end constructor

  void play() {  

    music.framesPerPhrase= int(60*frameRate*beatsPerPhrase/bpm);
  

    if (frameCount % music.framesPerPhrase == 0) {
      if (debug) {
        // int localPhase = music.phase % music.opus.numberOfSections();
        // println("music.phase = "+nfc(music.phase)+", localPhase = "+nfc(localPhase));
      }
      music.phase = int(frameCount/(1.0*music.framesPerPhrase));
      play1();
    }
  }

  void play1() {

    // beatsPerPhrase = 25; // XXXXX

    int numberOfSections = music.opus.numberOfSections();
    int localPhase = music.phase % numberOfSections;



    for (int i = 0; i < opus.score.length; i++) { // loop over parts, eg SATB



      Part part = opus.score[i];

      Generator generator = opus.generator[i];

      if (part.plays(localPhase)) {
        if (debug) {
          println("\nFrame "+frameCount+", localPhase "+localPhase+"\nNotes for "+part.name.toUpperCase()+":\n------------");
        }
        // int bpp =  int(random(8, beatsPerPhrase) + generator.beatsOfPhraseOverlap);
        int bpp =  beatsPerPhrase + int(random(0, generator.beatsOfPhraseOverlap));
        generator.play(bpp);
      } 
      else {
        // println(part.name + ": 0");
      }
    }
  }
} // end class Player
