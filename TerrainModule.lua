--big tank u for using module

local terrain_module = {}

function terrain_module.creatematrix(X,Z)
	local matrix = {}
	
	for x = 1,X do
		matrix[x] = {}
		for z = 1,Z do
			matrix[x][z] = 0
		end
	end
	
	return matrix
end

function terrain_module.populatematrix(matrix, seed, noiseMultiplier)
	
	for x = 1,#matrix do
		for z = 1,#matrix[x] do
			matrix[x][z] = math.noise(x/10, z/10, seed) * noiseMultiplier
		end
	end
	
	return matrix
end

function terrain_module.createtiles(matrix,tileSizeX,tileSizeY,tileSizeZ)
	local f = Instance.new("Folder",workspace)
	f.Name = "tiles"
	
	for x = 1,#matrix do
		for z = 1,#matrix[x] do
			local tile = Instance.new("Part", f)
			tile.Size = Vector3.new(tileSizeX,tileSizeY,tileSizeZ)
			tile.Position = Vector3.new(x*tileSizeX,matrix[x][z],z*tileSizeZ)
			tile.Anchored = true
		end
	end

	return f
end

function terrain_module.heightcolor(tilesFolder,minColorHeight,maxColorHeight,material,brickColor)
	for i,v in ipairs(tilesFolder:GetChildren()) do
		if v:isA("Part") then
			if v.Position.Y > minColorHeight and v.Position.Y < maxColorHeight then
				v.BrickColor = brickColor
				v.Material = material
			end
		end
	end
end

return terrain_module