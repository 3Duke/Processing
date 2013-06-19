class Generator {

  float delay;

  float noteSpacing;    
  float noteDuration;
  float relativeNoteDuration;
  int numberOfNotes; 
  int meter;
  int notesPerBeat;
  float restProbability;
  float doubleNoteProbability;
  float pickupProbability = 0.02;

  float firstPitch;
  float currentPitch;
  float lastPitch;
  float minPitch;        
  float maxPitch;
  float newIntervalArrayProbability = 0.2;
  float newIntervalProbability = 0.5;
  float newPitchDirectionProbability = 0.2;

  String intervalArrayKey;
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

  Generator(Sound sound_) {

    sound = sound_;
    volume = 1;
    restProbability = 0.1;
  }

  Generator(String text) {

    volume = float(metadata("volume", text));

    maxPitch = float(metadata("maxPitch", text));
    minPitch = float(metadata("minPitch", text));
    firstPitch = float(metadata("firstPitch", text));
    intervalArrayKey = metadata("intervalArrayKey", text);
    
    meter = int(metadata("meter", text));
    notesPerBeat = int(metadata("notesPerBeat", text));
    relativeNoteDuration = float(metadata("relativeNoteDuration", text));
    restProbability = float(metadata("restProbability", text));
    doubleNoteProbability = float(metadata("doubleNoteProbability", text));
    beatsOfPhraseOverlap = int(metadata("beatsOfPhraseOverlap", text));
    
    intervalArray = pitch.intervals(intervalArrayKey);

   
  }

  void display() {
    println("volume: "+nfc(volume, 1));
    println("");
    
    println("maxPitch: "+nfc(maxPitch, 1));
    println("minPitch: "+nfc(minPitch, 1));
    println("firstPitch: "+nfc(firstPitch, 1));
    println("intervalArrayKey: "+intervalArrayKey);
    println("");
    
    println("meter: "+nfc(meter));
    println("notesPerBeat: "+nfc(notesPerBeat));
    println("relativeNoteDuration: "+nfc(relativeNoteDuration, 2));
    println("");
    
    println("restProbability: "+nfc(restProbability, 3));
    println("doubleNoteProbability: "+nfc(doubleNoteProbability, 3));
    println("beatsOfPhraseOverlap: "+nfc(beatsOfPhraseOverlap));
   
  }

  void play(int beatsPerPhrase_) { 

  
    sound.out.pauseNotes();
    
    numberOfNotes = notesPerBeat*beatsPerPhrase_;
   
    lastPitch = firstPitch;
    currentDirection = direction();
    intervalArrayIndex = 0;
    intervalIndex = 0;
    currentInterval = sound.hs;
    
    for (int i = 0; i < numberOfNotes; i++) {

      // println("volume = "+nfc(volume,1));
      float r = random(0, 1);

    
      /////////////// Choose interval and direction ///////////////

      if (r < newIntervalArrayProbability) { // choose new interval array
        intervalArrayIndex = int(random(0, intervalArray.length));
      }

      r  = random(0, 1);
      if (r < newIntervalProbability) { // Choose new interval 0.5)
        intervalIndex = int(random(0, intervalArray[intervalArrayIndex].length));
        currentInterval = intervalArray[intervalArrayIndex][intervalIndex];
      }     

      
      if (r < newPitchDirectionProbability) { // Change direction 0.3
        currentDirection = direction();
      }
      
      if (currentDirection == 1) {
        currentPitch = lastPitch*currentInterval;
      }

      if (currentDirection == -1) {
        currentPitch = lastPitch/currentInterval;
      }

      if (currentPitch < minPitch) {
        r = random(0,1);
        if (r < 0.5) {
          currentPitch = 1.5*currentPitch;
        } else {
          currentPitch = 2*currentPitch;
        } 
      }
      if (currentPitch > maxPitch) {
        if (r < 0.5) {
          currentPitch = currentPitch/(4/3.0);
        } else {
          currentPitch = currentPitch/2;
        }
      }

      if (currentPitch == lastPitch) {
        currentPitch = sound.ws*currentPitch;
      }
      
      /////////////// End: choose interval and direction ///////////////

      // Introduce a rest
      float localVolume = volume*sound.volume;
      float rest = random(0, 1);
      if (rest < restProbability) {
        localVolume = 0;
      }

      if (i % meter == 0) { // Introduce meter
        localVolume = 1.33*localVolume;
      }

     
      float tripleNoteProbability = 0.02;
     
      // println(noteDuration);
      r = random(0, 1);
      if (r < tripleNoteProbability) {
         sound.out.playNote( delay + i*noteSpacing, noteDuration/3.0, new ToneInstrument( currentPitch, localVolume, sound.out ));
         sound.out.playNote( delay + (i +0.3333333333)*noteSpacing, noteDuration/3.0, new ToneInstrument( currentPitch, localVolume, sound.out ));
         sound.out.playNote( delay + (i +0.6666666666)*noteSpacing, noteDuration/3.0, new ToneInstrument( currentPitch, localVolume, sound.out ));
      }
      else if (r < tripleNoteProbability + doubleNoteProbability) {
        sound.out.playNote( delay + i*noteSpacing, noteDuration/2.0, new ToneInstrument( currentPitch, localVolume, sound.out ));
        sound.out.playNote( delay + (i +0.5)*noteSpacing, noteDuration/2.0, new ToneInstrument( currentPitch, localVolume, sound.out ));
      }
      else if (r < tripleNoteProbability + doubleNoteProbability + pickupProbability) 
      {
        sound.out.playNote( delay + (i +0.5)*noteSpacing, noteDuration/2.0, new ToneInstrument( currentPitch, localVolume, sound.out ));
      }
      else
      { // play single note
        sound.out.playNote( delay + i*noteSpacing, noteDuration, new ToneInstrument( currentPitch, localVolume, sound.out ));
      }
      // sound.out.playNote( 1, 1, new ToneInstrument( 440, 1, sound.out ));
      lastPitch = currentPitch;
    } // end loop
    firstPitch = lastPitch;

    sound.out.resumeNotes();
  } // end play

  /////////////////////////

  void playNotes(float [] notes, int index, int numberOfNotes, int direction, float transpositionFactor) {

    int count = 0;

    if (numberOfNotes < 1) {
      numberOfNotes = notes.length;
    }

    if (index < 0) {
      index = int(random(0, notes.length));
    }

    while (count < numberOfNotes) {

      float p = notes[index];
      p = transpositionFactor*p;
      sound.out.playNote( delay + count*noteSpacing, noteDuration, new ToneInstrument( p, volume, sound.out ));
      count++;

      if (direction > 0) {
        index++;
      } 
      else {
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
} // end class Generator
