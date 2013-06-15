

class NoteSequence {

  String name;
  String instrumentName;
  int type; // type = 0: no nameSequence, type = 1: nameSequence initialiazed

  String [ ] nameSequence;
  float [ ] pitchSequence;
  float [ ] durationSequence;

  float timeScale = 1;

  String transpositionDirection = "";
  String transpositionInterval = "UN";
  float frequencyRatio = 1;

  int len;

  NoteSequence( String [ ] nameSequence_, float [ ] durationSequence_, int numberOfNotes, String name_) {

    name = name_;
    len = numberOfNotes;
    type = 1;

    int lns = nameSequence_.length; 
    int lds = durationSequence_.length;   

    nameSequence = new String [numberOfNotes];
    pitchSequence = new float [numberOfNotes];
    durationSequence = new float [numberOfNotes];

    for (int i = 0; i < numberOfNotes; i++) {

      nameSequence[i] = nameSequence_[i % lns];
      pitchSequence[i] = Frequency.ofPitch( nameSequence[i] ).asHz();
      durationSequence[i] = durationSequence_[i % lds];
    }
  }

  NoteSequence( float [ ] pitchSequence_, float [ ] durationSequence_, int numberOfNotes, String name_) {

    name = name_;
    len = numberOfNotes;
    type = 0;

    int lps = pitchSequence_.length; 
    int lds = durationSequence_.length;

    // nameSequence = new String [];
    pitchSequence = new float [numberOfNotes];
    durationSequence = new float [numberOfNotes];

    for (int i = 0; i < numberOfNotes; i++) {

      pitchSequence[i] = pitchSequence_[i % lps]; 
      durationSequence[i] = durationSequence_[i % lds];
    }
  }


  void report() {

    print(name+" ("+type+", "+len+", "+nfc(duration(), 2)+", fr = "+nfc(frequencyRatio, 4)+"): ");
    int N = pitchSequence.length;

    if (type == 0) {
      for (int i = 0; i < N-1; i++) {
        print("["+nfc(pitchSequence[i], 3)+", "+nfc(durationSequence[i], 3)+"], ");
      }
      print("["+nfc(pitchSequence[N-1], 3)+", "+nfc(durationSequence[N-1], 3)+"]");
    } // type 0

    if (type == 1) {
      for (int i = 0; i < N-1; i++) {
        print("["+nameSequence[i]+", "+nfc(pitchSequence[i], 3)+", "+nfc(durationSequence[i], 3)+"], ");
      }
      print("["+nameSequence[N-1]+", "+nfc(pitchSequence[N-1], 3)+", "+nfc(durationSequence[N-1], 3)+"]");
    } // type 1

    println("");
  }

  void play(float delay, float vol) {

    float delay_ = delay;

    for (int i = 0; i < pitchSequence.length;  i++) {
      // SPInstrument instrument = new SPInstrument( frequencyRatio*pitchSequence[i], vol); 
      MPInstrument instrument = loadClass(instrumentName);
      
      if (instrument == null) {
        println("NULL!");
      } else {
        println("OK("+i+")");
      }
  
      instrument.initialize(frequencyRatio*pitchSequence[i], vol); 
      float dur =  timeScale*durationSequence[i];
      out.playNote (delay_, dur, instrument); 
      delay_ += dur;
    }
  } 

  NoteSequence copy() {

    NoteSequence NS = null;

    if (type == 0) {
      NS = new NoteSequence( pitchSequence, durationSequence, len, name);
    }

    if (type == 1) {
      NS = new NoteSequence( nameSequence, durationSequence, len, name);
    }

    NS.transpose(transpositionInterval, transpositionDirection);
    NS.setTimeScale(timeScale);
    NS.instrumentName = instrumentName;
    NS.name = name;

    return NS;
  }

  /////////////


  void reverse_() {

    pitchSequence = reverse(pitchSequence);
    if (type == 1) { 
      nameSequence = reverse(nameSequence);
    }
    durationSequence = reverse(durationSequence);
  }

  void transpose(String intervalName, String direction) {

    if (direction == "UP") {
      transposeUp(intervalName);
    } 
    else {
      transposeDown(intervalName);
    }
  }

  void transposeUp(String intervalName) 
  {
    transpositionDirection = "UP";
    transpositionInterval = intervalName;
    frequencyRatio = transposeUp_(intervalName);
  }

  void transposeDown(String intervalName) 
  {
    transpositionDirection = "DOWN";
    transpositionInterval = intervalName;
    frequencyRatio = transposeDown_(intervalName);
  }

  void setTimeScale( float timeScale_ ) {

    timeScale = timeScale_;
  }

  float duration() {

    int N = durationSequence.length;
    float dur = 0;

    for (int i = 0; i < len; i++) {
      dur += durationSequence[ i % N ];
    }

    return timeScale*dur;
  }
} // class noteSequence


///////////

float transposeUp_ (String intervalName) {

  float freqRatio = 1;

  if (intervalName == "m2") 
  {
    freqRatio = 1.05946309435930;
  }
  else if (intervalName == "M2") 
  {
    freqRatio = 1.12246204830937;
  } 
  else if (intervalName == "m3") 
  {
    freqRatio = 1.18920711500272;
  }
  else if (intervalName == "M3") 
  {
    freqRatio = 1.25992104989487;
  }
  else if (intervalName == "P4") 
  {
    freqRatio = 1.33483985417003;
  }
  else if (intervalName == "TT") 
  {
    freqRatio = 1.41421356237310;
  }
  else if (intervalName == "TT") 
  {
    freqRatio = 1.49830707687668;
  }
  else if (intervalName == "m6") 
  {
    freqRatio = 1.58740105196820;
  }
  else if (intervalName == "M6") 
  {
    freqRatio = 1.68179283050743;
  }
  else if (intervalName == "m7") 
  {
    freqRatio = 1.78179743628068;
  }
  else if (intervalName == "M7") 
  {
    freqRatio = 1.88774862536339;
  }
  else if (intervalName == "OC") 
  {
    freqRatio = 2.0;
  }
  else if (intervalName == "UN") 
  {
    freqRatio = 1.0;
  }

  return freqRatio;
}

float transposeDown_ (String intervalName) {

  return 1.0/transposeUp_( intervalName );
}
