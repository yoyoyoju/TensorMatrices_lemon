
<a id='TensorMatrices_lemon-Module-1'></a>

# TensorMatrices_lemon Module

<a id='TensorMatrices_lemon' href='#TensorMatrices_lemon'>#</a>
**`TensorMatrices_lemon`** &mdash; *Module*.



convert tensor to matrix or matrix to tensor storing the index info


<a target='_blank' href='https://github.com/yoyoyoju/TensorMatrices_lemon/tree/f9f5e0215bdb297612afa46ebb18fc28f8e057dc/src/TensorMatrices_lemon.jl#L1-L4' class='documenter-source'>source</a><br>

- [TensorMatrices_lemon Module](index.md#TensorMatrices_lemon-Module-1)
    - [Types](index.md#Types-1)
    - [Methods](index.md#Methods-1)
    - [index](index.md#index-1)


<a id='Types-1'></a>

## Types



<a id='TensorMatrices_lemon.Tenmat' href='#TensorMatrices_lemon.Tenmat'>#</a>
**`TensorMatrices_lemon.Tenmat`** &mdash; *Type*.



```
Tenmat{T}(matrix::Array{T,2}, rowindex::Vector{Int}, colindex::Vector{Int}, tensorsize::Tuple{Vararg{Int}})
```

Matrix which stores the indices to convert it back to tensor.

**Example**

```julia
matrix = Array(reshape(1:48, 6, 8)) # some 6 x 8 matrix
rowindex = [3,1]
colindex = [2,4]
tensorsize = (2,4,3,2)
tenmat = Tenmat(matrix, rowindex, colindex, tensorsize)

# output

TensorMatrices_lemon.Tenmat{Int64}([1 7 … 37 43; 2 8 … 38 44; … ; 5 11 … 41 47; 6 12 … 42 48],[3,1],[2,4],(2,4,3,2))
```


<a target='_blank' href='https://github.com/yoyoyoju/TensorMatrices_lemon/tree/f9f5e0215bdb297612afa46ebb18fc28f8e057dc/src/tenmat.jl#L9-L28' class='documenter-source'>source</a><br>

<a id='TensorMatrices_lemon.Tenmat-Tuple{Array{T,2}}' href='#TensorMatrices_lemon.Tenmat-Tuple{Array{T,2}}'>#</a>
**`TensorMatrices_lemon.Tenmat`** &mdash; *Method*.



```
Tenmat{T}(matrix::Matrix{T})
```

Set a matrix as a Tenmat. 


<a target='_blank' href='https://github.com/yoyoyoju/TensorMatrices_lemon/tree/f9f5e0215bdb297612afa46ebb18fc28f8e057dc/src/tenmat.jl#L54-L58' class='documenter-source'>source</a><br>

<a id='TensorMatrices_lemon.Tenmat-Tuple{Array{T,N},Array{Int64,1},Array{Int64,1}}' href='#TensorMatrices_lemon.Tenmat-Tuple{Array{T,N},Array{Int64,1},Array{Int64,1}}'>#</a>
**`TensorMatrices_lemon.Tenmat`** &mdash; *Method*.



```
Tenmat{T,N}(tensor::Array{T,N}, rowindex::Vector{Int}, colindex::Vector{Int})
```

Set a tensor as a Tenmat.  

`Tenmat.matrix` will return the converted matrix.  

**Example**

```julia
A = Array(reshape(1:3024, 4,7,2,9,6)) # tensor, size of [4,7,2,9,6]
rowindex = [5,2] # 5th and 2nd indices maps to the row
colindex = [3,4,1] # 3rd, 4th and 1st indices maps to the column
tenmat = Tenmat(A,rowindex,colindex)

# output

TensorMatrices_lemon.Tenmat{Int64}([1 29 … 452 480; 505 533 … 956 984; … ; 2041 2069 … 2492 2520; 2545 2573 … 2996 3024],[5,2],[3,4,1],(4,7,2,9,6))
```


<a target='_blank' href='https://github.com/yoyoyoju/TensorMatrices_lemon/tree/f9f5e0215bdb297612afa46ebb18fc28f8e057dc/src/tenmat.jl#L61-L80' class='documenter-source'>source</a><br>


<a id='Methods-1'></a>

## Methods


what to write: 	size - DONE 	getindex - DONE 	setindex! - DONE 	similar - DONE 	ndims - DONE 	getMatrix - DONE 	tensorSize - DONE 	–– 	DO THE EXAMPLES!!! 	tensor2tenmat - DONE 	tenmat2tensor - DONE

<a id='Base.size-Tuple{TensorMatrices_lemon.Tenmat,Vararg{Any,N}}' href='#Base.size-Tuple{TensorMatrices_lemon.Tenmat,Vararg{Any,N}}'>#</a>
**`Base.size`** &mdash; *Method*.



```
size(tenmat::Tenmat, args...)
```

Return the size of the tenmat.matrix.  

```jlcon
julia> size(tenmat)
(42,72)

julia> size(tenmat,2)
72
```


<a target='_blank' href='https://github.com/yoyoyoju/TensorMatrices_lemon/tree/f9f5e0215bdb297612afa46ebb18fc28f8e057dc/src/tenmat.jl#L86-L98' class='documenter-source'>source</a><br>

<a id='Base.setindex!-Tuple{TensorMatrices_lemon.Tenmat,Vararg{Any,N}}' href='#Base.setindex!-Tuple{TensorMatrices_lemon.Tenmat,Vararg{Any,N}}'>#</a>
**`Base.setindex!`** &mdash; *Method*.



```
setindex!(tenmat::Tenmat, args...)
```

Expands `setindex!` by tenmat.matrix.  

```jlcon
julia> setindex!(tenmat, 100, 2, 6);
```


<a target='_blank' href='https://github.com/yoyoyoju/TensorMatrices_lemon/tree/f9f5e0215bdb297612afa46ebb18fc28f8e057dc/src/tenmat.jl#L101-L109' class='documenter-source'>source</a><br>

<a id='Base.getindex-Tuple{TensorMatrices_lemon.Tenmat,Vararg{Any,N}}' href='#Base.getindex-Tuple{TensorMatrices_lemon.Tenmat,Vararg{Any,N}}'>#</a>
**`Base.getindex`** &mdash; *Method*.



```
getindex(tenmat::Tenmat, args...)
```

Expands `getindex` by tenmat.matrix.  

```jlcon
julia> getindex(tenmat, 2, 6)
100
```


<a target='_blank' href='https://github.com/yoyoyoju/TensorMatrices_lemon/tree/f9f5e0215bdb297612afa46ebb18fc28f8e057dc/src/tenmat.jl#L112-L121' class='documenter-source'>source</a><br>

<a id='Base.similar-Tuple{TensorMatrices_lemon.Tenmat}' href='#Base.similar-Tuple{TensorMatrices_lemon.Tenmat}'>#</a>
**`Base.similar`** &mdash; *Method*.



```
similar
```

similar

**Examples**

```julia
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


<a target='_blank' href='https://github.com/yoyoyoju/TensorMatrices_lemon/tree/f9f5e0215bdb297612afa46ebb18fc28f8e057dc/src/tenmat.jl#L124-L149' class='documenter-source'>source</a><br>

<a id='Base.ndims-Tuple{TensorMatrices_lemon.Tenmat}' href='#Base.ndims-Tuple{TensorMatrices_lemon.Tenmat}'>#</a>
**`Base.ndims`** &mdash; *Method*.



```
ndims(tenmat::Tenmat)
```

Return the original dimension of tenmat, from `tensorsize`.  

```julia
A = Array(reshape(1:3024, 4,7,2,9,6)) 
tenmat = Tenmat(A,[5,2],[3,4,1])
ndims(tenmat)

# output

5
```


<a target='_blank' href='https://github.com/yoyoyoju/TensorMatrices_lemon/tree/f9f5e0215bdb297612afa46ebb18fc28f8e057dc/src/tenmat.jl#L167-L182' class='documenter-source'>source</a><br>

<a id='TensorMatrices_lemon.tensorSize-Tuple{TensorMatrices_lemon.Tenmat}' href='#TensorMatrices_lemon.tensorSize-Tuple{TensorMatrices_lemon.Tenmat}'>#</a>
**`TensorMatrices_lemon.tensorSize`** &mdash; *Method*.



```
tensorSize(tenmat::Tenmat)
```

Return the tensorsize.  

```jlcon
julia> tensorSize(tenmat)
(4,7,2,9,6)
```


<a target='_blank' href='https://github.com/yoyoyoju/TensorMatrices_lemon/tree/f9f5e0215bdb297612afa46ebb18fc28f8e057dc/src/tenmat.jl#L185-L194' class='documenter-source'>source</a><br>

<a id='TensorMatrices_lemon.getMatrix-Tuple{TensorMatrices_lemon.Tenmat}' href='#TensorMatrices_lemon.getMatrix-Tuple{TensorMatrices_lemon.Tenmat}'>#</a>
**`TensorMatrices_lemon.getMatrix`** &mdash; *Method*.



```
getMatrix(tenmat::Tenmat)
```

Return the matrix.  

```julia
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


<a target='_blank' href='https://github.com/yoyoyoju/TensorMatrices_lemon/tree/f9f5e0215bdb297612afa46ebb18fc28f8e057dc/src/tenmat.jl#L199-L222' class='documenter-source'>source</a><br>

<a id='TensorMatrices_lemon.tensor2tenmat-Tuple{Array{T,N},Array{Int64,1},Array{Int64,1}}' href='#TensorMatrices_lemon.tensor2tenmat-Tuple{Array{T,N},Array{Int64,1},Array{Int64,1}}'>#</a>
**`TensorMatrices_lemon.tensor2tenmat`** &mdash; *Method*.



```
tensor2tenmat{T,N}(tensor::Array{T,N}, rowindex::Vector{Int}, colindex::Vector{Int})
```

Convert tensor to tenmat.  

**examples**

```jlcon
julia> A = rand(3,5,3,2,6);

julia> tenmatA = tensor2tenmat(A,[3,5,2],[4,1]);

julia> size(getMatrix(tenmatA))
(90,6)

julia> tensorSize(tenmatA)
(3,5,3,2,6)


julia> B = Array(reshape(1:10,2,5));

julia> tenmatB = tensor2tenmat(B,[2],[1]);

julia> tenmatB.matrix == transpose(B)
true

julia> tensorSize(tenmatB)
(2,5)

```


<a target='_blank' href='https://github.com/yoyoyoju/TensorMatrices_lemon/tree/f9f5e0215bdb297612afa46ebb18fc28f8e057dc/src/tenmat.jl#L240-L270' class='documenter-source'>source</a><br>

<a id='TensorMatrices_lemon.tenmat2tensor-Tuple{TensorMatrices_lemon.Tenmat{T}}' href='#TensorMatrices_lemon.tenmat2tensor-Tuple{TensorMatrices_lemon.Tenmat{T}}'>#</a>
**`TensorMatrices_lemon.tenmat2tensor`** &mdash; *Method*.



```
tenmat2tensor{T}(tenmat::Tenmat{T})
```

Convert tenmat back to the tensor.  

**examples**

```jlcon
julia> A = rand(3,5,3,2,8);

julia> tenmatA = tensor2tenmat(A,[3,5,2],[4,1]);

julia> back2A = tenmat2tensor(tenmatA);

julia> A == back2A
true
```

```julia
B = rand(8,6,7,5,8,5,3,8)
tenmatB = tensor2tenmat(B,[1,7,3,2,6],[5,8,4])
back2B = tenmat2tensor(tenmatB)
check = true
for a=1:8, b=1:6, c=1:7, d=1:5, e=1:8, f=1:5, g=1:3, h=1:8
	back2B[a,b,c,d,e,f,g,h] == B[a,b,c,d,e,f,g,h] || check * false
end
check

# output

true
```


<a target='_blank' href='https://github.com/yoyoyoju/TensorMatrices_lemon/tree/f9f5e0215bdb297612afa46ebb18fc28f8e057dc/src/tenmat.jl#L305-L336' class='documenter-source'>source</a><br>




<a id='index-1'></a>

## index

- [`TensorMatrices_lemon`](index.md#TensorMatrices_lemon)
- [`TensorMatrices_lemon.Tenmat`](index.md#TensorMatrices_lemon.Tenmat-Tuple{Array{T,N},Array{Int64,1},Array{Int64,1}})
- [`TensorMatrices_lemon.Tenmat`](index.md#TensorMatrices_lemon.Tenmat)
- [`TensorMatrices_lemon.Tenmat`](index.md#TensorMatrices_lemon.Tenmat-Tuple{Array{T,2}})
- [`Base.getindex`](index.md#Base.getindex-Tuple{TensorMatrices_lemon.Tenmat,Vararg{Any,N}})
- [`Base.ndims`](index.md#Base.ndims-Tuple{TensorMatrices_lemon.Tenmat})
- [`Base.setindex!`](index.md#Base.setindex!-Tuple{TensorMatrices_lemon.Tenmat,Vararg{Any,N}})
- [`Base.similar`](index.md#Base.similar-Tuple{TensorMatrices_lemon.Tenmat})
- [`Base.size`](index.md#Base.size-Tuple{TensorMatrices_lemon.Tenmat,Vararg{Any,N}})
- [`TensorMatrices_lemon.getMatrix`](index.md#TensorMatrices_lemon.getMatrix-Tuple{TensorMatrices_lemon.Tenmat})
- [`TensorMatrices_lemon.tenmat2tensor`](index.md#TensorMatrices_lemon.tenmat2tensor-Tuple{TensorMatrices_lemon.Tenmat{T}})
- [`TensorMatrices_lemon.tensor2tenmat`](index.md#TensorMatrices_lemon.tensor2tenmat-Tuple{Array{T,N},Array{Int64,1},Array{Int64,1}})
- [`TensorMatrices_lemon.tensorSize`](index.md#TensorMatrices_lemon.tensorSize-Tuple{TensorMatrices_lemon.Tenmat})

