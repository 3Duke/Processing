

class Voice {

  String name = "";
  NoteSequence [ ] pieces = null;
  
  Voice( NoteSequence ns, String name_ ) {
    
    name = name_;
    pieces = new NoteSequence[1];
    pieces[0] = ns;
    
  }

  void appendPiece( NoteSequence piece ) {
    
     pieces = (NoteSequence [ ]) append(pieces, piece);
     
  }
  
  
  Voice copy(Voice v, String name_) {
    

    NoteSequence piece = v.pieces[0].copy();
    Voice vv = new Voice(piece, name_);
    
    for (int i = 1; i < v.pieces.length; i++) {
      vv.appendPiece(v.pieces[i].copy());
    }
     
   return vv;
 } 
  
  void report() {
    
    println("Voice: "+name);
    for(int i = 0; i < pieces.length; i++) {
       print(i+1+": ");
       pieces[i].report();
    } 
    println("\n");   
  }
  
 void play(float startTime, float vol) {
   
   float t = startTime;
   
   for (int i = 0; i < pieces.length; i++) {
     
     pieces[i].play(t, vol);
     t += pieces[i].duration();
     
   }   
  } // play

/////////

float duration() {
  
  float dur = 0;
  
  for (int i = 0; i < pieces.length; i++ ) {
     dur += pieces[i].duration(); 
  }
  return dur;
  
}

/////////
 void transposeUp(String intervalName) {
    
    for(int i = 0; i < pieces.length; i++) {
       pieces[i].transposeUp(intervalName);
    } 
 } // transposeUp   
 
 /////////
 void transposeNotes() {
    
    for(int i = 0; i < pieces.length; i++) {
       pieces[i].transposeNotes();
    } 
 } // transposeUp   

} //
