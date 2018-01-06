type cJPrimType = CJInt | CJFloat | CJBool | CJString | CJVoid
type cJBottom = CJBottom of string
type cJType =
    CJPrimType of cJPrimType
  | CJClassType of string
  | CJBottom of cJBottom
val toStringCJPrimType : cJPrimType -> string
val toStringCJType : cJType -> string
