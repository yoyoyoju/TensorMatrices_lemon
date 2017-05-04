# TensorMatrices_lemon Module

```@docs
TensorMatrices_lemon
```

```@contents
```

## Types

```@meta
DocTestSetup = quote
	using TensorMatrices_lemon
end
```

```@docs
Tenmat
Tenmat(matrix::Matrix)
Tenmat{T,N}(tensor::Array{T,N}, rowindex::Vector{Int}, colindex::Vector{Int})
```

## Methods

what to write:
	size - DONE
	getindex - DONE
	setindex! - DONE
	similar - DONE
	ndims - DONE
	getMatrix - DONE
	tensorSize - DONE
	----
	DO THE EXAMPLES!!!
	tensor2tenmat - DONE
	tenmat2tensor - DONE

```@docs
size(tenmat::Tenmat, args...)
setindex!(tenmat::Tenmat, args...)
getindex(tenmat::Tenmat, args...)
similar(tenmat::Tenmat)
ndims(tenmat::Tenmat)
tensorSize(tenmat::Tenmat)
getMatrix(tenmat::Tenmat)
tensor2tenmat{T,N}(tensor::Array{T,N}, rowindex::Vector{Int}, colindex::Vector{Int})
tenmat2tensor{T}(tenmat::Tenmat{T})
```

```@meta
DocTestSetup = nothing
```

## index

```@index
```
