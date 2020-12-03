// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "ShaderBook/06/PixelDiffuse"
{
    Properties
    {
        _Diffuse ("Diffuse", Color) = (1, 1, 1, 1)
    }
    SubShader
    {
        Tags { "LightMode" = "ForwardBase" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "Lighting.cginc"
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal :NORMAL;
            };

            struct v2f
            {
                float3 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            fixed4 _Diffuse;

            v2f vert (appdata v)
            {
                v2f o;
                //将顶点从对象空间转为投影空间
                o.vertex = UnityObjectToClipPos(v.vertex);
                //将发现从对象空间转为世界空间
                o.uv = mul(v.normal, (float3x3)unity_WorldToObject);

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                //获得环境光
                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
                //获得从顶点着色器中传出的法线(世界坐标)
                fixed3 worldNormal = normalize(i.uv);
                //计算世界空间中的光照方向
                fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
                //计算漫反射(diffuse)
                fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * saturate(dot(worldNormal, worldLightDir));

                fixed3 col = ambient + diffuse;
                return fixed4(col, 1.0);
            }
            ENDCG
        }
    }
}
