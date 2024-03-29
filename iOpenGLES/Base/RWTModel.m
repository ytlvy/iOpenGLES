//
//  RWTModel.m
//  HelloOpenGL
//
//  Created by Main Account on 3/18/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTModel.h"
#import "RWTBaseEffect.h"
#import <OpenGLES/ES2/glext.h>

@interface RWTModel(){
    char *       _name;           //名称
    GLuint       _vao;
    GLuint       _vertexBuffer;
    unsigned int _vertexCount;    //定点 个数
    RWTBaseEffect *_shader;
}

@end

@implementation RWTModel
- (instancetype)initWithName:(char *)name shader:(RWTBaseEffect *)shader vertices:(RWTVertex *)vertices vertexCount:(unsigned int)vertexCount {
    if ((self = [super init])) {
        
        _name          = name;
        _vertexCount   = vertexCount;
        _shader        = shader;
        
        self.position  = GLKVector3Make(0, 0, 0);
        self.rotationX = 0;
        self.rotationY = 0;
        self.rotationZ = 0;
        self.scale     = 1.0;
        
        //分配VAO
        glGenVertexArraysOES(1, &_vao);
        glBindVertexArrayOES(_vao);
        
        //生成定点Buffer
        glGenBuffers(1, &_vertexBuffer);
        glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
        glBufferData(GL_ARRAY_BUFFER, vertexCount * sizeof(RWTVertex), vertices, GL_STATIC_DRAW);//给buffer分配内存
        
        // 激活顶点数据
        glEnableVertexAttribArray(RWTVertexAttribPosition);
        glVertexAttribPointer(RWTVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(RWTVertex), (const GLvoid *) offsetof(RWTVertex, Position));
        
        // 激活颜色数据
        glEnableVertexAttribArray(RWTVertexAttribColor);
        glVertexAttribPointer(RWTVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(RWTVertex), (const GLvoid *) offsetof(RWTVertex, Color));
        
        //激活纹理坐标
        glEnableVertexAttribArray(RWTVertexAttribTexCoord);
        glVertexAttribPointer(RWTVertexAttribTexCoord, 2, GL_FLOAT, GL_FALSE, sizeof(RWTVertex), (const GLvoid *) offsetof(RWTVertex, TexCoord));
        
        glEnableVertexAttribArray(RWTVertexAttribNormal);
        glVertexAttribPointer(RWTVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, sizeof(RWTVertex), (const GLvoid *) offsetof(RWTVertex, Normal));
        
        //环境清理
        glBindVertexArrayOES(0);
        glBindBuffer(GL_ARRAY_BUFFER, 0);
        
    }
    return self;
}

- (GLKMatrix4)modelMatrix {
    GLKMatrix4 modelMatrix = GLKMatrix4Identity;
    modelMatrix = GLKMatrix4Translate(modelMatrix, self.position.x, self.position.y, self.position.z);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotationX, 1, 0, 0);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotationY, 0, 1, 0);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotationZ, 0, 0, 1);
    modelMatrix = GLKMatrix4Scale(modelMatrix, self.scale, self.scale, self.scale);
    return modelMatrix;
}

- (void)renderWithParentModelViewMatrix:(GLKMatrix4)parentModelViewMatrix {
    
    GLKMatrix4 modelViewMatrix = GLKMatrix4Multiply(parentModelViewMatrix, [self modelMatrix]);
    _shader.modelViewMatrix = modelViewMatrix;
    _shader.texture = self.texture;
    _shader.matAmbientColor = self.matAmbientColor;
    _shader.matDiffuseColor = self.matDiffuseColor;
    _shader.matSpecularColor = self.matSpecularColor;
    _shader.shininess = self.shininess;
    [_shader prepareToDraw];
    
    glBindVertexArrayOES(_vao);
    glDrawArrays(GL_TRIANGLES, 0, _vertexCount);
    glBindVertexArrayOES(0);
    
}

- (void)updateWithDelta:(NSTimeInterval)dt {
    
}

- (void)loadTexture:(NSString *)filename {
    NSError *error;
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
    
    NSDictionary *options = @{ GLKTextureLoaderOriginBottomLeft: @YES };
    GLKTextureInfo *info  = [GLKTextureLoader textureWithContentsOfFile:path options:options error:&error];
    if (info == nil) {
        NSLog(@"Error loading file: %@", error.localizedDescription);
    } else {
        self.texture = info.name;
    }
}

@end
