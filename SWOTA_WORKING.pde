import processing.serial.*; 
import controlP5.*;
ControlP5 cp5;
Serial myPort;

int stage;
String textValue = "";
String entry,name;


//String data="111.23,111.4964,555.6,77,81,99,;" ; 
String data="";

PFont  myFont;  // object from the font class
PImage photo;

float nums[],time,x,y,z,thrust,torque;
String tm,a,b,c,th,to,fileIO[];
  
PrintWriter output;

void setup()// this runs just once
{
   stage = 1;
   size(1200,440); // size of processing window
background(0);// setting background color to black
   myFont = createFont("Georgia",20);  // object from the font class
   cp5 = new ControlP5(this);
  
    cp5.addTextfield("NAME")
     .setPosition(200,170)
     .setSize(200,40)
     .setFont(createFont("arial",20))
     .setAutoClear(false)
     ;
       
  cp5.addBang("SAVE")
     .setPosition(460,170)
     .setSize(80,40)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ; 
    
    cp5.addBang("EXIT")
     .setPosition(1100,30)
     .setSize(80,40)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ; 
     

printArray(Serial.list());
photo = loadImage("/Users/ankitshah/Desktop/SWOTA_GUI_PEDICLE_PROBE/image (1).png");
  photo.resize(100,80);
  
  textFont(myFont);
  
//myPort = new Serial(this, Serial.list()[0], 9600);// giving parameters to object of serial class,put the com to which your arduino is connected and the baud rate
//myPort.bufferUntil('\n');// gathers data till new line character
//output = createWriter ("positions.txt");

}


  
void draw()
{
  if (stage ==3){
  background(0);//refreshing background everytime the draw runs
  image(photo,100, 290);
  textAlign(CENTER);// alighn text to the centre of coordinates
  fill(155);
   text("~ PEDICLE PROBE DATA ~",570,50);
  fill(255);// fill white color to text
  
  output.println(data);
  //output.println(name);
   output.flush();
    delay(100);
  nums = float((split(data,',')));
  //fileIO = (split(data,';'));
 // saveStrings("new.txt", fileIO);
   time = nums[0];
     tm = nf(time,0,2);
      x = nums[1];
      a = nf(x,0,2);
      y = nums[2];
      b = nf(y,0,2);
      z = nums[3];
      c = nf(z,0,2);
 thrust = nums[4];
     th = nf(thrust,0,2);
 torque = nums[5];
     to = nf(torque,0,2);
     
     //name = minute() + ":" + second()+":"+ int(second()/1000) + "," + a + "," + b + ","+ c +","+ th + "," + to;
  
  //text(data,550,225);// display the data at 350,155 coordinate
  textSize(30);// size of text
  fill(#4B5DCE);// fillinf blue color on the text 
  text(" TIME ",230,150);
  text(" X ",370,150);
  text(" Y ",520,150);
  text(" Z ",670,150);
  text(" THR. ",830,150);
  text(" TOR. ",970,150);
  //=-------------------------=
   textSize(40);// size of text
  fill(#bfff80);
  
  text(tm,230,230);
  text(a,385,230);
  text(b,540,230);
  text(c,690,230);
  text(th,830,230);
  text(to,970,230);

  
   //output.close();
   noFill();  
   stroke(#4B5DCE);// color of boader of rectangle
   rect(110,170,1000,80,90); //rectangle
   //rect(150,100,170,140);
  }
  
  //========================================================
  if (stage ==1){
  background(0);
  fill(255);
  textAlign(CENTER);
  textSize(40);// size of text
  fill(#4B5DCE);
  text("~ PEDICLE PROBE STUDY ~",580,50);
  image(photo,100, 290);
  a =(cp5.get(Textfield.class,"NAME").getText());
  b = a+".txt";
  //text(b, 360,380);
  
  }
  
  if (stage==2){
  image(photo,100, 290);
  output = createWriter (b);
  delay(1000);
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n');
  
  stage = 3;
  }

  
}
void serialEvent(Serial myPort)
{
  data=myPort.readStringUntil('\n'); 
 
  
}

public void EXIT() {

  exit();
 
}

public void SAVE() {
  stage=2;
  if (stage==2){

        
        background(000,000,000);
        text(b, 90,30);
        cp5.addTextfield("NAME").hide();
        cp5.addBang("SAVE").hide();
        
  }
}
