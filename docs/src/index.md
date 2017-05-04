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
	getindex
	setindex! 
	similar
	getMatrix
	tensorSize
	productWithindex
	tensor2tenmat
	tenmat2tensor

```@docs
size(tenmat::Tenmat, args...)
```

```@meta
DocTestSetup = nothing
```

## index

```@index
```
