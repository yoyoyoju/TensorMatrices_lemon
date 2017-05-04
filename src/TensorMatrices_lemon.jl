"""
convert tensor to matrix or matrix to tensor
storing the index info
"""
module TensorMatrices_lemon

	export AbstractTenmat, Tenmat, tensorSize, size, getindex, setindex!, similar, ndims, tensor2tenmat, tenmat2tensor, getMatrix

	include("tenmat.jl")

end
