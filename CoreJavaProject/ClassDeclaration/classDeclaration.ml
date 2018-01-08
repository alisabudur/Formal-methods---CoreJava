open FieldDeclaration;;
open MethodDeclaration;;

type cJClass = CJClass of string*string*cJFieldList*cJMethodList;;

let toStringCJClass (c: cJClass) = 
	match c with 
	| CJClass(name, parentName, fieldList, methodList) -> 
		String.concat "" ["class "; name; " extends "; parentName; "{\n\n"; toStringCJFieldList(fieldList); "#\n\n"; toStringCJMethodList(methodList); "}" ];;

let classWellTyped(c: cJClass) = 
	match c with 
	| CJClass(name, parentName, fieldList, methodList) -> fieldListNotDuplicated(fieldList) && methodListNotDuplicated(methodList);;

let getClassName(c: cJClass) = 
	match c with
	| CJClass(name, _, _, _) -> name;;
		
let hasMainMethod(c: cJClass) =
	match c with
	| CJClass(_, _, _, methodList)	-> 	existMainMethod(methodList);;

let getInheritancePair(c: cJClass): (string*string) = 
	match c with 
	| CJClass(child, parent, _, _) -> (child, parent);;