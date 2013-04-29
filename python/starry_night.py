"""
starry_night.py: 
run like this:
  
  % java -jar processing-py.jar starry_night.py

Do this inside the folder

  processing.py-0021

This uses the package processing.py available at

  https://github.com/jdf/processing.py

processing.py provides the code necessary to write
processing code within Python, as below.

Note: I want to add audio to this show, but don't seem
to have a compatibel version of pyaudio.
"""

import sys

"""
import pyaudio
import wave
from time import sleep as sleeep
from time import time
"""

h = 20
R = 20
P = 15
T = 50

"""
def play(file, duration):
  wf = wave.open(file, 'rb')
  def callback( min_data, frame_count, time_info, status):
    data = wf.readframes(frame_count)
    return (data, pyaudio.paContinue)

  stream = p.open(format=p.get_format_from_width(wf.getsampwidth()),
                channels=wf.getnchannels(),
                rate=wf.getframerate(),
                output=True,
                stream_callback=callback)
                
  t_start =  time()
  t_elapsed = time() - t_start

  stream.start_stream()

  while (stream.is_active()) & (t_elapsed < duration) :
    sleeep(0.05)
    t_elapsed = time() - t_start

  stream.stop_stream()
  stream.close()
  wf.close()
"""

def setup():

  # size(600,600)
  size(1360, 740)
  background(0)
  smooth()
  fill(0)
  state = 0
  print(sys.argv)

def cloud(x,y,d,n):
  b = 1; k = 0.95
  for i in range(0,n):
    b = b*k
    fill(0,0,0,(1-b)*255)
    f = float(n-i)/n
    r = f*d
    ellipse(x,y,r,r)

def f(x):
  p = sin(2*3.1416*x/5000)
  p = p*p
  p = 10 + 100*p
  p = int(p)
  return p

def f2(x):
  p = sin(2*3.1416*x/700)
  p = p*p
  p = 10 + 100*p
  p = int(p)
  return p

def draw():

  global T

  x = random(0, width)
  y = random(0, height)

  r =  random(0,255)
  g =  random(0,10)
  b =  random(0,255)
  a =  random(0,255)
  C = color(r,g,b,a)
  stroke(C)

  k = random(1,20)
  k = k/10
  hh = k*h
  line(x-hh, y, x + hh, y)
  line(x, y-hh, x, y+hh)

  noStroke()
  fill(C)
  ellipse(x,y,k*R,k*R)

  P = f(frameCount) + f2(frameCount)
  if frameCount % P < 10:
    d = min(width, height)
    d = int(0.66*d)
    d = random(20,400)
    x = random(0,width)
    y = random(0,height)
    cloud(x,y,d,10)

    print(frameCount, P)

  delay(T)
