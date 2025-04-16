//OpenCASCADE
SetFactory("OpenCASCADE");

//mesh parameters
//numbeer of splits
//this allows change them in the menu box
nsplit = DefineNumber[20, Min 2, Max 50, Step 1, Name "Number of splits"];
//progression
//prog = DefineNumber[1.1, Min 1, Max 2, Step 0.1, Name "Progression"];
//prog2 = DefineNumber[1.2, Min 1, Max 2, Step 0.1, Name "Top/Bot Progression"];

//mesh parameters
diameter = 1; //circle = r*sin(45) = r*cos(45)
box = 5;
box2 = 50;

// Element scale
cs_el_sc = 0.1;

//points list: point(pt) = {x,y,z,cs_el_sc};
//circle points
Point(1) = {-0.3535533906, -0.3535533906, 0, cs_el_sc};
Point(2) = {0.3535533906, -0.3535533906, 0, cs_el_sc};
Point(3) = {0, 0, 0, cs_el_sc};
Point(4) = {-0.3535533906, 0.3535533906, 0, cs_el_sc};
Point(5) = {0.3535533906, 0.3535533906, 0, cs_el_sc};

//box points
Point(6) = {-box, -box, 0, cs_el_sc};
Point(7) = {box, -box, 0, cs_el_sc};
Point(8) = {-box, box, 0, cs_el_sc};
Point(9) = {box, box, 0, cs_el_sc};

//box2 points
Point(10) = {-box2, -box2/2, 0, cs_el_sc};
Point(11) = {-box, -box2/2, 0, cs_el_sc};
Point(12) = {box, -box2/2, 0, cs_el_sc};
Point(13) = {box2, -box2/2, 0, cs_el_sc};
Point(14) = {-box2, -box, 0, cs_el_sc};
Point(15) = {box2, -box, 0, cs_el_sc};
Point(16) = {-box2, box, 0, cs_el_sc};
Point(17) = {box2, box, 0, cs_el_sc};
Point(18) = {-box2, box2/2, 0, cs_el_sc};
Point(19) = {-box, box2/2, 0, cs_el_sc};
Point(20) = {box, box2/2, 0, cs_el_sc};
Point(21) = {box2, box2/2, 0, cs_el_sc};

//curves list
//circle arcs: Circle(line) = {start pt, center pt, end pt};
Circle(1) = {1, 3, 2};
Circle(2) = {2, 3, 5};
Circle(3) = {5, 3, 4};
Circle(4) = {4, 3, 1};

//box horizontal lines: Line(line) = {start pt, end pt};
Line(5) = {6, 7};
Line(6) = {8, 9};
//box vertical lines
Line(7) = {6, 8};
Line(8) = {7, 9};
//box diagonals from in to outwards
Line(9) = {1,6};
Line(10) = {2,7};
Line(11) = {5,9};
Line(12) = {4,8};

//box2 horizontal lines: Line(line) = {start pt, end pt};
Line(13) = {10, 11};
Line(14) = {11, 12};
Line(15) = {12, 13};
Line(16) = {14, 6};
Line(17) = {7, 15};
Line(18) = {16, 8};
Line(19) = {9, 17};
Line(20) = {18, 19};
Line(21) = {19, 20};
Line(22) = {20, 21};
//box2 vertical lines
Line(23) = {10, 14};
Line(24) = {14, 16};
Line(25) = {16, 18};
Line(26) = {11, 6};
Line(27) = {8, 19};
Line(28) = {12, 7};
Line(29) = {9, 20};
Line(30) = {13, 15};
Line(31) = {15, 17};
Line(32) = {17, 21};

//Surface list
//circle curve loop: Curve Loop(loop) = {line, line, line, line};
//surface: Surface(surface) = {loop};
//Curve Loop(1) = {1, 2, 3, 4};
//Surface(1) = {1};

//box curve loops
Curve Loop(3) = {5, -10, -1, 9};
Surface(3) = {3};
Curve Loop(5) = {10, 8, -11, -2};
Surface(5) = {5};
Curve Loop(7) = {11, -6, -12, -3};
Surface(7) = {7};
Curve Loop(9) = {-9, -4, 12, -7};
Surface(9) = {9};

//box2 curve loops
Curve Loop(11) = {13,26,-16,-23};
Surface(11) = {11};
Curve Loop(13) = {14,28,-5,-26};
Surface(13) = {13};
Curve Loop(15) = {15,30,-17,-28};
Surface(15) = {15};
Curve Loop(17) = {16,7,-18,-24};
Surface(17) = {17};
Curve Loop(19) = {17,31,-19,-8};
Surface(19) = {19};
Curve Loop(21) = {18,27,-20,-25};
Surface(21) = {21};
Curve Loop(23) = {6,29,-21,-27};
Surface(23) = {23};
Curve Loop(25) = {19,32,-22,-29};
Surface(25) = {25};

//Physical properties section
//Volume for fluid: Physical Surface("Fluid",1) = {surface};
Physical Surface("Fluid",1) = {3,5,7,9,11,13,15,17,19,21,23,25};

//Circle wall: Physical Curve("name",ID) = {line};
Physical Curve("Wal",2) = {1,2,3,4};

//Bottom and top walls
Physical Curve("Sym",3) = {13,14,15,20,21,22};

//Left and right walls
Physical Curve("Inf",4) = {23,24,25};
Physical Curve("Out",5) = {30,31,32};

//Transfinite section
//Transfinite Curve{2} = 20: forces 20 uniformly placed nodes (including end points) on curve 2 
//circle section
Transfinite Curve{9:12} = (nsplit+1) Using Progression 1.1;

//Edge division
Transfinite Curve{1,3,5,6,14,21} = (nsplit+1) Using Progression 1;
Transfinite Curve{2,4,7,8,24,31} = (nsplit+1) Using Progression 1;

//top and bot section
Transfinite Curve{25,27,29,32,-23,-26,-28,-30} = (nsplit+1)/2 Using Progression 1.3;

//left section
Transfinite Curve{-13,-16,-18,-20} = (nsplit+1) Using Progression 1.1;

//right section
Transfinite Curve{15,17,19,22} = (nsplit+1) Using Progression 1.1;

// The `Transfinite Surface' meshing constraint uses a transfinite interpolation
// algorithm in the parametric plane of the surface to connect the nodes on the
// boundary using a structured grid. If the surface has more than 4 corner
// points, the corners of the transfinite interpolation have to be specified by
// hand: Transfinite Surface{1} = {1, 2, 3, 4};
//Surface division
Transfinite Surface{3,5,7,9,11,13,15,17,19,21,23,25};
Recombine Surface{3,5,7,9,11,13,15,17,19,21,23,25};

//Meshing
Mesh 1;
Mesh 2;
Mesh 3;

SetOrder 2;
RenumberMeshElements;

//Mesh saving section
Mesh.Format = 1;
Mesh.MshFileVersion = 2.2;
Mesh.SaveAll = 0;
Mesh.Binary = 0;

Save "cylinder.msh";

