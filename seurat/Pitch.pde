class Pitch {
  
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


  float intervals23456[ ] = { 
    hs, ws, m3, M3, p4, p5, m6, M6
  };
  float intervals2345B[ ] = { 
    hs, ws, ws, m3, M3, p4, p5
  };
  float intervals2[ ] = { 
    hs, ws
  };
  float intervals3[ ] = { 
    m3, M3
  };

  float [][] ia2 = { 
    intervals2
  };
  float [][] ia3 = { 
    intervals3
  };
  float [][] ia23 = { 
    intervals2, intervals3
  };
  float [][] ia23b = { 
    intervals2, intervals2, intervals2, intervals3
  };
  float [][] ia23456 = { 
    intervals23456
  };
  float [][] ia2345B = { 
    intervals2345B
  };
  
  ///////////////
  
  float [][][] intervalArrayList = { ia2, ia3, ia23, ia23b, ia23456, ia2345B };
  IntDict intervalDict;
  
  Pitch () {
    
    intervalDict = new IntDict();
    intervalDict.set("ia2", 0);
    intervalDict.set("ia3", 1);
    intervalDict.set("ia23", 2);
    intervalDict.set("ia23b", 3);
    intervalDict.set("ia23456", 4);
    intervalDict.set("ia223456B", 5);   
    
  }
  
  float [][] intervals(String k) {
    
    println("KEY = "+k);
    
    int index = intervalDict.get(k);
    return intervalArrayList[index];
    
  }  
  
} // end class Pitch
