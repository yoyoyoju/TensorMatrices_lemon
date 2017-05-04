import Base: size, getindex, setindex!, similar, ndims
#' in the future: Base.show(io::IO, tenmat::Tenmat) = print(io, "...")

abstract AbstractTenmat{T} # <: AbstractArray
##### functions to be implemented to make it sub of AbstractArray
# AbstractArray{T,N} where T is the type of object returned by integer indexing (A[1,...,1], when A is not empty)
# 	and N should be the length of the tuple returned by size()

"""
	Tenmat{T}(matrix::Array{T,2}, rowindex::Vector{Int}, colindex::Vector{Int}, tensorsize::Tuple{Vararg{Int}})


Matrix which stores the indices to convert it back to tensor.

## Example

```jldoctest
matrix = Array(reshape(1:48, 6, 8)) # some 6 x 8 matrix
rowindex = [3,1]
colindex = [2,4]
tensorsize = (2,4,3,2)
tenmat = Tenmat(matrix, rowindex, colindex, tensorsize)

# output

TensorMatrices_lemon.Tenmat{Int64}([1 7 … 37 43; 2 8 … 38 44; … ; 5 11 … 41 47; 6 12 … 42 48],[3,1],[2,4],(2,4,3,2))
```
"""
type Tenmat{T} <: AbstractTenmat{T}
	# e.g. Tenmat(A,[1,2],[3,4],(4,3,2,4)), where A is 12x8 matrix
	"converted matrix from tensor"
	matrix::Array{T,2}
	"Tensor indices to map to row"
	rowindex::Vector{Int} 
	"Tensor indices to map to coloumn"
	colindex::Vector{Int} 
	tensorsize::Tuple{Vararg{Int}} # tensor size

	function Tenmat{T}(matrix::Array{T,2}, rowindex::Vector{Int}, colindex::Vector{Int}, tensorsize::Tuple{Vararg{Int}})
		# the condition for the arguments:
		# the dimension of the mat matches to the tensize
		# -> the product of tensize[rowindex] == mat's row dimension
		# -> also for the column
		(length(rowindex) + length(colindex) == length(tensorsize)) &&
		(productWithIndex(tensorsize, rowindex) == size(matrix, 1)) &&
		(productWithIndex(tensorsize, colindex) == size(matrix, 2)) ?
 		new(matrix, rowindex, colindex, tensorsize)   :
		error("dimension does not match")
	end
end

Tenmat{T}(matrix::Matrix{T}, rowindex::Vector{Int}, colindex::Vector{Int}, tensorsize::Tuple{Vararg{Int}})  = Tenmat{T}(matrix, rowindex, colindex, tensorsize)

"""
	Tenmat{T}(matrix::Matrix{T})

Set a matrix as a Tenmat. 
"""
Tenmat{T}(matrix::Matrix{T}) = Tenmat{T}(matrix, [1], [2], size(matrix))

"""
	Tenmat{T,N}(tensor::Array{T,N}, rowindex::Vector{Int}, colindex::Vector{Int})

Set a tensor as a Tenmat.  

`Tenmat.matrix` will return the converted matrix.  

## Example

```jldoctest basicMethods
A = Array(reshape(1:3024, 4,7,2,9,6)) # tensor, size of [4,7,2,9,6]
rowindex = [5,2] # 5th and 2nd indices maps to the row
colindex = [3,4,1] # 3rd, 4th and 1st indices maps to the column
tenmat = Tenmat(A,rowindex,colindex)

# output

TensorMatrices_lemon.Tenmat{Int64}([1 29 … 452 480; 505 533 … 956 984; … ; 2041 2069 … 2492 2520; 2545 2573 … 2996 3024],[5,2],[3,4,1],(4,7,2,9,6))
```
"""
Tenmat{T,N}(tensor::Array{T,N}, rowindex::Vector{Int}, colindex::Vector{Int}) = tensor2tenmat(tensor, rowindex, colindex)

##### define functions with macro
# tenmat_with_other_args_non_preserving = [:size, :getindex, : setindex!

