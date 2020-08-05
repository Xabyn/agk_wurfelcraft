// Data Types able to represent any AGK mesh
//~type Vec4Data
//~	X#
//~	Y#
//~	Z#
//~	W#
//~endtype

//~type Vec3Data
//~	X#
//~	Y#
//~	Z#
//~endtype

//~type Vec2Data
//~	X#
//~	Y#
//~endtype

//~type RGBAData
//~	Red#
//~	Green#
//~	Blue#
//~	Alpha#
//~endtype

//~type BoneData
//~	Weights as Vec4Data
//~	Idices as Vec4Data
//~endtype

//~type VertexData
//~	Pos as Vec3Data
//~	UV as Vec2Data
//~	Color as RGBAData
//~	Normal as Vec3Data
//~	Bone as BoneData
//~	Tangent as Vec3Data
//~	Bitangent as Vec3Data
//~endtype

//~type ObjectData
//~	Vertex as VertexData[]
//~	Index as integer[]
//~endtype

#constant FaceFront	1
#constant FaceBack	2
#constant FaceLeft	3
#constant FaceRight	4
#constant FaceUp		5
#constant FaceDown	6

type WorldData
	CubeType
endtype

global AtlasImageID

// Functions

// Initialise the Voxel Engine
function Voxel_InitWorld(World ref as WorldData[][][])
	AtlasImageID=LoadImage("terrain.png")
	
	VertexCount=4*5*2+4*4
	IndexCount=(VertexCount/4)*6
//~	ChunckObjectID=CreateObjectPlane(1,1)
//~	MeshID=GetObjectNumMeshes(ChunckObjectID)
	MemblockID=Voxel_CreateMeshMemblock(VertexCount)
//~	MemblockID=SP_CreateMeshMemblock(VertexCount,IndexCount,%11011)
	
	VertexID=0
	for X=1 to World.length-1
		for Y=1 to World[0].length-1
			for Z=1 to World[0,0].length-1
				VertexID=Voxel_AddCubeToObject(MemblockID,VertexID,World,X,Y,Z)
			next Z
		next Y
	next X
//~	Voxel_PrintMeshMemblock(MemblockID)
	ChunckObjectID=CreateObjectFromMeshMemblock(MemblockID)
//~	SetObjectMeshFromMemblock(ChunckObjectID,MeshID,MemblockID)
	DeleteMemblock(MemblockID)
	
	SetObjectCullMode(ChunckObjectID,0)
	
	DiffuseImageID=LoadImage("TestImage.png")
	SetObjectImage(ChunckObjectID,DiffuseImageID,0)

//~	NormalImageID=CreateImageColor(128,128,255,255)
//~	SetObjectNormalMap(ChunckObjectID,NormalImageID)
endfunction ChunckObjectID

// Add A Cube to an Object
function Voxel_AddCubeToObject(MemblockID,VertexID,World ref as WorldData[][][],X,Y,Z)
	if World[X,Y,Z].CubeType=1
		if World[X,Y,Z+1].CubeType=0
			Voxel_AddFaceToMemblock(MemblockID,VertexID,X,Y,Z,FaceFront)
			inc VertexID,4
		endif
		if World[X,Y,Z-1].CubeType=0
			Voxel_AddFaceToMemblock(MemblockID,VertexID,X,Y,Z,FaceBack)
			inc VertexID,4
		endif
		if World[X,Y+1,Z].CubeType=0
			Voxel_AddFaceToMemblock(MemblockID,VertexID,X,Y,Z,FaceUp)
			inc VertexID,4
		endif
		if World[X,Y-1,Z].CubeType=0
			Voxel_AddFaceToMemblock(MemblockID,VertexID,X,Y,Z,FaceDown)
			inc VertexID,4
		endif
		if World[X+1,Y,Z].CubeType=0
			Voxel_AddFaceToMemblock(MemblockID,VertexID,X,Y,Z,FaceRight)
			inc VertexID,4
		endif
		if World[X-1,Y,Z].CubeType=0
			Voxel_AddFaceToMemblock(MemblockID,VertexID,X,Y,Z,FaceLeft)
			inc VertexID,4
		endif
	endif
endfunction VertexID

