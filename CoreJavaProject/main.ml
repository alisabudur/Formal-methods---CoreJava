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

let assignStmt = AssignExp("name", Exp(ConstExp(ConstInt(1))));;
let declareStmt = DeclareVarExp(CJClassType("NewVar"), "newVar");;
let varList = VarList([ConstExp(ConstString("name"))]);;
let newStmt = Exp2(NewExp("NewVar", varList));;
let assignStmt2 = AssignExp("newVar", newStmt);;
let compoundStmt = CompoundExp(assignStmt, assignStmt2);;
let compoundStmt2 = CompoundExp(declareStmt, compoundStmt);;
let ifStmt = IfExp(ConstExp(ConstString("name")), compoundStmt2);;

let returnStmt = ReturnExp(ConstExp(ConstString("name")));;
let setNameMethod = CJMethod(CJPrimType(CJVoid), "setName", setNameParameterList, ifStmt);;
let getNameMethod = CJMethod(CJPrimType(CJString), "main", emptyParameterList, returnStmt);;
let methodList = CJMethodList([setNameMethod; getNameMethod]);;

let nameField = CJField(CJPrimType(CJString), "name");;
let ageField = CJField(CJPrimType(CJInt), "age");;

let fieldList = CJFieldList([nameField; ageField]);;

let personClass = CJClass("Person", "Object", fieldList, methodList);;
let personClass2 = CJClass("Person2", "Person", CJFieldList([]), methodList);;
let personClass3 = CJClass("Person3", "Person2", CJFieldList([]), methodList);;

let program = CJProgram([personClass2; personClass; personClass3]);;

let v3 = toStringCJProgram(program);;

let rez = programWellTyped(program);;

let pairs = toStringInheritancePairs(getInheritancePairs(program));;

(*let allPairs = toStringInheritancePairs((getInheritanceTree (getInheritancePairs(program)) []));;*)

let allPairs = toStringInheritancePairs (transitiveClosure (getInheritancePairs program));;

(*Printf.printf "%s\n--------------------------\n" v3;;*)
(*Printf.printf "%s \n" (string_of_bool(rez));;*)
Printf.printf "%s \n" allPairs;;