"""
	size(tenmat::Tenmat, args...)

Return the size of the tenmat.matrix.  

```jldoctest basicMethods
julia> size(tenmat)
(42,72)

julia> size(tenmat,2)
72
```
"""
size(tenmat::Tenmat, args...) = size(tenmat.matrix, args...)

"""
	setindex!(tenmat::Tenmat, args...)

Expands `setindex!` by tenmat.matrix.  

```jldoctest basicMethods
julia> setindex!(tenmat, 100, 2, 6);
```
"""
setindex!(tenmat::Tenmat, args...) = setindex!(tenmat.matrix, args...)

"""
	getindex(tenmat::Tenmat, args...)

Expands `getindex` by tenmat.matrix.  

```jldoctest basicMethods
julia> getindex(tenmat, 2, 6)
100
```
"""
getindex(tenmat::Tenmat, args...) = getindex(tenmat.matrix, args...)

"""
	similar

similar

## Examples

```jldoctest
A = rand(4,7,6)
tenmat = Tenmat(A,[3,1],[2])
similar(tenmat, Int)
similar(tenmat, Int, (5,2,7))
similar(tenmat, Int, [1,3],[2])
similar(tenmat, Int, [4,2,5], [1,3], (2,4,3,1,6))
similar(tenmat)
similar(tenmat, (5,2,7))
similar(tenmat, [1,3],[2])
B = similar(tenmat, [4,2,5], [1,3], (2,4,3,1,6))
size(B)

# output

(24,6)

```
"""
similar{T}(tenmat::Tenmat{T}) = Tenmat{T}(similar(tenmat.matrix), tenmat.rowindex, tenmat.colindex, tenmat.tensorsize)
similar{T}(tenmat::Tenmat{T}, S::Type) = 
	similar(tenmat, S, tensorSize(tenmat))
similar{N}(tenmat::Tenmat, T::Type, tensorsize::Tuple{Vararg{Int64,N}}) = 
	similar(tenmat, T, tenmat.rowindex, tenmat.colindex, tensorsize)
similar{T}(tenmat::Tenmat{T}, S::Type, rowindex::Vector{Int}, colindex::Vector{Int}) =
	similar(tenmat, S, rowindex, colindex, tensorSize(tenmat))
similar{T}(tenmat::Tenmat{T}, S::Type, rowindex::Vector{Int}, colindex::Vector{Int}, tensorsize::Tuple{Vararg{Int}}) = 
	Tenmat(similar(tenmat2tensor(tenmat), T, tensorsize), rowindex, colindex)

similar{N}(tenmat::Tenmat, tensorsize::Tuple{Vararg{Int64,N}}) = 
	similar(tenmat, tenmat.rowindex, tenmat.colindex, tensorsize)
similar{T}(tenmat::Tenmat{T}, rowindex::Vector{Int}, colindex::Vector{Int}) = similar(tenmat, rowindex, colindex, tensorSize(tenmat))
similar{T}(tenmat::Tenmat{T}, rowindex::Vector{Int}, colindex::Vector{Int}, tensorsize::Tuple{Vararg{Int}}) =
	Tenmat(similar(tenmat2tensor(tenmat), tensorsize), rowindex, colindex)


"""
	ndims(tenmat::Tenmat)

Return the original dimension of tenmat,
from `tensorsize`.  

```jldoctest tenmat2
A = Array(reshape(1:3024, 4,7,2,9,6)) 
tenmat = Tenmat(A,[5,2],[3,4,1])
ndims(tenmat)

# output

5
```
"""
ndims(tenmat::Tenmat) = length(tensorSize(tenmat))

"""
	tensorSize(tenmat::Tenmat)

Return the tensorsize.  

```jldoctest tenmat2
julia> tensorSize(tenmat)
(4,7,2,9,6)
```
"""
function tensorSize(tenmat::Tenmat)
	return tenmat.tensorsize
end

"""
	getMatrix(tenmat::Tenmat)

Return the matrix.  

```jldoctest
A = Array(reshape(1:18, 3, 2, 3))
tenmat = Tenmat(A,[3,1],[2])
getMatrix(tenmat)

# output

9×2 Array{Int64,2}:
  1   4
  7  10
 13  16
  2   5
  8  11
 14  17
  3   6
  9  12
 15  18
```
"""
function getMatrix{T}(tenmat::Tenmat{T})
	return tenmat.matrix
