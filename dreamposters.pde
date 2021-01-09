import java.util.Arrays;
// initialize the boxes 
Box [] boxes = new Box[8*12]; 
Box [] topic_boxes = new Box[8*12];
Box [] final_boxes = new Box[8*12];
PImage img;

//PERLIN NOISE EXPERIMENT
FlowField flowfield;
ArrayList<Particle> particles;
PGraphics perlin_layer;
PGraphics everything_layer;
//PERLIN NOISE EXPERIMENT

String[] queries_lvl_1 = {"climate change",
"what is climate",
"what is the climate",
"what is a climate",
"climate control",
"global climate",
"climate definition",
"climate change real",
"climate map",
"climate strike",
"global climate ",
"world climate",
"weather and climate",
"population",
"climate news",
"global warming",
"climate city",
"what is weather",
"climate scientists",
"greenhouse effect",
"paris climate",
"tropical climate",
"climate change",
"climate change news",
"climate zones",
"fossil",
"fossil fuels",
"energy",
"what is fossil fuel",
"definition",
"what is energy",
"coal",
"burning fossil fuel",
"renewable energy",
"peer reviewed",
"climate",
"sea level",
"natural gas",
"greenhouse gases",
"carbon dioxide",
"climate change",
"solar energy",
"carbon dioxide",
"renewable resources",
"fossil fuel oil",
"nonrenewable",
"who is greta thunberg",
"greta thunberg",
"greta slams trump",
"greta thunberg meme",
"climate change",
"greta climate",
"greta thunberg who",
"sea rise",
"greta twitter",
"greta thunberg news",
"greta un speech",
"greta parents",
"how old is greta",
"greta person",
"greta autism",
"how dare you",
"greta school strike",
"greta net worth",
"person of the year",
"aspergers",
"greta aspergers",
"global",
"warming",
"global warming",
"climate",
"climate change",
"global climate",
"global change",
"scientific consensus",
"co2 emissions",
"what is climate",
"water vapor",  
"paris climate",
"global temperature",
"oil companies",
"pollution",
"global warming cause",
"paris climate",
"climate agreement",
"coronavirus effects",
"co2",
"climate definition",
"global temperature",
"climate warming",
"greenhouse gases",
"climate causes",
"greenhouse effect",
"Christopher Monckton", 
"oil companies",  
"scientific community"
};

String[] topics_lvl_2 = {
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"science",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate",
"climate change",
"climate change",
"climate",
"climate change",
"climate change",
"energy",
"climate change",
"science",
"energy",
"energy",
"energy",
"energy",
"science",
"climate",
"climate change",
"energy",
"climate change",
"climate change",
"climate change",
"energy",
"climate change",
"energy",
"energy",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate change",
"climate",
"climate change",
"climate",
"climate change",
"science",
"climate change",
"climate change",
"climate change", 
"climate change",
"climate change",
"climate change",
"pollution",
"climate change",
"climate change",
"climate change",
"coronavirus",
"pollution",
"science",
"climate",
"climate change",
"climate change",
"climate change",
"climate change",
"sceptics", 
"capitalism",  
"science"
};

String[] last_word = new String[96];

PFont font_normal;
PFont font_biggg;
PFont font_bold;
PFont font_final;

