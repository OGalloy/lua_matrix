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

--Very Slow Method
function Matrix:mul(matrix)
	local first_matrix_rows, first_matrix_columns = self:getSize()
	local second_matrix_rows, second_matrix_columns = matrix:getSize()

	if first_matrix_columns ~= second_matrix_rows then
		error("size columns first matrix not equal size rows second matrix")
	end
	local result = Matrix:create(first_matrix_rows, second_matrix_columns, 0)
	for column = 1, second_matrix_columns do
		for row = 1, first_matrix_rows do
			for i = 1, first_matrix_columns do
			result[row][column] = result[row][column] + self[row][i] * matrix[i][column]
		end
		end
	end
	return result		  
end

return Matrix