class Music {

  Score opus;
  Sound sound;
  Ensemble ensemble;

  int beatsPerPhrase;
  int framesPerPhrase;
  float bpm;
  int phase = 0;    // phase increases by 1 after each phrase
  int phase2 = 0;   // phase2 increases by 1 each time the score is complete

 // Music( String scoreFile, int beatsPerPhrase, int bpm  ) { // bpp 25, bpm = 144 
  Music( MusicParameters parameters  ) { // bpp 25, bpm = 144 
 
    
    beatsPerPhrase = parameters.beatsPerPhrase;
    bpm = parameters.bpm;
    framesPerPhrase = parameters.framesPerPhrase;
    
    // LOAD SCORE
    opus = new Score(parameters.scoreFile);  // op3n1   
    opus.display();
    // opus.displayGenerators();
     
    // Load sound and ensemble player
    sound = new Sound(beatsPerPhrase, bpm);  // 15, 124
    ensemble = new Ensemble(opus, sound, beatsPerPhrase, bpm);

    // Set up phase
    framesPerPhrase = int(60*15*beatsPerPhrase/bpm);
    println("@@@ AT STARTUP IN MUSIC: framesPerPhrase = "+framesPerPhrase); 
    
    
    
  }
  
  void display() {
    
    println("In Music, score = "+opus.name);
    
  }
}
