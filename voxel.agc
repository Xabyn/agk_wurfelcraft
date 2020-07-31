// Data Types able to represent any AGK mesh
type Vec4Data
	X#
	Y#
	Z#
	W#
endtype

type Vec3Data
	X#
	Y#
	Z#
endtype

type Vec2Data
	X#
	Y#
endtype

type RGBAData
	Red#
	Green#
	Blue#
	Alpha#
endtype

type BoneData
	Weights as Vec4Data
	Idices as Vec4Data
endtype

type VertexData
	MaterialID as integer
	Pos as Vec3Data
	UV as Vec2Data
	Color as RGBAData
	Normal as Vec3Data
	Bone as BoneData
	Tangent as Vec3Data
	Bitangent as Vec3Data
endtype

type ObjectData
	Vertex as VertexData[]
	Index as integer[]
endtype

// Functions

// Initialise the Voxel Engine
function Voxel_InitWorld()
	MemblockID=Voxel_CreateMeshMemblock()
endfunction MemblockID

function Voxel_CreateMeshMemblock()
	VertexCount=4
	IndexCount=6
	Attributes=6
	VertexOffset=100
	VertexSize=64
	IndexOffset=432

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