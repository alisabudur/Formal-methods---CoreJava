open ClassDeclaration;;
open MethodDeclaration;;
open FieldDeclaration;;
open TypeDeclaration;;
open ProgramDeclaration;;
open ExpDeclaration;;

let nameParameter = CJMethodParameter(CJPrimType(CJString), "newName");;
let ageParameter = CJMethodParameter(CJPrimType(CJInt), "newAge");;

let setNameParameterList = CJMethodParameterList([nameParameter; ageParameter]);;
let emptyParameterList = CJMethodParameterList([]);;

let assignStmt = AssignExp("name", ConstExp(ConstInt(1)));;
let ifStmt = IfExp(ConstExp(ConstString("name")), assignStmt);;

let returnStmt = ReturnExp(ConstExp(ConstString("name")));;
let setNameMethod = CJMethod(CJPrimType(CJVoid), "setName", setNameParameterList, ifStmt);;
let getNameMethod = CJMethod(CJPrimType(CJString), "getName", emptyParameterList, returnStmt);;
let methodList = CJMethodList([setNameMethod; getNameMethod]);;

let nameField = CJField(CJPrimType(CJString), "name");;
let ageField = CJField(CJPrimType(CJInt), "age");;

let fieldList = CJFieldList([nameField; ageField]);;

let personClass = CJClass("Person", "Object", fieldList, methodList);;

let program = CJProgram([personClass]);;

let v3 = toStringCJProgram(program);;

Printf.printf "%s" v3;;