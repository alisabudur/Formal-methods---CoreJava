open ExpDeclaration;;
open ClassDeclaration;;
open MethodDeclaration;;
open TypeDeclaration;;
open ProgramDeclaration;;
open SubtypingUtils;;
open FieldDeclaration;;

let rec getVarType (varName: string) (te: (string*string) list) = 
	match te with
	| [] -> raise (Failure "Not Found")
	| h::t -> if first(h) = varName then (last(h)) else (getVarType varName t);;

let rec getTypeOfConstExp (e: constExp) = 
	match e with 
	| ConstInt(_) -> toStringCJType(CJPrimType(CJInt))
	| ConstFloat(_) -> toStringCJType(CJPrimType(CJFloat))
	| ConstBool(_) -> toStringCJType(CJPrimType(CJBool))
	| ConstString(_) -> toStringCJType(CJPrimType(CJString))
	| ConstVoid -> "void"
	| Null -> "null";;

let getTypeOfExp(e: exp) (te: (string*string) list) (p: cJProgram) = 
	match e with 
	| ArithIntExp(_, _, _) -> toStringCJType(CJPrimType(CJInt))
	| ArithFloatExp(_, _, _) -> toStringCJType(CJPrimType(CJFloat))
	| ConstExp(e) -> getTypeOfConstExp(e)
	| VariableExp(name) -> getVarType name te
	| FieldValueExp(varName, fieldName) -> toStringCJType(getFieldType (getFieldWithName varName (getFieldList (getClassWithName (getVarType varName te) p))))
	| NotExp(_) -> toStringCJType(CJPrimType(CJBool))
	| GreaterExp(_, _) -> toStringCJType(CJPrimType(CJBool))
	| LessExp(_, _) -> toStringCJType(CJPrimType(CJBool))
	| EqualExp(_, _) -> toStringCJType(CJPrimType(CJBool))
	| NotEqualExp(_, _) -> toStringCJType(CJPrimType(CJBool))
	| AndExp(_, _) -> toStringCJType(CJPrimType(CJBool))
	| OrExp(_, _) -> toStringCJType(CJPrimType(CJBool))

let getTypeOfExp2 (e: exp2) (te: (string*string) list) (p: cJProgram) =
	match e with
	| NewExp(name, _) -> name
	| MethodCall(varName, name, varList) -> toStringCJType(getMethodReturnType (getMethodWithName name (getMethodList (getClassWithName (getVarType name te) p))));;

let getTypeOfExp3 (e: exp3) (te: (string*string) list) (p: cJProgram) = 
	match e with 
	| Exp(e) -> getTypeOfExp e te p
	| Exp2(e) -> getTypeOfExp2 e te p;;

let rec getTypeOfSuperExp (e: superExp) (te: (string*string) list) (p: cJProgram)=
	match e with
	| Exp3(e) -> getTypeOfExp3 e te p
	| IfExp(_, st) -> getTypeOfSuperExp st te p
	| IfElseExp(_, ifSt, elseSt) -> if (getTypeOfSuperExp ifSt te p) = (getTypeOfSuperExp elseSt te p) then (getTypeOfSuperExp ifSt te p) else raise (Failure "Not the same return type")
	| WhileExp(_, st) -> (getTypeOfSuperExp st te p)
	| CompoundExp(_, st) -> (getTypeOfSuperExp st te p)
	| AssignExp(_, _) -> toStringCJType(CJPrimType(CJVoid))
	| ReturnExp(e) -> (getTypeOfExp e te p)
	| DeclareVarExp(_, _) -> toStringCJType(CJPrimType(CJVoid))

