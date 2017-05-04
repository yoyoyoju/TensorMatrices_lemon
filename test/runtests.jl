using TensorMatrices_lemon
using Base.Test

# creating a tenmat
		"""    
			matrix = rand(6,8)
			rowindex = [3,1]
			colindex = [2,4]
			tensorsize = (2,4,3,2)
			tenmat = Tenmat(matrix, rowindex, colindex, tensorsize)
		"""
		""" [test]
			tensorSize(tenmat)  == (2,4,3,2)
	
"""

# initialization 
"""
	A = rand(4,7,2,9,6)
	rowindex = [5,2]
	colindex = [3,4,1]
	tenmat = Tenmat(A,rowindex,colindex)

	A = rand(4,7,6);
	tenmat = Tenmat(A,[3,1],[2])
	size(tenmat) == (24,7) || println("wrong")
	size(tenmat,2) == 7 || println("wrong")
	getindex(tenmat, 2, 6) == getindex(tenmat.matrix, 2, 6) || println("wrong")
	setindex!(tenmat, 100.0 , 2, 6)
	getindex(tenmat, 2, 6) == 100.0 || println("wrong")
	similar(tenmat, Int)
	similar(tenmat, Int, (5,2,7))
	similar(tenmat, Int, [1,3],[2])
	similar(tenmat, Int, [4,2,5], [1,3], (2,4,3,1,6))
	similar(tenmat)
	similar(tenmat, (5,2,7))
	similar(tenmat, [1,3],[2])
	similar(tenmat, [4,2,5], [1,3], (2,4,3,1,6))
	
	
"""
@test 1 == 2
