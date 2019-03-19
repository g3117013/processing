String lin;
int ln;
String lines[];
int [][] plot = new int [4][4];
Maru[] maru;
int aka, kuro;

void setup() {
  frameRate(10);

  size(600, 600);
  lines = loadStrings("plotALS.csv");
  background(255);
  for (int x=0; x<4; x++) {
    for (int y=0; y<4; y++) {
      plot[x][y]=0;
    }
  }
  maru = new Maru[16];
  for (int i =0; i<16; i++) {
    int a = i%4;
    int b = i/4;
    int n = 0;
    maru[i]= new Maru(a, b, n, 0, 0);
  }

  data();
}


void draw() {
  for (int n=0; n<4; n++) {
    fill(0);
    line(150+100*n, 50, 150+100*n, 550);
    line(50, 150+100*n, 550, 150+100*n);
    text(n+1, 150+100*n, 570);
    text(4-n, 30, 150+100*n);
  }
  strokeWeight(5);
  line(50, 50, 50, 550);
  line(50, 550, 550, 550);

  for (int t=0; t<16; t++) {
    maru[t].spot();
    ellipse(150+maru[t].x*100, 450-maru[t].y*100, 10*(maru[t].count), 10*(maru[t].count));

    if (maru[t].count!=0) {    
      fill(0);
      textSize(16);
      textAlign(CENTER);
      text(maru[t].count, 169+maru[t].x*100, 435-maru[t].y*100);
      text(maru[t].count, 171+maru[t].x*100, 435-maru[t].y*100);
      text(maru[t].count, 170+maru[t].x*100, 436-maru[t].y*100);
      text(maru[t].count, 170+maru[t].x*100, 434-maru[t].y*100);

      fill(255);
      textSize(16);
      textAlign(CENTER);
    }
    text(maru[t].count, 170+maru[t].x*100, 435-maru[t].y*100);





    println(maru[t].x+","+maru[t].y+",,"+maru[t].count+",,"+maru[t].aka+",,"+maru[t].kuro);
  }
  noLoop();
}

void data() {
  ln=0;
  aka=0;
  kuro=0;
  for (int i=0; i<15; i++) {
    lin = lines[ln];//ln行目を収納

    String [] co = split(lin, ',');
    //カンマの前後で区切り配列に収納

    if (co.length == 3) {
      int x = int(co[0])-1;
      int y = int(co[1])-1;
      int M = 4*y+x;
      plot[x][y]++;
      if (int(co[2])==1) {
        maru[M].aka++;
      } else {
        maru[M].kuro++;
      }

      maru[M].count=plot[x][y];
    }
    ln++;//次の行に移行
  }
}



class Maru {
  int x, y;
  color col;
  int count;
  int aka;
  int kuro;

  Maru(int a, int b, int n, int R, int K) {
    x=a;
    y=b;
    count=n;
    aka =R;
    kuro =K;
    col = color(0);
  }

  void spot() {
    if (aka+kuro==0) {
      col = color(255);
    } else {
      //col = color(255*aka/(aka+kuro), 255*kuro/(aka+kuro), 255*kuro/(aka+kuro));
      col = color(255*aka/(aka+kuro), 0, 0);
    }
    noStroke();
    fill(col);
  }
}
