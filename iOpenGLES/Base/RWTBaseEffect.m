//
//  RWTBaseEffect.m
//  HelloOpenGL
//
//  Created by Ray Wenderlich on 9/3/13.
//  Copyright (c) 2013 Ray Wenderlich. All rights reserved.
//

#import "RWTBaseEffect.h"
#import "RWTVertex.h"

@implementation RWTBaseEffect {
    GLuint _programHandle;//程序句柄
    
    //全局变量
    GLuint _modelViewMatrixUniform;
    GLuint _projectionMatrixUniform;
    GLuint _texUniform;
    
    GLuint _lightColorUniform;
    GLuint _lightAmbientIntensityUniform;
    GLuint _lightDiffuseIntensityUniform;
    GLuint _lightDirectionUniform;
    
    GLuint _matSpecularIntensityUniform;
    GLuint _shininessUniform;
    GLuint _matAmbientColorUniform;
    GLuint _matSpecularColorUniform;
    GLuint _matDiffuseColorUniform;
}

- (GLuint)compileShader:(NSString*)shaderName withType:(GLenum)shaderType {
    NSString* shaderPath   = [[NSBundle mainBundle] pathForResource:shaderName ofType:nil];
    NSError* error = nil;
    NSString* shaderString = [NSString stringWithContentsOfFile:shaderPath encoding:NSUTF8StringEncoding error:&error];
    if (!shaderString) {
        NSLog(@"Error loading shader: %@", error.localizedDescription);
        exit(1);
    }
    //句柄
    GLuint shaderHandle = glCreateShader(shaderType);
    
    //加载shader
    const char *shaderStringUTF8 = [shaderString UTF8String];
//    int shaderStringLength       = (int)[shaderString length];
    // 不传shaderStringLength, 否则不能用中文注释
//    glShaderSource(shaderHandle, 1, &shaderStringUTF8, &shaderStringLength);
    glShaderSource(shaderHandle, 1, &shaderStringUTF8, NULL);
    
    //编译
    glCompileShader(shaderHandle);
    
    //检查编译结果
    GLint compileSuccess;
    glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &compileSuccess);
    if (compileSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetShaderInfoLog(shaderHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }
    
    return shaderHandle;
}

- (void)compileVertexShader:(NSString *)vertexShader
             fragmentShader:(NSString *)fragmentShader {
    //编译定点Shader
    GLuint vertexShaderName = [self compileShader:vertexShader
                                         withType:GL_VERTEX_SHADER];
    //编译fragment shader
    GLuint fragmentShaderName = [self compileShader:fragmentShader
                                           withType:GL_FRAGMENT_SHADER];
    
    //加载shader
    _programHandle = glCreateProgram();
    glAttachShader(_programHandle, vertexShaderName);
    glAttachShader(_programHandle, fragmentShaderName);
    
    //属性绑定, 便于区分
    glBindAttribLocation(_programHandle, RWTVertexAttribPosition, "a_Position");
    glBindAttribLocation(_programHandle, RWTVertexAttribColor,    "a_Color");
    glBindAttribLocation(_programHandle, RWTVertexAttribTexCoord, "a_TexCoord");
    glBindAttribLocation(_programHandle, RWTVertexAttribNormal,   "a_Normal");
    
    glLinkProgram(_programHandle);
    
    self.modelViewMatrix = GLKMatrix4Identity;
    
    //全局变量
    _modelViewMatrixUniform  = glGetUniformLocation(_programHandle, "u_ModelViewMatrix");
    _projectionMatrixUniform = glGetUniformLocation(_programHandle, "u_ProjectionMatrix");
    _texUniform              = glGetUniformLocation(_programHandle, "u_Texture");
    
    _lightColorUniform            = glGetUniformLocation(_programHandle, "u_Light.Color");
    _lightAmbientIntensityUniform = glGetUniformLocation(_programHandle, "u_Light.AmbientIntensity");
    _lightDiffuseIntensityUniform = glGetUniformLocation(_programHandle, "u_Light.DiffuseIntensity");
    _lightDirectionUniform        = glGetUniformLocation(_programHandle, "u_Light.Direction");
    
    _matSpecularIntensityUniform = glGetUniformLocation(_programHandle, "u_MatSpecularIntensity");
    _shininessUniform            = glGetUniformLocation(_programHandle, "u_Shininess");
    _matAmbientColorUniform      = glGetUniformLocation(_programHandle, "u_MatAmbientColor");
    _matDiffuseColorUniform      = glGetUniformLocation(_programHandle, "u_MatDiffuseColor");
    _matSpecularColorUniform     = glGetUniformLocation(_programHandle, "u_MatSpecularColor");
    
    GLint linkSuccess;
    glGetProgramiv(_programHandle, GL_LINK_STATUS, &linkSuccess);
    if (linkSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetProgramInfoLog(_programHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }
}

- (void)prepareToDraw {
    //加载基础属性
    glUseProgram(_programHandle);
    glUniformMatrix4fv(_modelViewMatrixUniform, 1, 0, self.modelViewMatrix.m);
    glUniformMatrix4fv(_projectionMatrixUniform, 1, 0, self.projectionMatrix.m);
    
    //激活纹理1, 并绑定纹理和纹理全局变量
    glActiveTexture(GL_TEXTURE1);
    glBindTexture(GL_TEXTURE_2D, self.texture);
    glUniform1i(_texUniform, 1);
    
    //设置光照
    glUniform3f(_lightColorUniform, 1, 1, 1);
    glUniform1f(_lightAmbientIntensityUniform, 0.1);
    GLKVector3 lightDirection = GLKVector3Normalize(GLKVector3Make(0, 1, -1));
    glUniform3f(_lightDirectionUniform, lightDirection.x, lightDirection.y, lightDirection.z);
    glUniform1f(_lightDiffuseIntensityUniform, 0.7);
    
    
    glUniform1f(_matSpecularIntensityUniform, 2.0);
    glUniform1f(_shininessUniform, self.shininess);
    glUniform3f(_matAmbientColorUniform, self.matAmbientColor.r, self.matAmbientColor.g, self.matAmbientColor.b);
    glUniform3f(_matDiffuseColorUniform, self.matDiffuseColor.r, self.matDiffuseColor.g, self.matDiffuseColor.b);
    glUniform3f(_matSpecularColorUniform, self.matSpecularColor.r, self.matSpecularColor.g, self.matSpecularColor.b);
    
}

- (instancetype)initWithVertexShader:(NSString *)vertexShader fragmentShader:
(NSString *)fragmentShader {
    if ((self = [super init])) {
        self.matAmbientColor  = GLKVector3Make(0.1, 0.1, 0.1);
        self.matDiffuseColor  = GLKVector3Make(0.7, 0.7, 0.7);
        self.matSpecularColor = GLKVector3Make(2.0, 2.0, 2.0);
        self.shininess        = 8.0;
        
        [self compileVertexShader:vertexShader fragmentShader:fragmentShader];
    }
    return self;
}

@end
