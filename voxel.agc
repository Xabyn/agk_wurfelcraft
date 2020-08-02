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
//~	MaterialID as integer
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


// Functions

// Initialise the Voxel Engine
function Voxel_InitWorld()
	ChunckObjectID=CreateObjectPlane(1,1)
	
	Voxel_AddCubeToObject(ChunckObjectID,0,0,0)
	Voxel_AddCubeToObject(ChunckObjectID,10,10,10)
	
	DiffuseImageID=LoadImage("TestImage.png")
	SetObjectImage(ChunckObjectID,DiffuseImageID,0)
//~	NormalImageID=CreateImageColor(128,128,255,255)
//~	SetObjectNormalMap(ChunckObjectID,NormalImageID)
endfunction ChunckObjectID

// Add A Cube to an Object
// here should be the neighbour check
// to save some faces the future
function Voxel_AddCubeToObject(Object,X,Y,Z)
	MemblockID=Voxel_CreateMeshMemblock()
	Voxel_AddFaceToMemblock(MemblockID,X,Y,Z,FaceFront)
	AddObjectMeshFromMemblock(Object,MemblockID)

	MemblockID=Voxel_CreateMeshMemblock()
	Voxel_AddFaceToMemblock(MemblockID,X,Y,Z,FaceBack)
	AddObjectMeshFromMemblock(Object,MemblockID)

	MemblockID=Voxel_CreateMeshMemblock()
	Voxel_AddFaceToMemblock(MemblockID,X,Y,Z,FaceLeft)
	AddObjectMeshFromMemblock(Object,MemblockID)
	
	MemblockID=Voxel_CreateMeshMemblock()
	Voxel_AddFaceToMemblock(MemblockID,X,Y,Z,FaceRight)
	AddObjectMeshFromMemblock(Object,MemblockID)
	
	MemblockID=Voxel_CreateMeshMemblock()
	Voxel_AddFaceToMemblock(MemblockID,X,Y,Z,FaceUp)
	AddObjectMeshFromMemblock(Object,MemblockID)
	
	MemblockID=Voxel_CreateMeshMemblock()
	Voxel_AddFaceToMemblock(MemblockID,X,Y,Z,FaceDown)
	AddObjectMeshFromMemblock(Object,MemblockID)
endfunction

