type cJPrimType = CJInt 
								| CJFloat 
								| CJBool 
								| CJString
								| CJVoid;; 

type cJType = CJPrimType of cJPrimType
						| CJClassType of string;;

let toStringCJPrimType (t:cJPrimType) = 
	match t with
	| CJInt -> "int"
	| CJFloat -> "float"
	| CJBool -> "bool"
	| CJString -> "string"
	| CJVoid -> "void";;

let toStringCJType (t:cJType) =
	match t with
	| CJPrimType(s) -> toStringCJPrimType(s)
	| CJClassType(s) -> s;;

