typedef enum {
    RWTVertexAttribPosition = 0,
    RWTVertexAttribColor,
    RWTVertexAttribTexCoord,
    RWTVertexAttribNormal
} RWTVertexAttributes;

typedef struct {
    GLfloat Position[3];//位置
    GLfloat Color[4];   //颜色
    GLfloat TexCoord[2];//纹理
    GLfloat Normal[3];  //
} RWTVertex;
