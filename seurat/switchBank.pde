
class SwitchBank {

  boolean switch_ []; 

  SwitchBank(int n) {

    switch_ = new boolean[n];

    for (int i = 0; i < n; i++) 
    {

      switch_[i]  = false;
    }
  }

  void all_off() {

    for (int i = 0; i < switch_.length; i++) 
    {

      switch_[i]  = false;
    }
  }

  void on(int k) {

    if (k < switch_.length) 
    {
      all_off();
      switch_[k] = true;
    }
  }

  boolean read(int k) 
  {
    if (k < switch_.length) 
    {
      return switch_[k];
    }
    else
    {
      return false;
    }
  }

  int activeSwitch() {

    for (int i = 0; i < switch_.length; i++) {
      if ( switch_[i] ) { 
        return i;
      }
    }
    return -1;
  }
} // SwitchBank
