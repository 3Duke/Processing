/********
 
 Classe:
 Section
 Part
 Score
 
 *********/


String pad(String str, int width) {

  str = str+"                     ";
  return str.substring(0, width);
}

String element(String prefix, String suffix, String source) {

  int i = source.indexOf(prefix);
  String value = "";

  if (i >= 0) {
    String tail = source.substring(i+prefix.length(), source.length());
    int j = tail.indexOf(suffix);
    if (j >= 0) {
      value = tail.substring(0, j);
    }
  }
  return value.trim();
}

String metadata( String type, String source) {

  return element("<"+type+":", ">", source);
}

class Section {

  boolean plays;

  Section ( String e ) {
    if (e.equals("1")) {
      plays = true;
    } 
    else {
      plays = false;
    }
  }
} // end class Section

////////////////////////////

class Part {

  String name;
  Section [ ] score;

  Part ( int size ) {

    score = new Section[size];
  }

  Part ( String name_, String text ) {

    name = name_;
    String [ ] symbols = splitTokens(text, " ");
    int n = symbols.length;
    score = new Section[n];

    for (int i = 0; i < symbols.length; i++) {
      score[i] = new Section(symbols[i]); // expects "1" or "0"
    }
  } // end initializer Score
  
  
  boolean plays (int phase) {
    
    return score[phase].plays;
    
  }

  void display() {

    print(pad(name, 15));

    for (int i = 0; i < score.length; i++) {

      if (score[i].plays == true) {
        print("1 ");
      } 
      else {
        print ("0 " );
      }
    }
    println("");
  } //end display

  Part join( Part b) {

    Part c = new Part( score.length + b.score.length);

    c.name = name + "+" + b.name;

    for (int i = 0; i < score.length; i++) {
      c.score[i] = score[i];
    }

    int base = score.length;
    for (int i = 0; i < b.score.length; i++) {
      c.score[base + i] = b.score[i];
    }

    return c;
  }
} // end class Part

class Score {

  String name;
  Part [] score;
  Generator [] generator;

  Score(String fileName) {

    String lines [] = loadStrings(fileName);

    String input = "";
    for (int i = 0; i < lines.length; i++) {
      input = input + " " +lines[i];
    }

    String [ ] chunk = split(input, "--");

    score = new Part[0];
    generator = new Generator [0];

    name = metadata("title", chunk[0]);

    for (int i = 1; i < chunk.length; i++) {


      String partName = metadata("part", chunk[i]);
      String cueData = metadata("cues", chunk[i]);

      if ((partName.length() > 0) && (cueData.length() > 0)) {
        
        Part p = new Part(partName, cueData);
        Generator g = new Generator(chunk[i]);

        score = (Part[ ]) append(score, p);
        generator = (Generator [ ]) append(generator, g);
        
      }
    } // end for (i)
  } // end constructor

  void display() {

    println(name);
    println("--------------------------------");
    for (int i = 0; i < score.length; i++) {
      score[i].display();
    }
  }
  
  void displayGenerators() {
    println(name);
    println("=============================");
    for (int i = 0; i < generator.length; i++) {
      println(score[i].name);
      println("-------");
      generator[i].display();
      println("====================");
    }
  }
  
  int numberOfSections () {
    
   Part p = score[0]; 
   return p.score.length;
   
  }
  
  int numberOfParts () {
    
    return score.length;
    
  }
  
  
} // end class Score


/////////////////////////////
