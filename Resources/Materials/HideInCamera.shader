﻿Shader "VRLabs/CameraSystem/HideInCamera"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _IsUserInVR ("Is User In VR", float) = 0
        _CurrentIndex ("Current Index", float) = 0
    }
    
    SubShader
    {
        Tags { 
            "RenderType" = "Opaque"
            "VRCFallback" = "Hidden"
        }    
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
                UNITY_VERTEX_OUTPUT_STEREO
            };

            UNITY_DECLARE_TEX2D(_MainTex);
            float4 _MainTex_ST;
            uniform float _VRChatCameraMode;
            float _CurrentIndex;
            float _IsUserInVR;
            
            bool isVR() {
                #if defined(USING_STEREO_MATRICES)
                return true;
                #else
                return false;
                #endif
            }
            
            v2f vert (appdata v)
            {
                v2f o;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_OUTPUT(v2f, o);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
                
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);

                if (_VRChatCameraMode > 0 || (!isVR() && _IsUserInVR == 1.0))
                {
                    o.vertex = float4(1E9, 1E9, 1E9, 1E9);
                }
                
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
                // Display number
                fixed4 col;
                if (i.uv.y < 0.7 && i.uv.y > 0.6 && i.uv.x > 0.0 && i.uv.x < 0.1)
                {
                    float2 offset = float2(i.uv.x % 0.1, i.uv.y % 0.1);
                    int index = _CurrentIndex + 1;
                    int x = index % 10;
                    int y = 9 - (index / 10);
                    float2 pos = float2(x, y) * 0.1 + offset;
                    col = UNITY_SAMPLE_TEX2D(_MainTex, pos);
                }else
                {
                    col = UNITY_SAMPLE_TEX2D(_MainTex, i.uv);
                }
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
