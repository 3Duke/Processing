import sys
import random as rand
from time import time

h = 20
R = 300
P = 15
T = 40
A = 0
kk=1
rr, gg, bb = 0, 0, 0

PERIOD = 30                     # period for rate oscillations in secneonds
movingFrameTime = 10            # seconds
fadeFrameTime   = 5             # seconds
milliseconds = 1000             # milliseconds in a second
fps = 20                        # frames per second
delayTime = milliseconds/fps    # time between frames in milliseconds

movingFrames = movingFrameTime*fps
fadeFrames = fadeFrameTime*fps
movingFrames += fadeFrames
k = 2
dA = k*255.0/fadeFrames

def setup():
  global start_time
  # size(600,600)
  size(1360, 740)
  # size(600, 600)
  background(0)
  smooth()
  fill(0)
  state = 0
  print(sys.argv)
  start_time = time()

def cloud(x,y,d,d2,n,rgb):
  a = 1; k = 0.95
  for i in range(0,n):
    a = a*k
    r,g,b = rgb
    fill(r,g,b,(1-a)*255)
    f = float(n-i)/n
    R = f*d
    R2 = f*d2
    ellipse(x,y,R,R2)

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


def mousePressed():
  saveFrame()

def draw():

  global delayTime, A, dA, rr, gg, bb, start_time, PERIOD, kk


  x = random(0, width)
  y = random(0, height)

  r =  random(0,255)
  g =  random(0,255)
  b =  random(0,255)
  a =  random(0,255)
  C = color(r,g,b,a)
  # noStroke()
  # stroke(255-r,255-g,255-b,100)
  stroke(rr,gg,bb,100)
  k = rand.uniform(0.33, 1)
  k2 = k*kk
  elapsed_time = time() - start_time
  cloud(x,y,k*R, k2*R, 5, (r,g,b))

  elapsed_time = time() - start_time
  SIN = sin(elapsed_time/(2*3.1416*PERIOD))  
  DT = delayTime/(1 + 10*SIN*SIN)
  # print("delay: %1.2f", DT)
  delay(DT)
  
  if frameCount % movingFrames == 0:
    # saveFrame()
    rr, gg, bb, = r,g,b
    bb = 255 - (rr + gg) # make color saturated
    FPS = frameCount/elapsed_time
    print("start fade: %1.1f, %d, %1.2f" % (elapsed_time, frameCount, FPS))

  if frameCount % movingFrames < fadeFrames:
    fill(rr,gg,bb,dA)
    rect(0,0,width,height)

  if frameCount % movingFrames == fadeFrames - 1:
    FPS = frameCount/elapsed_time
    SIN = sin(elapsed_time/(3.1416*PERIOD*0.5))  
    kk = 1 + 0.5*SIN*SIN
    print("end fade: %1.1f, %d, %1.2f\n" % (elapsed_time, frameCount, FPS))