// Populate the memblock with Data
function Voxel_AddFaceToMemblock(MemblockID,VertexID,X,Y,Z,FaceDir)
	VertexCount=GetMemblockInt(MemblockID,0)
	IndexCount=GetMemblockInt(MemblockID,4)
//~	Attributes=GetMemblockInt(MemblockID,8)
	VertexSize=GetMemblockInt(MemblockID,12)
	VertexOffset=GetMemblockInt(MemblockID,16)
	IndexOffset=GetMemblockInt(MemblockID,20)
	HalfFaceSize#=0.5
	Select FaceDir
		case FaceFront
			SetMeshMemblockVertexPosition(MemblockID,VertexID+0,X-HalfFaceSize#,Y+HalfFaceSize#,Z+HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,VertexID+1,X+HalfFaceSize#,Y+HalfFaceSize#,Z+HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,VertexID+2,X+HalfFaceSize#,Y-HalfFaceSize#,Z+HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,VertexID+3,X-HalfFaceSize#,Y-HalfFaceSize#,Z+HalfFaceSize#)
			
			SetMeshMemblockVertexNormal(MemblockID,VertexID+0,0,0,1)
			SetMeshMemblockVertexNormal(MemblockID,VertexID+1,0,0,1)
			SetMeshMemblockVertexNormal(MemblockID,VertexID+2,0,0,1)
			SetMeshMemblockVertexNormal(MemblockID,VertexID+3,0,0,1)
			
			SetMeshMemblockVertexUV(MemblockID,VertexID+0,1,0)
			SetMeshMemblockVertexUV(MemblockID,VertexID+1,0,0)
			SetMeshMemblockVertexUV(MemblockID,VertexID+2,0,1)
			SetMeshMemblockVertexUV(MemblockID,VertexID+3,1,1)
			
			SetMeshMemblockVertexColor(MemblockID,VertexID+0,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,VertexID+1,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,VertexID+2,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,VertexID+3,255,255,255,255)
		
			TangentOffset=3*4+3*4+2*4+4*1
			Offset=VertexOffset+(VertexID+0*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,-1,0,0)
			Offset=VertexOffset+(VertexID+1*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,-1,0,0)
			Offset=VertexOffset+(VertexID+2*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,-1,0,0)
			Offset=VertexOffset+(VertexID+3*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,-1,0,0)
			
			BitangentOffset=3*4+3*4+2*4+4*1+3*4
			Offset=VertexOffset+(VertexID+0*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
			Offset=VertexOffset+(VertexID+1*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
			Offset=VertexOffset+(VertexID+2*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
			Offset=VertexOffset+(VertexID+3*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
		endcase
		case FaceBack
			SetMeshMemblockVertexPosition(MemblockID,VertexID+0,X+HalfFaceSize#,Y+HalfFaceSize#,Z-HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,VertexID+1,X-HalfFaceSize#,Y+HalfFaceSize#,Z-HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,VertexID+2,X-HalfFaceSize#,Y-HalfFaceSize#,Z-HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,VertexID+3,X+HalfFaceSize#,Y-HalfFaceSize#,Z-HalfFaceSize#)
			
			SetMeshMemblockVertexNormal(MemblockID,VertexID+0,0,0,-1)
			SetMeshMemblockVertexNormal(MemblockID,VertexID+1,0,0,-1)
			SetMeshMemblockVertexNormal(MemblockID,VertexID+2,0,0,-1)
			SetMeshMemblockVertexNormal(MemblockID,VertexID+3,0,0,-1)
			
			SetMeshMemblockVertexUV(MemblockID,VertexID+0,1,0)
			SetMeshMemblockVertexUV(MemblockID,VertexID+1,0,0)
			SetMeshMemblockVertexUV(MemblockID,VertexID+2,0,1)
			SetMeshMemblockVertexUV(MemblockID,VertexID+3,1,1)
			
			SetMeshMemblockVertexColor(MemblockID,VertexID+0,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,VertexID+1,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,VertexID+2,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,VertexID+3,255,255,255,255)
		
			TangentOffset=3*4+3*4+2*4+4*1
			Offset=VertexOffset+(VertexID+0*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,1,0,0)
			Offset=VertexOffset+(VertexID+1*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,1,0,0)
			Offset=VertexOffset+(VertexID+2*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,1,0,0)
			Offset=VertexOffset+(VertexID+3*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,1,0,0)
			
			BitangentOffset=3*4+3*4+2*4+4*1+3*4
			Offset=VertexOffset+(VertexID+0*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
			Offset=VertexOffset+(VertexID+1*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
			Offset=VertexOffset+(VertexID+2*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
			Offset=VertexOffset+(VertexID+3*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
		endcase
		case FaceLeft
			SetMeshMemblockVertexPosition(MemblockID,VertexID+0,X-HalfFaceSize#,Y+HalfFaceSize#,Z-HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,VertexID+1,X-HalfFaceSize#,Y+HalfFaceSize#,Z+HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,VertexID+2,X-HalfFaceSize#,Y-HalfFaceSize#,Z+HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,VertexID+3,X-HalfFaceSize#,Y-HalfFaceSize#,Z-HalfFaceSize#)
			
			SetMeshMemblockVertexNormal(MemblockID,VertexID+0,-1,0,0)
			SetMeshMemblockVertexNormal(MemblockID,VertexID+1,-1,0,0)
			SetMeshMemblockVertexNormal(MemblockID,VertexID+2,-1,0,0)
			SetMeshMemblockVertexNormal(MemblockID,VertexID+3,-1,0,0)
			
			SetMeshMemblockVertexUV(MemblockID,VertexID+0,1,0)
			SetMeshMemblockVertexUV(MemblockID,VertexID+1,0,0)
			SetMeshMemblockVertexUV(MemblockID,VertexID+2,0,1)
			SetMeshMemblockVertexUV(MemblockID,VertexID+3,1,1)
			
			SetMeshMemblockVertexColor(MemblockID,VertexID+0,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,VertexID+1,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,VertexID+2,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,VertexID+3,255,255,255,255)
		
			TangentOffset=3*4+3*4+2*4+4*1
			Offset=VertexOffset+(VertexID+0*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,-1)
			Offset=VertexOffset+(VertexID+1*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,-1)
			Offset=VertexOffset+(VertexID+2*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,-1)
			Offset=VertexOffset+(VertexID+3*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,-1)
			
			BitangentOffset=3*4+3*4+2*4+4*1+3*4
			Offset=VertexOffset+(VertexID+0*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
			Offset=VertexOffset+(VertexID+1*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
			Offset=VertexOffset+(VertexID+2*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
			Offset=VertexOffset+(VertexID+3*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
		endcase
		case FaceRight
			SetMeshMemblockVertexPosition(MemblockID,VertexID+0,X+HalfFaceSize#,Y+HalfFaceSize#,Z+HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,VertexID+1,X+HalfFaceSize#,Y+HalfFaceSize#,Z-HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,VertexID+2,X+HalfFaceSize#,Y-HalfFaceSize#,Z-HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,VertexID+3,X+HalfFaceSize#,Y-HalfFaceSize#,Z+HalfFaceSize#)
			
			SetMeshMemblockVertexNormal(MemblockID,VertexID+0,1,0,0)
			SetMeshMemblockVertexNormal(MemblockID,VertexID+1,1,0,0)
			SetMeshMemblockVertexNormal(MemblockID,VertexID+2,1,0,0)
			SetMeshMemblockVertexNormal(MemblockID,VertexID+3,1,0,0)
			
			SetMeshMemblockVertexUV(MemblockID,VertexID+0,1,0)
			SetMeshMemblockVertexUV(MemblockID,VertexID+1,0,0)
			SetMeshMemblockVertexUV(MemblockID,VertexID+2,0,1)
			SetMeshMemblockVertexUV(MemblockID,VertexID+3,1,1)
			
			SetMeshMemblockVertexColor(MemblockID,VertexID+0,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,VertexID+1,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,VertexID+2,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,VertexID+3,255,255,255,255)
		
			TangentOffset=3*4+3*4+2*4+4*1
			Offset=VertexOffset+(VertexID+0*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,1)
			Offset=VertexOffset+(VertexID+1*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,1)
			Offset=VertexOffset+(VertexID+2*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,1)
			Offset=VertexOffset+(VertexID+3*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,1)
			
			BitangentOffset=3*4+3*4+2*4+4*1+3*4
			Offset=VertexOffset+(VertexID+0*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
			Offset=VertexOffset+(VertexID+1*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
			Offset=VertexOffset+(VertexID+2*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
			Offset=VertexOffset+(VertexID+3*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
		endcase
		case FaceUp
			SetMeshMemblockVertexPosition(MemblockID,VertexID+0,X+HalfFaceSize#,Y+HalfFaceSize#,Z+HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,VertexID+1,X-HalfFaceSize#,Y+HalfFaceSize#,Z+HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,VertexID+2,X-HalfFaceSize#,Y+HalfFaceSize#,Z-HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,VertexID+3,X+HalfFaceSize#,Y+HalfFaceSize#,Z-HalfFaceSize#)
			
			SetMeshMemblockVertexNormal(MemblockID,VertexID+0,0,1,0)
			SetMeshMemblockVertexNormal(MemblockID,VertexID+1,0,1,0)
			SetMeshMemblockVertexNormal(MemblockID,VertexID+2,0,1,0)
			SetMeshMemblockVertexNormal(MemblockID,VertexID+3,0,1,0)
			
			SetMeshMemblockVertexUV(MemblockID,VertexID+0,1,0)
			SetMeshMemblockVertexUV(MemblockID,VertexID+1,0,0)
			SetMeshMemblockVertexUV(MemblockID,VertexID+2,0,1)
			SetMeshMemblockVertexUV(MemblockID,VertexID+3,1,1)
			
			SetMeshMemblockVertexColor(MemblockID,VertexID+0,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,VertexID+1,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,VertexID+2,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,VertexID+3,255,255,255,255)
		
			TangentOffset=3*4+3*4+2*4+4*1
			Offset=VertexOffset+(VertexID+0*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,1,0,0)
			Offset=VertexOffset+(VertexID+1*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,1,0,0)
			Offset=VertexOffset+(VertexID+2*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,1,0,0)
			Offset=VertexOffset+(VertexID+3*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,1,0,0)
			
			BitangentOffset=3*4+3*4+2*4+4*1+3*4
			Offset=VertexOffset+(VertexID+0*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,1)
			Offset=VertexOffset+(VertexID+1*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,1)
			Offset=VertexOffset+(VertexID+2*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,1)
			Offset=VertexOffset+(VertexID+3*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,1)
		endcase
		case FaceDown
			SetMeshMemblockVertexPosition(MemblockID,VertexID+0,X-HalfFaceSize#,Y-HalfFaceSize#,Z+HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,VertexID+1,X+HalfFaceSize#,Y-HalfFaceSize#,Z+HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,VertexID+2,X+HalfFaceSize#,Y-HalfFaceSize#,Z-HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,VertexID+3,X-HalfFaceSize#,Y-HalfFaceSize#,Z-HalfFaceSize#)
			
			SetMeshMemblockVertexNormal(MemblockID,VertexID+0,0,-1,0)
			SetMeshMemblockVertexNormal(MemblockID,VertexID+1,0,-1,0)
			SetMeshMemblockVertexNormal(MemblockID,VertexID+2,0,-1,0)
			SetMeshMemblockVertexNormal(MemblockID,VertexID+3,0,-1,0)
			
			SetMeshMemblockVertexUV(MemblockID,VertexID+0,0,1)
			SetMeshMemblockVertexUV(MemblockID,VertexID+1,1,1)
			SetMeshMemblockVertexUV(MemblockID,VertexID+2,1,0)
			SetMeshMemblockVertexUV(MemblockID,VertexID+3,0,0)
			
			SetMeshMemblockVertexColor(MemblockID,VertexID+0,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,VertexID+1,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,VertexID+2,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,VertexID+3,255,255,255,255)
		
			TangentOffset=3*4+3*4+2*4+4*1 // Position+Normal+UV+Color Offsets
			Offset=VertexOffset+(VertexID+0*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,1,0,0)
			Offset=VertexOffset+(VertexID+1*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,1,0,0)
			Offset=VertexOffset+(VertexID+2*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,1,0,0)
			Offset=VertexOffset+(VertexID+3*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,1,0,0)
			
			BitangentOffset=3*4+3*4+2*4+4*1+3*4 // Position+Normal+UV+Color+Tanget Offsets
			Offset=VertexOffset+(VertexID+0*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,-1)
			Offset=VertexOffset+(VertexID+1*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,-1)
			Offset=VertexOffset+(VertexID+2*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,-1)
			Offset=VertexOffset+(VertexID+3*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,-1)
		endcase
	endselect
	
	Offset=IndexOffset+trunc(VertexID/4)*24
	SetMemblockInt(MemblockID,Offset+0*4,VertexID+0)
	SetMemblockInt(MemblockID,Offset+1*4,VertexID+1)
	SetMemblockInt(MemblockID,Offset+2*4,VertexID+2)
	SetMemblockInt(MemblockID,Offset+3*4,VertexID+2)
	SetMemblockInt(MemblockID,Offset+4*4,VertexID+3)
	SetMemblockInt(MemblockID,Offset+5*4,VertexID+0)
endfunction MemblockID

// Generate the mesh header for a simple one sided plane
// Position,Normal,UV,Color,Tangent and Bitangent Data
function Voxel_CreateMeshMemblock(VertexCount)
//~	VertexCount=4
	IndexCount=6*trunc(VertexCount/4)
	Attributes=6
	VertexSize=60
	VertexOffset=100
	IndexOffset=VertexOffset+(VertexCount*VertexSize)

	MemblockID=Creatememblock(IndexOffset+(IndexCount*4))
	SetMemblockInt(MemblockID,0,VertexCount)
	SetMemblockInt(MemblockID,4,IndexCount)
	SetMemblockInt(MemblockID,8,Attributes)
	SetMemblockInt(MemblockID,12,VertexSize)
	SetMemblockInt(MemblockID,16,VertexOffset)
	SetMemblockInt(MemblockID,20,IndexOffset)
	
	SetMemblockByte(MemblockID,24,0)
	SetMemblockByte(MemblockID,24+1,3)
	SetMemblockByte(MemblockID,24+2,0)
	SetMemblockByte(MemblockID,24+3,12)
	SetMemblockString(MemblockID,24+4,"position"+chr(0))	

	SetMemblockByte(MemblockID,40,0)
	SetMemblockByte(MemblockID,40+1,3)
	SetMemblockByte(MemblockID,40+2,0)
	SetMemblockByte(MemblockID,40+3,8)
	SetMemblockString(MemblockID,40+4,"normal"+chr(0))

	SetMemblockByte(MemblockID,52,0)
	SetMemblockByte(MemblockID,52+1,2)
	SetMemblockByte(MemblockID,52+2,0)
	SetMemblockByte(MemblockID,52+3,4)
	SetMemblockString(MemblockID,52+4,"uv"+chr(0))
	
	SetMemblockByte(MemblockID,60,1)
	SetMemblockByte(MemblockID,60+1,4)
	SetMemblockByte(MemblockID,60+2,1)
	SetMemblockByte(MemblockID,60+3,8)
	SetMemblockString(MemblockID,60+4,"color"+chr(0))

	SetMemblockByte(MemblockID,72,0)
	SetMemblockByte(MemblockID,72+1,3)
	SetMemblockByte(MemblockID,72+2,0)
	SetMemblockByte(MemblockID,72+3,8)
	SetMemblockString(MemblockID,72+4,"tangent"+chr(0))

	SetMemblockByte(MemblockID,84,0)
	SetMemblockByte(MemblockID,84+1,3)
	SetMemblockByte(MemblockID,84+2,0)
	SetMemblockByte(MemblockID,84+3,12)
	SetMemblockString(MemblockID,84+4,"bitangent"+chr(0))
endfunction MemblockID

function Voxel_WriteMeshMemblock(MemblockID,Object ref as ObjectData)
	VertexCount=Object.Vertex.length
	IndexCount=Object.Index.length
	Attributes=6
	VertexSize=60
	VertexOffset=100
	IndexOffset=VertexOffset+(VertexCount*VertexSize)
	MemblockSize=IndexOffset+(IndexCount*4)
	TangentOffset=3*4+3*4+2*4+4*1
	BitangentOffset=3*4+3*4+2*4+4*1+3*4
	for VertexID=0 to Object.Vertex.length
		Offset=VertexOffset+(VertexID*VertexSize)
		SetMeshMemblockVertexPosition(MemblockID,VertexID,Object.Vertex[VertexID].Pos.X#,Object.Vertex[VertexID].Pos.Y#,Object.Vertex[VertexID].Pos.Z#)
		SetMeshMemblockVertexNormal(MemblockID,VertexID,Object.Vertex[VertexID].Normal.X#,Object.Vertex[VertexID].Normal.Y#,Object.Vertex[VertexID].Normal.Z#)
		SetMeshMemblockVertexUV(MemblockID,VertexID,Object.Vertex[VertexID].UV.X#,Object.Vertex[VertexID].UV.Y#)
		SetMeshMemblockVertexColor(MemblockID,VertexID,Object.Vertex[VertexID].Color.Red#,Object.Vertex[VertexID].Color.Green#,Object.Vertex[VertexID].Color.Blue#,Object.Vertex[VertexID].Color.Alpha#)
		Offset=VertexOffset+(VertexID*VertexSize)+TangentOffset
		Voxel_SetMemblockVec3(MemblockID,Offset,Object.Vertex[VertexID].Tangent.X#,Object.Vertex[VertexID].Tangent.Y#,Object.Vertex[VertexID].Tangent.Z#)
		Offset=VertexOffset+(VertexID*VertexSize)+BitangentOffset
		Voxel_SetMemblockVec3(MemblockID,Offset,Object.Vertex[VertexID].Bitangent.X#,Object.Vertex[VertexID].Bitangent.Y#,Object.Vertex[VertexID].Bitangent.Z#)
	next VertexID
	
	for IndexID=0 to Object.Index.length
		Offset=IndexOffset+IndexID*4
		SetMemblockInt(MemblockID,Offset,Object.Index[IndexID])
    next IndexID
endfunction

// just print the mesh header
function Voxel_PrintMeshMemblock(MemblockID)
	local VertexCount as integer
	local IndexCount as integer
	local Attributes as integer
	local VertexSize as integer
	local VertexOffset as integer
	local IndexOffset as integer
	local AttributeOffset as integer
	local ID as integer
	local Stringlength as integer

	VertexCount=GetMemblockInt(MemblockID,0)
	IndexCount=GetMemblockInt(MemblockID,4)
	Attributes=GetMemblockInt(MemblockID,8)
	VertexSize=GetMemblockInt(MemblockID,12)
	VertexOffset=GetMemblockInt(MemblockID,16)
	IndexOffset=GetMemblockInt(MemblockID,20)
	AttributeOffset=24

	message("VertexCount: "+str(VertexCount)+chr(10)+"IndexCount: "+str(IndexCount)+chr(10)+"Attributes: "+str(Attributes)+chr(10)+"VertexSize: "+str(VertexSize)+chr(10)+"VertexOffset: "+str(VertexOffset)+chr(10)+"IndexOffset: "+str(IndexOffset))

	for ID=1 to Attributes
		Stringlength=GetMemblockByte(MemblockID,AttributeOffset+3) // string length
		message("type: "+str(GetMemblockByte(MemblockID,AttributeOffset))+chr(10)+"components: "+str(GetMemblockByte(MemblockID,AttributeOffset+1))+chr(10)+"normalize: "+str(GetMemblockByte(MemblockID,AttributeOffset+2))+chr(10)+"length: "+str(Stringlength)+chr(10)+"string: "+GetMemblockString(MemblockID,AttributeOffset+4,Stringlength)) // string
		inc AttributeOffset,4+StringLength
	next
endfunction

// needed to set Tangent and Bitangent vectors
function Voxel_SetMemblockVec3(MemblockID,Offset,x#,y#,z#)
	SetMemblockFloat(MemblockID,Offset,x#)
	SetMemblockFloat(MemblockID,Offset+4,y#)
	SetMemblockFloat(MemblockID,Offset+8,z#)
endfunction