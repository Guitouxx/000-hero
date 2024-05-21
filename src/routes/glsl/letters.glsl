

/**
* Generate a Line of dot for a specific letter
* cell vec2 position of the cell
* SC vec2 position of the letter (bottom left)
* vec2 points[] points to draw (x -> index of x dots, y -> number of dots to draw)
* float yIndex Line Y
* float scaling Progressive scaling
**/
float generateLine(in vec2 cell, in vec2 SC, in vec2 points[2], in float yIndex, in float scaling) {
  float x = 0.;

  for(int i = 0;i < points.length(); i++) {
    x += inRange(cell.x, SC.x + points[i].x, SC.x + points[i].x + points[i].y - 1.);
  }

  x *= scaling;
  float y = inRange(cell.y, SC.y + yIndex, SC.y + yIndex);

  return x * y; 
}

/**
* Add the whole text
* cell vec2 position of the cell
* SC vec2 position of the letter (bottom left)
* mouse Mouse coordinates
**/
float generateText(in vec2 cell, in vec2 SC, in float mouse) {
  float final = 0.;

  //number of dot per rows
  float rowSize = 59.;

  // single ratio for one dot
  float singleRatio = 1./rowSize;

  //current cell ratio
  float cellRatio = (cell.x - SC.x + 1.) / rowSize;

  // scaling random
  float noiseRandom = snoise(cell + uTime) * 2.;
  float scalingEasing = noiseRandom + mouse * (5.);
  
  //smoothstep to update the scale
  float scaling = smoothstep(cellRatio - singleRatio, cellRatio, scalingEasing);

  // H 
  for(int i=0; i<5; i++) {
    final += generateLine(cell, SC, vec2[](vec2(0., 4.), vec2(6.,4.)), float(i), scaling);
  }
  for(int i=0; i<4; i++) {
    final += generateLine(cell, SC, vec2[](vec2(0.), vec2(0.,10.)), float(i) + 5., scaling);
  }
  for(int i=0; i<5; i++) {
    final += generateLine(cell, SC, vec2[](vec2(0., 4.), vec2(6.,4.)), float(i) + 9., scaling);
  }

  // E 
  SC += vec2(11., 0.);
  
  for(int i=0; i<3; i++) {
    final += generateLine(cell, SC, vec2[](vec2(0.), vec2(0.,8.)), float(i), scaling);
  }
  for(int i=0; i<2; i++) {
    final += generateLine(cell, SC, vec2[](vec2(0.), vec2(0.,3.)), float(i) + 3., scaling);
  }
  for(int i=0; i<4; i++) {
    final += generateLine(cell, SC, vec2[](vec2(0.), vec2(0.,6.)), float(i) + 5., scaling);
  }
  for(int i=0; i<2; i++) {
    final += generateLine(cell, SC, vec2[](vec2(0.), vec2(0.,3.)), float(i) + 9., scaling);
  }
  for(int i=0; i<3; i++) {
    final += generateLine(cell, SC, vec2[](vec2(0.), vec2(0.,8.)), float(i) + 11., scaling);
  }

  // L
  SC += vec2(9., 0.);
  
  for(int i=0; i<3; i++) {
    final += generateLine(cell, SC, vec2[](vec2(0.), vec2(0.,8.)), float(i), scaling);
  }
  for(int i=0; i<11; i++) {
    final += generateLine(cell, SC, vec2[](vec2(0.), vec2(0.,3.)), float(i) + 3., scaling);
  }

  // L
  SC += vec2(9., 0.);
  
  for(int i=0; i<3; i++) {
    final += generateLine(cell, SC, vec2[](vec2(0.), vec2(0.,8.)), float(i), scaling);
  }
  for(int i=0; i<11; i++) {
    final += generateLine(cell, SC, vec2[](vec2(0.), vec2(0.,3.)), float(i) + 3., scaling);
  }

  // O
  SC += vec2(8., 0.);
  final += generateLine(cell, SC, vec2[](vec2(0.), vec2(3.,5.)), 0., scaling);
  final += generateLine(cell, SC, vec2[](vec2(0.), vec2(2.,7.)), 1., scaling);
  final += generateLine(cell, SC, vec2[](vec2(0.), vec2(1.,9.)), 2., scaling);
  final += generateLine(cell, SC, vec2[](vec2(0.), vec2(1.,9.)), 3., scaling);
  final += generateLine(cell, SC, vec2[](vec2(1., 3.), vec2(7., 3.)), 4., scaling);
  final += generateLine(cell, SC, vec2[](vec2(1., 3.), vec2(7., 3.)), 5., scaling);
  final += generateLine(cell, SC, vec2[](vec2(1., 3.), vec2(7., 3.)), 6., scaling);
  final += generateLine(cell, SC, vec2[](vec2(1., 3.), vec2(7., 3.)), 7., scaling);
  final += generateLine(cell, SC, vec2[](vec2(1., 3.), vec2(7., 3.)), 8., scaling);
  final += generateLine(cell, SC, vec2[](vec2(1., 3.), vec2(7., 3.)), 9., scaling);
  final += generateLine(cell, SC, vec2[](vec2(0.), vec2(1.,9.)), 10., scaling);
  final += generateLine(cell, SC, vec2[](vec2(0.), vec2(1.,9.)), 11., scaling);
  final += generateLine(cell, SC, vec2[](vec2(0.), vec2(2.,7.)), 12., scaling);
  final += generateLine(cell, SC, vec2[](vec2(0.), vec2(3.,5.)), 13., scaling);
  
  return final;
}