void setup() { 
  size(675, 1005); 
  // smooth();
  String[] fontList = PFont.list();
  printArray(fontList);
  img = loadImage("ytlogo.png");
  
  //font_normal = createFont("Comic Sans MS", 7.0);
  //font_bold = createFont("Comic Sans MS Bold", 8.0);
  //font_final = createFont("Comic Sans MS Bold", 14.0);
  font_normal = createFont("Corbel", 8.0);
  font_biggg = createFont("Corbel light", 35.0);
  font_bold = createFont("Corbel Bold", 9.0);
  font_final = createFont("Corbel Bold", 16.0);
  Arrays.fill(last_word, "HOAX");
    
  
  // Create a grid 
  int x = 6;  // dist left  
  int y = 4;  // dist top
  int k=0;

  String letter;
  String topic;
  String last;
  
  for (int i = 0; i < 8; i += 1) { 
    for (int j = 0; j < 12; j += 1) { 
      //if (k<14) 
      //letter=wordYolo.charAt(k)+"";
      letter=queries_lvl_1[k];
      topic = topics_lvl_2[k];
      last = last_word[k];
      //else
      //  letter = " ";
      color strokeColor1 = color (255, 1, 1);   
      color query_color = color(0);
      color topic_color = color (255, 1, 1);
      
      float query_size = 8.0;
      float topic_size = 9.0;
      float final_size = 16.0;
      
      float normal_opacity = 255.0;
      float bold_opacity = 100.0;
      float final_opacity = 255.0;
      
      boxes[k] = new Box(x+i*83, y+j*83, 
      80, 80, 
      strokeColor1, query_color, letter, query_size, font_normal, normal_opacity);
      
      topic_boxes[k] = new Box(x+i*83, y+j*83, 
      80, 80, 
      strokeColor1,topic_color, topic.toUpperCase(), topic_size, font_bold, bold_opacity);
      
      final_boxes[k] = new Box(x+i*83, y+j*83, 
      80, 80, 
      strokeColor1,topic_color, last, final_size, font_final, final_opacity);
      k++;
    } // for
  } // for
  
  //PERLIN NOISE EXPERIMENT
  flowfield = new FlowField(10);
  flowfield.update();
  
  particles = new ArrayList<Particle>();
  
  for (int i = 0; i < 10000; i++) {
    PVector start = new PVector(random(width), random(height));
    particles.add(new Particle(start, random(2, 8)));
  }
  //PERLIN NOISE EXPERIMENT
} // setup()

int[] random_tracker = {0}; //<>//
int[] random_last_tracker = {0};
int elements = 0;

int random_selector(){
  int random_pick = 0;
  do
  {
    random_pick = int(random(boxes.length));
    //println("checking candidates " + random_pick);
  }
  while(check_array(random_pick,random_tracker) && random_tracker.length != 96);
  random_tracker = append(random_tracker,random_pick);
  //println("appended " + random_pick);
  random_tracker = sort(random_tracker);
  return random_pick;
}

int random_last_selector(){
  int random_pick = 0;
  do
  {
    random_pick = int(random(boxes.length));
    //println("checking candidates " + random_pick);
  }
  while(check_array(random_pick,random_last_tracker) && random_last_tracker.length != 96);
  random_last_tracker = append(random_last_tracker,random_pick);
  //println("appended " + random_pick);
  random_last_tracker = sort(random_last_tracker);
  return random_pick;
}


boolean check_array(int search, int[] search_arr){
  //println(search_arr);
  //println(search);
  boolean found = false;
  //println("size " + search_arr.length);
  //println(search_arr);
 
  int i = 0;
  while(i < search_arr.length && !found){
     //println("comparing " + search_arr[i] + " and " + search  + " with index " + i);
     if(search_arr[i] == search) {
      //println("FOUND");
      found = true;
    }
    else{
      //println("NOT FOUND");
      found = false;
    }
    i += 1;
  }
  return found;
}