// Populate the memblock with Face Data
function Voxel_AddFaceToMemblock(MemblockID,X,Y,Z,FaceDir)
	VertexCount=GetMemblockInt(MemblockID,0)
	VertexSize=GetMemblockInt(MemblockID,12)
	VertexOffset=GetMemblockInt(MemblockID,16)
	IndexOffset=GetMemblockInt(MemblockID,20)
	HalfFaceSize#=5
	Select FaceDir
		case	FaceFront
			SetMeshMemblockVertexPosition(MemblockID,0,X-HalfFaceSize#,Y+HalfFaceSize#,Z+HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,1,X+HalfFaceSize#,Y+HalfFaceSize#,Z+HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,2,X+HalfFaceSize#,Y-HalfFaceSize#,Z+HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,3,X-HalfFaceSize#,Y-HalfFaceSize#,Z+HalfFaceSize#)
			
			SetMeshMemblockVertexNormal(MemblockID,0,0,0,1)
			SetMeshMemblockVertexNormal(MemblockID,1,0,0,1)
			SetMeshMemblockVertexNormal(MemblockID,2,0,0,1)
			SetMeshMemblockVertexNormal(MemblockID,3,0,0,1)
			
			SetMeshMemblockVertexUV(MemblockID,0,1,0)
			SetMeshMemblockVertexUV(MemblockID,1,0,0)
			SetMeshMemblockVertexUV(MemblockID,2,0,1)
			SetMeshMemblockVertexUV(MemblockID,3,1,1)
			
			SetMeshMemblockVertexColor(MemblockID,0,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,1,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,2,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,3,255,255,255,255)
		
			TangentOffset=3*4+3*4+2*4+4*1
			Offset=VertexOffset+(0*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,-1,0,0)
			Offset=VertexOffset+(1*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,-1,0,0)
			Offset=VertexOffset+(2*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,-1,0,0)
			Offset=VertexOffset+(3*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,-1,0,0)
			
			BitangentOffset=3*4+3*4+2*4+4*1+3*4
			Offset=VertexOffset+(0*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
			Offset=VertexOffset+(1*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
			Offset=VertexOffset+(2*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
			Offset=VertexOffset+(3*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
		endcase
		case	FaceBack
			SetMeshMemblockVertexPosition(MemblockID,0,X+HalfFaceSize#,Y+HalfFaceSize#,Z-HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,1,X-HalfFaceSize#,Y+HalfFaceSize#,Z-HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,2,X-HalfFaceSize#,Y-HalfFaceSize#,Z-HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,3,X+HalfFaceSize#,Y-HalfFaceSize#,Z-HalfFaceSize#)
			
			SetMeshMemblockVertexNormal(MemblockID,0,0,0,-1)
			SetMeshMemblockVertexNormal(MemblockID,1,0,0,-1)
			SetMeshMemblockVertexNormal(MemblockID,2,0,0,-1)
			SetMeshMemblockVertexNormal(MemblockID,3,0,0,-1)
			
			SetMeshMemblockVertexUV(MemblockID,0,1,0)
			SetMeshMemblockVertexUV(MemblockID,1,0,0)
			SetMeshMemblockVertexUV(MemblockID,2,0,1)
			SetMeshMemblockVertexUV(MemblockID,3,1,1)
			
			SetMeshMemblockVertexColor(MemblockID,0,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,1,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,2,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,3,255,255,255,255)
		
			TangentOffset=3*4+3*4+2*4+4*1
			Offset=VertexOffset+(0*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,1,0,0)
			Offset=VertexOffset+(1*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,1,0,0)
			Offset=VertexOffset+(2*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,1,0,0)
			Offset=VertexOffset+(3*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,1,0,0)
			
			BitangentOffset=3*4+3*4+2*4+4*1+3*4
			Offset=VertexOffset+(0*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
			Offset=VertexOffset+(1*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
			Offset=VertexOffset+(2*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
			Offset=VertexOffset+(3*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
		endcase
		case	FaceLeft
			SetMeshMemblockVertexPosition(MemblockID,0,X-HalfFaceSize#,Y+HalfFaceSize#,Z-HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,1,X-HalfFaceSize#,Y+HalfFaceSize#,Z+HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,2,X-HalfFaceSize#,Y-HalfFaceSize#,Z+HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,3,X-HalfFaceSize#,Y-HalfFaceSize#,Z-HalfFaceSize#)
			
			SetMeshMemblockVertexNormal(MemblockID,0,-1,0,0)
			SetMeshMemblockVertexNormal(MemblockID,1,-1,0,0)
			SetMeshMemblockVertexNormal(MemblockID,2,-1,0,0)
			SetMeshMemblockVertexNormal(MemblockID,3,-1,0,0)
			
			SetMeshMemblockVertexUV(MemblockID,0,1,0)
			SetMeshMemblockVertexUV(MemblockID,1,0,0)
			SetMeshMemblockVertexUV(MemblockID,2,0,1)
			SetMeshMemblockVertexUV(MemblockID,3,1,1)
			
			SetMeshMemblockVertexColor(MemblockID,0,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,1,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,2,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,3,255,255,255,255)
		
			TangentOffset=3*4+3*4+2*4+4*1
			Offset=VertexOffset+(0*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,-1)
			Offset=VertexOffset+(1*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,-1)
			Offset=VertexOffset+(2*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,-1)
			Offset=VertexOffset+(3*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,-1)
			
			BitangentOffset=3*4+3*4+2*4+4*1+3*4
			Offset=VertexOffset+(0*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
			Offset=VertexOffset+(1*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
			Offset=VertexOffset+(2*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
			Offset=VertexOffset+(3*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
		endcase
		case	FaceRight
			SetMeshMemblockVertexPosition(MemblockID,0,X+HalfFaceSize#,Y+HalfFaceSize#,Z+HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,1,X+HalfFaceSize#,Y+HalfFaceSize#,Z-HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,2,X+HalfFaceSize#,Y-HalfFaceSize#,Z-HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,3,X+HalfFaceSize#,Y-HalfFaceSize#,Z+HalfFaceSize#)
			
			SetMeshMemblockVertexNormal(MemblockID,0,1,0,0)
			SetMeshMemblockVertexNormal(MemblockID,1,1,0,0)
			SetMeshMemblockVertexNormal(MemblockID,2,1,0,0)
			SetMeshMemblockVertexNormal(MemblockID,3,1,0,0)
			
			SetMeshMemblockVertexUV(MemblockID,0,1,0)
			SetMeshMemblockVertexUV(MemblockID,1,0,0)
			SetMeshMemblockVertexUV(MemblockID,2,0,1)
			SetMeshMemblockVertexUV(MemblockID,3,1,1)
			
			SetMeshMemblockVertexColor(MemblockID,0,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,1,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,2,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,3,255,255,255,255)
		
			TangentOffset=3*4+3*4+2*4+4*1
			Offset=VertexOffset+(0*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,1)
			Offset=VertexOffset+(1*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,1)
			Offset=VertexOffset+(2*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,1)
			Offset=VertexOffset+(3*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,1)
			
			BitangentOffset=3*4+3*4+2*4+4*1+3*4
			Offset=VertexOffset+(0*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
			Offset=VertexOffset+(1*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
			Offset=VertexOffset+(2*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
			Offset=VertexOffset+(3*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,1,0)
		endcase
		case	FaceUp
			SetMeshMemblockVertexPosition(MemblockID,0,X+HalfFaceSize#,Y+HalfFaceSize#,Z+HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,1,X-HalfFaceSize#,Y+HalfFaceSize#,Z+HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,2,X-HalfFaceSize#,Y+HalfFaceSize#,Z-HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,3,X+HalfFaceSize#,Y+HalfFaceSize#,Z-HalfFaceSize#)
			
			SetMeshMemblockVertexNormal(MemblockID,0,0,1,0)
			SetMeshMemblockVertexNormal(MemblockID,1,0,1,0)
			SetMeshMemblockVertexNormal(MemblockID,2,0,1,0)
			SetMeshMemblockVertexNormal(MemblockID,3,0,1,0)
			
			SetMeshMemblockVertexUV(MemblockID,0,1,0)
			SetMeshMemblockVertexUV(MemblockID,1,0,0)
			SetMeshMemblockVertexUV(MemblockID,2,0,1)
			SetMeshMemblockVertexUV(MemblockID,3,1,1)
			
			SetMeshMemblockVertexColor(MemblockID,0,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,1,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,2,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,3,255,255,255,255)
		
			TangentOffset=3*4+3*4+2*4+4*1
			Offset=VertexOffset+(0*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,1,0,0)
			Offset=VertexOffset+(1*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,1,0,0)
			Offset=VertexOffset+(2*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,1,0,0)
			Offset=VertexOffset+(3*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,1,0,0)
			
			BitangentOffset=3*4+3*4+2*4+4*1+3*4
			Offset=VertexOffset+(0*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,1)
			Offset=VertexOffset+(1*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,1)
			Offset=VertexOffset+(2*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,1)
			Offset=VertexOffset+(3*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,1)
		endcase
		case	FaceDown
			SetMeshMemblockVertexPosition(MemblockID,0,X-HalfFaceSize#,Y-HalfFaceSize#,Z+HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,1,X+HalfFaceSize#,Y-HalfFaceSize#,Z+HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,2,X+HalfFaceSize#,Y-HalfFaceSize#,Z-HalfFaceSize#)
			SetMeshMemblockVertexPosition(MemblockID,3,X-HalfFaceSize#,Y-HalfFaceSize#,Z-HalfFaceSize#)
			
			SetMeshMemblockVertexNormal(MemblockID,0,0,-1,0)
			SetMeshMemblockVertexNormal(MemblockID,1,0,-1,0)
			SetMeshMemblockVertexNormal(MemblockID,2,0,-1,0)
			SetMeshMemblockVertexNormal(MemblockID,3,0,-1,0)
			
			SetMeshMemblockVertexUV(MemblockID,0,0,1)
			SetMeshMemblockVertexUV(MemblockID,1,1,1)
			SetMeshMemblockVertexUV(MemblockID,2,1,0)
			SetMeshMemblockVertexUV(MemblockID,3,0,0)
			
			SetMeshMemblockVertexColor(MemblockID,0,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,1,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,2,255,255,255,255)
			SetMeshMemblockVertexColor(MemblockID,3,255,255,255,255)
		
			TangentOffset=3*4+3*4+2*4+4*1
			Offset=VertexOffset+(0*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,1,0,0)
			Offset=VertexOffset+(1*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,1,0,0)
			Offset=VertexOffset+(2*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,1,0,0)
			Offset=VertexOffset+(3*VertexSize)+TangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,1,0,0)
			
			BitangentOffset=3*4+3*4+2*4+4*1+3*4
			Offset=VertexOffset+(0*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,-1)
			Offset=VertexOffset+(1*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,-1)
			Offset=VertexOffset+(2*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,-1)
			Offset=VertexOffset+(3*VertexSize)+BitangentOffset
			Voxel_SetMemblockVec3(MemblockID,Offset,0,0,-1)
		endcase
	endselect

	SetMemblockInt(MemblockID,IndexOffset+0*4,0)
	SetMemblockInt(MemblockID,IndexOffset+1*4,1)
	SetMemblockInt(MemblockID,IndexOffset+2*4,2)
	SetMemblockInt(MemblockID,IndexOffset+3*4,2)
	SetMemblockInt(MemblockID,IndexOffset+4*4,3)
	SetMemblockInt(MemblockID,IndexOffset+5*4,0)
endfunction MemblockID

// Generate the mesh header for a simple one sided plane
// Position,Normal,UV,Color,Tangent and Bitangent Data
function Voxel_CreateMeshMemblock()
	VertexCount=4
	IndexCount=6
	Attributes=6
	VertexSize=60
	VertexOffset=100
	IndexOffset=340

	MemblockID=Creatememblock(VertexOffset+(VertexCount*VertexSize)+(IndexCount*4))
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

    for Offset=VertexOffset to VertexOffset+(VertexCount*VertexSize) step 4
        SetMemblockFloat(MemblockID,Offset, 0.0)
    next Offset
endfunction MemblockID

// just print the mesh header
function Vocel_PrintMeshMemblock(MemblockID)
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