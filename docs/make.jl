using Documenter, TensorMatrices_lemon

makedocs()
# makedocs(modules=[TensorMatrices_lemon],
# 		 doctest=true)
# 
 deploydoc(deps	=Deps.pip("mkdocs", "python-markdown-math"),
 		  repo = "github.com/yoyoyoju/TensorMatrices_lemon.git",
 		  julia = "0.5",
 		  osname = "osx")