end

"""
	productWithIndex{T}(tuple::Tuple{Vararg{T}}, index = collect(1:length(tuple))::Vector{Int})

Get a product of tuple elements with index number in index vector
"""
function productWithIndex{T}(tuple::Tuple{Vararg{T}}, index = collect(1:length(tuple))::Vector{Int})
	prod = 1
	for i in index
		prod *= tuple[i]
	end
	return prod
end

"""
	tensor2tenmat{T,N}(tensor::Array{T,N}, rowindex::Vector{Int}, colindex::Vector{Int})

Convert tensor to tenmat.  

**TO DO**
ADD EXAMPLE
"""
function tensor2tenmat{T,N}(tensor::Array{T,N}, rowindex::Vector{Int}, colindex::Vector{Int})
	#=
		A = rand(3,5,3,2,6);
		tenmatA = tensor2tenmat(A,[3,5,2],[4,1])
		=> tenmatA.matrix => 90x6 matrix
		=> tenmatA.tensorsize => (3,5,3,2,6)

		B = reshape(1:10,2,5)
		tenmatB = tensor2tenmat(B,[2],[1])
		tenmatB.matrix == transpose(B)
		tenmatB.tensorsize == (2,5)

		C = reshape(1:30,3,2,5)
		tenmatC = tensor2tenmat(C,[3],[2,1])
		tenmatC.tensorsize == (3,2,5)
		size(tenmatC.matrix) == (5,6)

		a = 5; b = 7; c = 8
		D = reshape(1:a*b*c,a,b,c)
		tenmatD = tensor2tenmat(D,[3],[1,2])
		tenmatD.tensorsize == (a,b,c)
		size(tenmatD.matrix) == (c,a*b)
		for i = 1:a, j = 1:b, k = 1:c
			println(D[i,j,k] == tenmatD.matrix[k,(j-1)*a+i])
		end

		a = 5; b = 7; c = 8; d = 11
		D = reshape(1:a*b*c*d,a,b,c,d)
		tenmatD = tensor2tenmat(D,[3],[1,4,2])
		tenmatD.tensorsize == (a,b,c,d)
		size(tenmatD.matrix) == (c,a*d*b)
		for i = 1:a, j = 1:b, k = 1:c, l = 1:d
			println(D[i,j,k,l] == tenmatD.matrix[k,(j-1)*a*d+(l-1)*a+i])
		end
	=#
	tensorsize = size(tensor)
	(N == length(rowindex) + length(colindex)) || error("index does not match")

	permten = permutedims(tensor,vcat(rowindex,colindex))
	rowdim = productWithIndex(size(tensor),rowindex)
	coldim = productWithIndex(size(tensor),colindex)

	matrix = reshape(permten,rowdim,coldim)
	tenmat = Tenmat(matrix,rowindex,colindex,tensorsize)

	return tenmat
end

"""
	tenmat2tensor{T}(tenmat::Tenmat{T})

Convert tenmat back to the tensor.  

##TO DO**
ADD EXAMPLE
"""
function tenmat2tensor{T}(tenmat::Tenmat{T})
	#=
		A = rand(3,5,3,2,8);
		tenmatA = tensor2tenmat(A,[3,5,2],[4,1])
		againA = tenmat2tensor(tenmatA)
		A == againA

		B = rand(8,6,7,5,8,5,3,8);
		tenmatB = tensor2tenmat(B,[1,7,3,2,6],[5,8,4]);
		againB = tenmat2tensor(tenmatB);
		for a=1:8, b=1:6, c=1:7, d=1:5, e=1:8, f=1:5, g=1:3, h=1:8
			againB[a,b,c,d,e,f,g,h] == B[a,b,c,d,e,f,g,h] ? println("right") : println("wrong")
		end
	=#
	indices = vcat(tenmat.rowindex, tenmat.colindex)
	tensor = reshape(tenmat.matrix, [tenmat.tensorsize[i] for i in indices]...)
	tensor = ipermutedims(tensor, indices)
	return tensor
end
