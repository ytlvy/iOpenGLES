varying lowp vec4 frag_Color;
varying lowp vec2 frag_TexCoord;
varying lowp vec3 frag_Normal;
varying lowp vec3 frag_Position;

uniform sampler2D   u_Texture;
uniform highp float u_MatSpecularIntensity;
uniform highp float u_Shininess;
uniform lowp vec3   u_MatAmbientColor;
uniform lowp vec3   u_MatSpecularColor;
uniform lowp vec3   u_MatDiffuseColor;

struct Light {
    lowp vec3  Color;
    lowp float AmbientIntensity;
    lowp float DiffuseIntensity;
    lowp vec3  Direction;
};

uniform Light u_Light;

void main(void) {
    
    //Ambient环境光 环境光的颜色 = 光源颜色 * 环境光系数
    //着色到物体上的环境光颜色 = 物体的基色 * 环境光颜色
    lowp vec3  AmbientColor = u_Light.Color * u_MatAmbientColor;
    
    //Diffuse漫反射光 漫反射光颜色 = 光源颜色 * max(0, dot(光照方向，物体表面法向))
    //着色到物体上的漫反射光颜色 = 物体基色 * 漫反射光颜色
    lowp vec3  Normal         = normalize(frag_Normal);//物体表面法向
    lowp float DiffuseFactor  = max(-dot(Normal, u_Light.Direction), 0.0);
    lowp vec3  DiffuseColor   = u_Light.Color * u_MatDiffuseColor * DiffuseFactor;
    
    //Specular镜面光
    //镜面光颜色 = 光源颜色 * 镜面光系数 * pow(max(dot(反射光方向，查看方向的反向), 0), shininess128)
    //pow操作，可以让参数大小对结果的变化比率增加，参数微小变化都会对结果产生较大变化，pow次数越多，光点越小，通常取32-256，
    //shininess体现了材质的属性，不同材质的shininess不同
    lowp vec3  Eye            = normalize(frag_Position);
    lowp vec3  Reflection     = reflect(u_Light.Direction, Normal);
    lowp float SpecularFactor = pow(max(0.0, -dot(Reflection, Eye)), u_Shininess);
    lowp vec3  SpecularColor  = u_Light.Color * u_MatSpecularColor * SpecularFactor;
    
    gl_FragColor = texture2D(u_Texture, frag_TexCoord) * vec4((AmbientColor + DiffuseColor + SpecularColor), 1.0);
}
