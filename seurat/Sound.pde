
import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

int direction() {

  // Determine direction of Brownian path through the interval array:
  // -1 for down, 0 for no direciotn, +1 for up.
  float r = random(0, 1);

  if (r < 0.5) {
    return 1;
  } 
  else {
    return -1;
  }
}

class Sound {

  Minim minim;
  AudioOutput out;

  Generator soprano, alto, tenor, bass;

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

  int rest [ ]       = { 
    0, 0
  };
  int silent []      = { 
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  };
  int all []         = { 
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  };

  int soprano1 []    = { 
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  }; 
  int soprano2 []    = { 
    1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1
  };
  int soprano3 []    = { 
    1, 1
  };
  int alto1 []       = { 
    0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 1
  }; 
  int alto2 []       = { 
    0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0
  };
  int alto3 []       = { 
    1, 1
  };
  int tenor1 []      = { 
    0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0
  }; 
  int tenor2 [ ]     = { 
    0, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1
  };
  int tenor3 [ ]      = { 
    1, 1
  };
  int bass1 []       = { 
    0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1
  }; 
  int bass2 []       = { 
    1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1
  };
  int bass3 [ ]      = { 
    1, 1
  };


  int sopranoScore[] = concat(concat( soprano1, soprano2), soprano3);
  int altoScore[]    = concat(concat( alto1, alto2), alto3);
  int tenorScore[]   = concat(concat( tenor1, tenor2), tenor3);
  int bassScore[]    = concat(concat( bass1, bass2), bass3);



  float sopranoFreq, altoFreq, tenorFreq, bassFreq;

  float tempoFactor = 1;

  int scoreLength = bassScore.length;


  // TEMPO PARAMETERS:
  int beatsPerPhrase; // = 15;
  float bpm; // = 112;  // beats per minute
  int framesPerPhrase = 1; // set later


  float CM7[] = { 
    C, E, G, B, C2
  };
  float bassLine1[] = { 
    C, E, G, B, C2, C, G, E, F, A, C, Bb, F2, D2, A, Fs, D, G, D, B, G
  };
  float bassLine[] = { 
    C, E, G, B, C2, Bb, A, Ab, G, Gb, F, E, Eb, D, Db
  };


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


  void stop() {
    out.close();
    minim.stop();
  }
}
