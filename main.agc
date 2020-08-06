// Project: agk_wurfelcraft 
// Created: 20-07-31

// show all errors

SetErrorMode(2)

//~#include ".\..\Templates\ShaderPack\Includes\SP_Common.agc"
//~#include ".\..\Templates\ShaderPack\Includes\SP_MeshManipulation.agc"

#include "voxel.agc"
#include "camera.agc"
#include "noise.agc"

// set window properties
SetWindowTitle( "agk_wurfelcraft" )
SetWindowSize( 1024, 768, 0 )
SetWindowAllowResize( 1 ) // allow the user to resize the window

// set display properties
SetVirtualResolution( 1024, 768 ) // doesn't have to match the window
SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
SetSyncRate( 0, 0 ) // 30fps instead of 60 to save battery
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 )

SetSkyBoxVisible(1)
SetDefaultMinFilter(0)
SetDefaultMagFilter(0)
SetDefaultWrapU(1)
SetDefaultWrapU(1)
SetGenerateMipmaps(0)

World as WorldData[18,18,18]
Object as ObjectData

Noise_Init()
Noise_Seed(257)

freq#=6.0
for X=1 to World.length-1
	for Y=1 to World[0].length-1
		for Z=1 to World[0,0].length-1
			Value#=abs(Noise_Perlin3(X/freq#,Y/freq#,Z/freq#))
			if Value#>0.3 then World[X,Y,Z].CubeType=1
		next Z
	next Y
next X

MemblockID=Voxel_InitWorld(Object,World)

do
    Print("FPS: "+str(ScreenFPS(),0))
    
    ControlCamera()
    
    Sync()
loop
