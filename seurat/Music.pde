class Music {

  Score opus;
  Sound sound;
  Ensemble ensemble;

  int beatsPerPhrase;
  int framesPerPhrase;
  float bpm;
  int phase = 0;    // phase increases by 1 after each phrase
  int phase2 = 0;   // phase2 increases by 1 each time the score is complete

  Music( String scoreFile, int beatsPerPhrase, int bpm  ) { // bpp 25, bpm = 144 
 
    // LOAD SCORE
    opus = new Score(scoreFile);  // op3n1   
    opus.display();
    // opus.displayGenerators();
     
    // Load sound and ensemble player
    sound = new Sound(beatsPerPhrase, bpm);  // 15, 124
    ensemble = new Ensemble(opus, sound, beatsPerPhrase, bpm);

    // Set up phase
    framesPerPhrase = int(60*frameRate*beatsPerPhrase/bpm); 
    
    
  }
  
  void display() {
    
    println("In Music, score = "+opus.name);
    
  }
}