void draw() { 
  background(255);
  frameRate(12);
  //frameRate(25);
  
  int random;
  // display the grid
  strokeWeight(1);
  for (int i = 0; i<boxes.length; i++) { 
    boxes[i].display();
  } // for
  if(millis()/1000 < 5.0){
    boxes[int(random(boxes.length))].swap(boxes[int(random(boxes.length))]);
  }
  else if(millis()/1000 >= 5.0 && millis()/1000 < 15.0){
    if(random_tracker.length != boxes.length){
      if(random_tracker.length == 1){
        boxes[0].swap(topic_boxes[0]);
      }
      random = random_selector();
      boxes[random].swap(topic_boxes[random]);
    }
  }
  else if(millis()/1000 >= 15.0 && millis()/1000 < 20.0){
    boxes[int(random(boxes.length))].swap(boxes[int(random(boxes.length))]);
  }
  else if(millis()/1000 >= 20.0 && millis()/1000 < 30.0){
    if(random_last_tracker.length != boxes.length){
      println("tracker: " + random_last_tracker.length + "/boxes: " + boxes.length);
      if(random_last_tracker.length == 1){
        boxes[0].swap(final_boxes[0]);
      }
      random = random_last_selector();
      //println(int(random(boxes.length)));
      boxes[random].swap(final_boxes[random]);
      }
  }
  else if(millis()/1000 >= 30.0 && millis()/1000 < 40.0){
    //println("HA!!!!!!!!!!!");
    //boxes[int(random(boxes.length))].swap(boxes[int(random(boxes.length))]);
    boxes[int(random(boxes.length))].jiggle();
  }
  else if(millis()/1000 >= 40.0 && millis()/1000 < 45.0){
      for(int i = 0; i < boxes.length;i++){
        boxes[i].hide();
      }
  }
  else{
    tint(255, 128);
    image (img, width/2 - 150, height/2 - 130);
    fill(color (255, 1, 1), 255);
    textFont(font_biggg);
    //println("text in box: " + textInTheBox + "; text size: " + text_size);
    text ("personalization for profits, not for people", width/2 - 240 , height/2+200);
    
  }
  
  //PERLIN NOISE EXPERIMENT
  flowfield.update();
  for (Particle p : particles) {
    p.follow(flowfield);
    p.run();
  }
  //image(everything_layer, 0, 0);
  //image(perlin_layer, 0, 0);
  //PERLIN NOISE EXPERIMENT
  
   //saveFrame("poster-###.tga"); 
} // draw()
 
// =========================
 
class Box {
 
  float x;
  float y; 
  float horizontal_allign;
 
  float w=70;
  float h=70; 
 
  color col;
  color text_col;
  
  String textInTheBox="Y";
  
  float text_size;
  
  PFont font;
  
  float opacity;
 
  // constr 
  Box ( float x, float y, 
  float w, float h, 
  color col, color text_color,
  String letter, float text_size, PFont font, float opacity) {
    this.x=x;
    this.y=y;
    this.horizontal_allign = 4.0;
 
    this.w=w;
    this.h=h;
 
    this.col=col;
    this.text_col=text_color;
    this.textInTheBox=letter;
    
    this.text_size = text_size;
    
    this.font = font;
    
    this.opacity = opacity;
  } // constr 
  //
  void display() {
    stroke(col);
    //fill(col);
    //strokeWeight(3);
    noFill();
    rect (x, y, w, h);
    fill(text_col, opacity);
    //textAlign(CENTER);
    textSize(text_size);
    textFont(font);
    //println("text in box: " + textInTheBox + "; text size: " + text_size);
    text (textInTheBox, x+horizontal_allign , y+38);
  } // method
  void swap( Box theOtherBox ) {
    String temp = theOtherBox.textInTheBox;
    theOtherBox.textInTheBox = textInTheBox;
    textInTheBox = temp;
    
    color temp_col = theOtherBox.text_col;
    theOtherBox.text_col = text_col;
    text_col = temp_col;
    
    float temp_size = theOtherBox.text_size;
    theOtherBox.text_size = text_size;
    text_size = temp_size;
    
    PFont temp_font = theOtherBox.font;
    theOtherBox.font = font;
    font = temp_font;
    
    float temp_opacity = theOtherBox.opacity;
    theOtherBox.opacity = opacity;
    opacity = temp_opacity;
  }
  
   void jiggle() {
     
     horizontal_allign += 25 * sin(millis()/100); 
  }
  
  void hide(){
    opacity -= 5;
  }
}
