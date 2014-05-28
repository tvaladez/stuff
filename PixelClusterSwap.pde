//Processing sketch
//Swaps similar groups of 10x10 pixels within an image on an aligned grid.
 
/*The MIT License (MIT)
 
Copyright (c) 2014 Thomas Valadez
 
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
 
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
 
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE. */
 
import processing.video.*;
 
PImage mainImage;
PImage subImage1;
PImage subImage2;
PImage subImage1a;
PImage subImage2a;
PImage tempImage;
int x;
int y;
int a;
int b;
int shadeThreshold = 20;
int blockWidth = 3;
int blockHeight = 3;
 
void setup() {
  mainImage = loadImage("marilyn.jpg");
  subImage1 = createImage(10, 10, RGB);
  subImage2 = createImage(10, 10, RGB);
  subImage1a = createImage(10, 10, RGB);
  subImage2a = createImage(10, 10, RGB);
  tempImage = createImage(mainImage.width, mainImage.height, RGB);
  size(mainImage.width, mainImage.height);
  image(mainImage,0,0);
  
}
 
void draw() {
  x = (ceil(random(mainImage.width)/10) * 10) -10;
  y = (ceil(random(mainImage.height)/10) * 10) -10;
  a = (ceil(random(mainImage.width)/10) * 10) -10;
  b = (ceil(random(mainImage.height)/10) * 10) -10;
  subImage1.copy(mainImage,x,y,10,10,0,0,10,10);
  subImage1a.copy(mainImage,x,y,10,10,0,0,10,10);
  //This next section seems silly, but in a 10x10 canvas, a divide by zero error happens
  //when the BLUR argument is greater than 2.
  subImage1.filter(BLUR,2);
  subImage1.filter(BLUR,2);
  subImage1.filter(BLUR,2);
  subImage1.filter(BLUR,2);
  subImage1.filter(BLUR,2);
  subImage1.filter(BLUR,2);
  subImage2.copy(mainImage,a,b,10,10,0,0,10,10);
  subImage2a.copy(mainImage,a,b,10,10,0,0,10,10);
  subImage2.filter(BLUR,2);
  subImage2.filter(BLUR,2);
  subImage2.filter(BLUR,2);
  subImage2.filter(BLUR,2);
  subImage2.filter(BLUR,2);
  subImage2.filter(BLUR,2);
  if ((abs((red(subImage1.get(5,5))) - abs(red(subImage2.get(5,5)))) < shadeThreshold) &&
  (abs((green(subImage1.get(5,5))) - abs(green(subImage2.get(5,5)))) < shadeThreshold) &&
  (abs((blue(subImage1.get(5,5))) - abs(blue(subImage2.get(5,5)))) < shadeThreshold)) {
    image(subImage1a,a,b,10,10);
    image(subImage2a,x,y,10,10);
  }
}
