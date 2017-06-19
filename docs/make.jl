using Documenter, TensorMatrices_lemon

makedocs()
# makedocs(modules=[TensorMatrices_lemon],
# 		 doctest=true)
# 
 deploydocs(
			deps = Deps.pip("mkdocs", "python-markdown-math"),
 		  repo = "github.com/yoyoyoju/TensorMatrices_lemon.jl.git",
 		  julia = "0.5",
 		  osname = "osx"
		  )
