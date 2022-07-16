#import "boatd.h"

const GLKVector4 Cube_boardone_ambient = {0.000000, 0.000000, 0.000000, 1.000000};
const GLKVector4 Cube_boardone_diffuse = {0.640000, 0.640000, 0.640000, 1.000000};
const GLKVector4 Cube_boardone_specular = {0.500000, 0.500000, 0.500000, 1.000000};
const float Cube_boardone_shininess = 96.078430;

const RWTVertex Cube_boardone_Vertices[36] = {
    {{1.870725, 0.215133, -0.233841}, {1, 1, 1, 1}, {0.666667, 0.000000}, {0.000000, -1.000000, 0.000000}},
    {{1.870725, 0.215133, 0.233841}, {1, 1, 1, 1}, {1.000000, 0.000000}, {0.000000, -1.000000, 0.000000}},
    {{-1.870726, 0.215133, 0.233841}, {1, 1, 1, 1}, {1.000000, 0.333333}, {0.000000, -1.000000, 0.000000}},
    {{1.870726, -0.215133, -0.233841}, {1, 1, 1, 1}, {0.000000, 0.666667}, {0.000000, 1.000000, -0.000000}},
    {{-1.870725, -0.215133, -0.233841}, {1, 1, 1, 1}, {0.000000, 0.333333}, {0.000000, 1.000000, -0.000000}},
    {{-1.870726, -0.215133, 0.233841}, {1, 1, 1, 1}, {0.333333, 0.333334}, {0.000000, 1.000000, -0.000000}},
    {{1.870725, 0.215133, -0.233841}, {1, 1, 1, 1}, {0.666667, 0.333333}, {-1.000000, -0.000002, -0.000004}},
    {{1.870726, -0.215133, -0.233841}, {1, 1, 1, 1}, {0.333333, 0.333333}, {-1.000000, -0.000002, -0.000004}},
    {{1.870724, -0.215133, 0.233841}, {1, 1, 1, 1}, {0.333333, 0.000000}, {-1.000000, -0.000002, -0.000004}},
    {{1.870725, 0.215133, 0.233841}, {1, 1, 1, 1}, {0.000000, 0.333333}, {0.000000, -0.000000, -1.000000}},
    {{1.870724, -0.215133, 0.233841}, {1, 1, 1, 1}, {0.000000, 0.000000}, {0.000000, -0.000000, -1.000000}},
    {{-1.870726, -0.215133, 0.233841}, {1, 1, 1, 1}, {0.333333, 0.000000}, {0.000000, -0.000000, -1.000000}},
    {{-1.870726, -0.215133, 0.233841}, {1, 1, 1, 1}, {1.000000, 0.333333}, {1.000000, -0.000002, 0.000002}},
    {{-1.870725, -0.215133, -0.233841}, {1, 1, 1, 1}, {1.000000, 0.666667}, {1.000000, -0.000002, 0.000002}},
    {{-1.870725, 0.215133, -0.233841}, {1, 1, 1, 1}, {0.666667, 0.666667}, {1.000000, -0.000002, 0.000002}},
    {{1.870725, 0.215133, -0.233841}, {1, 1, 1, 1}, {0.666667, 0.333333}, {-0.000000, 0.000000, 1.000000}},
    {{-1.870725, 0.215133, -0.233841}, {1, 1, 1, 1}, {0.666667, 0.666667}, {-0.000000, 0.000000, 1.000000}},
    {{-1.870725, -0.215133, -0.233841}, {1, 1, 1, 1}, {0.333333, 0.666667}, {-0.000000, 0.000000, 1.000000}},
    {{-1.870725, 0.215133, -0.233841}, {1, 1, 1, 1}, {0.666667, 0.333333}, {0.000000, -1.000000, 0.000000}},
    {{1.870725, 0.215133, -0.233841}, {1, 1, 1, 1}, {0.666667, 0.000000}, {0.000000, -1.000000, 0.000000}},
    {{-1.870726, 0.215133, 0.233841}, {1, 1, 1, 1}, {1.000000, 0.333333}, {0.000000, -1.000000, 0.000000}},
    {{1.870724, -0.215133, 0.233841}, {1, 1, 1, 1}, {0.333333, 0.666667}, {0.000000, 1.000000, -0.000000}},
    {{1.870726, -0.215133, -0.233841}, {1, 1, 1, 1}, {0.000000, 0.666667}, {0.000000, 1.000000, -0.000000}},
    {{-1.870726, -0.215133, 0.233841}, {1, 1, 1, 1}, {0.333333, 0.333334}, {0.000000, 1.000000, -0.000000}},
    {{1.870725, 0.215133, 0.233841}, {1, 1, 1, 1}, {0.666667, 0.000000}, {-1.000000, 0.000003, 0.000000}},
    {{1.870725, 0.215133, -0.233841}, {1, 1, 1, 1}, {0.666667, 0.333333}, {-1.000000, 0.000003, 0.000000}},
    {{1.870724, -0.215133, 0.233841}, {1, 1, 1, 1}, {0.333333, 0.000000}, {-1.000000, 0.000003, 0.000000}},
    {{-1.870726, 0.215133, 0.233841}, {1, 1, 1, 1}, {0.333333, 0.333333}, {0.000000, -0.000000, -1.000000}},
    {{1.870725, 0.215133, 0.233841}, {1, 1, 1, 1}, {0.000000, 0.333333}, {0.000000, -0.000000, -1.000000}},
    {{-1.870726, -0.215133, 0.233841}, {1, 1, 1, 1}, {0.333333, 0.000000}, {0.000000, -0.000000, -1.000000}},
    {{-1.870726, 0.215133, 0.233841}, {1, 1, 1, 1}, {0.666667, 0.333333}, {1.000000, -0.000001, 0.000002}},
    {{-1.870726, -0.215133, 0.233841}, {1, 1, 1, 1}, {1.000000, 0.333333}, {1.000000, -0.000001, 0.000002}},
    {{-1.870725, 0.215133, -0.233841}, {1, 1, 1, 1}, {0.666667, 0.666667}, {1.000000, -0.000001, 0.000002}},
    {{1.870726, -0.215133, -0.233841}, {1, 1, 1, 1}, {0.333333, 0.333333}, {-0.000000, 0.000000, 1.000000}},
    {{1.870725, 0.215133, -0.233841}, {1, 1, 1, 1}, {0.666667, 0.333333}, {-0.000000, 0.000000, 1.000000}},
    {{-1.870725, -0.215133, -0.233841}, {1, 1, 1, 1}, {0.333333, 0.666667}, {-0.000000, 0.000000, 1.000000}},
};

