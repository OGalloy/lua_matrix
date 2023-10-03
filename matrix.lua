--matrix
Matrix = {}
math.randomseed( os.clock() )
function Matrix:create(rows, columns, value)
	local matrix = {}
	for row = 1, rows do
		matrix[row] = {}
		for column = 1, columns do
			local val = value
			if type(value) == "number" then
				matrix[row][column] = val
			end
			if type(value) == "function" then
				matrix[row][column] = val()
			end
		end
	end
	setmetatable(matrix, {__index = Matrix})
	return matrix
end

function Matrix:getSize()
	return #self, #self[#self]
end

function Matrix:display()
	local rows, columns = self:getSize() 
	for row = 1, rows do
		for column = 1, columns do
			io.write(self[row][column], " ")
		end
		io.write("\n")
	end
end

function Matrix:add(matrix)
	local rows1, columns1 = self:getSize()
	local rows2, columns2 = matrix:getSize()
	local result
	if rows1 == rows2 and columns1 == columns2 then
		result = Matrix:create(rows1, columns1, 0)
		for row = 1, #self do
			for column = 1, #self[row] do
				result[row][column] = self[row][column] + matrix[row][column]
			end
		end
		return result
	end
end

--test block
time1 = os.clock()
math.randomseed(os.clock())
mat1 = Matrix:create(1000, 1000, 1)
mat2 = Matrix:create(1000, 1000, 3)
print("mat1 size:", mat1:getSize())
print("mat2 size:", mat2:getSize())
--mat1:display()
print()
--mat2:display()
mat3 = mat1:add(mat2)
print()
--mat3:display()
time2 = os.clock()
print(time2 - time1)