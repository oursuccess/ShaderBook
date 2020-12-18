// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "ShaderBook/08/AlphaTest"
{
    Properties
    {
    }
    SubShader
    {
        Tags { "LightMode"="ForwardBase" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "Lighting.cginc"

            struct appdata
            {
              
            };

            struct v2f
            {
               
            };

            v2f vert (appdata v)
            {
                v2f o;
               
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                return fixed4(ambient + diffuse + specular, 1.0);
            }
            ENDCG
        }
    }
    FallBack "Specular"
}
