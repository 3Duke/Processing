float squaredDistance(float a, float b, float c, float d) {
  
  return (a-c)*(a-c) + (b-d)*(b-d);
  
}
  
/*
int nearestObject(float x, float y) {
  
  float d = squaredDistance(object[0].x, object[0].y, x, y);
  int nearest = 0;
  
  
  for(int i = 1; i < object.length; i++) {
    
    float dd = squaredDistance(object[i].x, object[i].y, x, y);
    if (dd < d) {
      d = dd;
      nearest = i;
    }
  }
  return nearest;
}
  

void mousePressed() {

   int nearest = nearestObject(mouseX, mouseY);
   
   object[nearest].x = mouseX;
   object[nearest].y = mouseY;
    
}
*/


void keyPressed() {
  
  
  saveFrame("line-######.png");
  
 
}
