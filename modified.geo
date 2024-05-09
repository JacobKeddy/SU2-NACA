Include "n1412.geo";

ymax = 4;
xmax = 10;
n_inlet = 100;
n_vertical = 100;
r_vertical = 1/0.9;
n_airfoil = 65;
n_wake = 42;
r_wake = 1/0.9;

Point(500) = {-0.5, ymax, 0, 1.0};   // TOP LEFT
Point(501) = {-0.5, -ymax, 0, 1.0};  // BOTTOM RIGHT
Point(502) = {1, ymax, 0, 1.0};   // TOP CENTER
Point(503) = {1, -ymax, 0, 1.0};  // BOTTOM CENTER
Point(504) = {xmax, ymax, 0, 1.0};  // TOP RIGHT
Point(505) = {xmax, -ymax, 0, 1.0}; // BOTTOM RIGHT
Point(506) = {xmax, 0, 0, 1.0};     // CENTER RIGHT

Circle(4) = {500, 1, 501};          // INLET
Line(5) = {43, 500};                // UPPER INLET
Line(6) = {458, 501};               // LOWER INLET

Line(7) = {250, 502};               // UPPER VERTICAL
Line(8) = {250, 503};               // LOWER VERTICAL

Line(9) = {500, 502};               // TL-UC
Line(10) = {501, 503};              // BR-BC

Line(11) = {502, 504};              // TC-TR
Line(12) = {503, 505};              // BC-BR

Line(13) = {250, 506};              // TAIL-CR
Line(14) = {504, 506};              // TC-TR
Line(15) = {505, 506};              // BC-BR


// ------ INLET ------ //
Transfinite Curve {4, 1} = n_inlet Using Progression 1;
Curve Loop(1) = {4, -6, 1, 5};
Plane Surface(1) = {1};
Transfinite Surface {1};

// ------ VERTICAL ------ //
Transfinite Curve {5, 7, 14, 6, 8, 15} = n_vertical Using Progression r_vertical;

// ------ AIRFOIL ------ //
Transfinite Curve {9, 2, 3, 10} = n_airfoil Using Progression 1;

Curve Loop(2) = {2, 7, -9, -5};
Curve Loop(3) = {3, 6, 10, -8};

Plane Surface(2) = {2};
Plane Surface(3) = {3};

Transfinite Surface {2};
Transfinite Surface {3};

// ------ WAKE ------ //
Transfinite Curve {11, 13, 12} = n_wake Using Progression r_wake;

Curve Loop(4) = {7, 11, 14, -13};
Curve Loop(5) = {8, 12, 15, -13};

Plane Surface(4) = {4};
Plane Surface(5) = {5};

Transfinite Surface {4};
Transfinite Surface {5};

// Convert to Quad mesh
Recombine Surface {1, 2, 4, 5, 3};

// MARKERS inlet long outlet  farfield (all surface) airfoil
//Physical Curve("airfoil", 16) = {2, 1, 3};
//Physical Surface("farfield", 18) = {1, 2, 3, 4, 5};
//Physical Curve("inlet", 19) = {4, 9, 10,12,11};
//Physical Curve("outlet", 20) = {14, 15};


// MARKERS INLET (SHORT) OUTLET FARFIELD + CURVE AIRFOIL
//Physical Curve("airfoil", 16) = {2, 1, 3};
//Physical Surface("farfield", 18) = {1, 2, 3, 4, 5};
//Physical Curve("farfield", 17) = {11, 12};
//Physical Curve("inlet", 19) = {4, 9, 10};
//Physical Curve("outlet", 20) = {14, 15};

// MARKERS inlet long farfield (all surface + back curve) airfoil
//Physical Curve("airfoil", 16) = {2, 1, 3};
//Physical Surface("farfield", 18) = {1, 2, 3, 4, 5};
//Physical Curve("farfield", 17) = {14, 15};
//Physical Curve("inlet", 19) = {4, 9, 10,12,11};


// MARKERS INLET (SHORT) FARFIELD + CURVE AIRFOIL
//Physical Curve("airfoil", 16) = {2, 1, 3};
//Physical Surface("farfield", 18) = {1, 2, 3, 4, 5};
//Physical Curve("farfield", 17) = {11, 12,14,15};
//Physical Curve("inlet", 19) = {4, 9, 10};

//marker airfoil and farfield/
Physical Curve("airfoil", 16) = {2, 1, 3};
Physical Curve("farfield", 17) = {11, 12,14,15,4,9,10};
Physical Surface("farfield", 18) = {1, 2, 3, 4, 5};

// Physical Curve("farfield", 17) = {4, 9, 11, 14, 15, 12, 10};
