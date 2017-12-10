open FieldDeclaration;;
open MethodDeclaration;;

type cJClass = CJClass of string*string*cJFieldList*cJMethodList;;

let toStringCJClass (c: cJClass) = 
	match c with 
	| CJClass(name, parentName, fieldList, methodList) -> 
		String.concat "" ["class "; name; " extends "; parentName; "{\n\n"; toStringCJFieldList(fieldList); "#\n\n"; toStringCJMethodList(methodList); "}" ]