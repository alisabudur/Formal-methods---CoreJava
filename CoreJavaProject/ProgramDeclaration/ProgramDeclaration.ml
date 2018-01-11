open ClassDeclaration;;
open Utils;;

type cJProgram = CJProgram of cJClass list;;

let getClassList(p : cJProgram) = 
	match p with 
	| CJProgram(l) -> l;;

let rec toStringCJProgram (p : cJProgram) = 
	match p with
	| CJProgram([]) -> ""
	| CJProgram(x::y) -> String.concat "" [toStringCJClass(x); "\n\n"; toStringCJProgram(CJProgram(y))];;

let rec classListWellTyped (p : cJProgram) = 
	match p with 
	| CJProgram([]) -> false
	| CJProgram([x]) -> classWellTyped(x)
	| CJProgram(x::y) -> classWellTyped(x) && classListWellTyped(CJProgram(y));;

let rec classListNoDuplicated(p: cJProgram) = 
	match p with
	| CJProgram([]) -> true
	| CJProgram([x]) -> true
	| CJProgram(h::t) -> let x = (List.filter (fun x -> getClassName(x) = getClassName(h)) t) in
         if (x == []) then
					begin	
							(*Printf.printf "%s\n" "x class empty";*)					
            	classListNoDuplicated(CJProgram(t));
					end						
         else	
					begin	
							(*Printf.printf "%s\n" "x class not empty";*)				
       				false;
					end;;

let lastClassIsMain(p: cJProgram):bool = hasMainMethod(List.hd(List.rev(getClassList(p))));;	

let programWellTyped(p: cJProgram):bool = classListWellTyped(p) && classListNoDuplicated(p) && lastClassIsMain(p);;

let rec getInheritancePairs(p: cJProgram): ((string*string) list) = 
	match p with 
	| CJProgram([]) -> []
	| CJProgram(h::t) -> getInheritancePair(h) :: getInheritancePairs(CJProgram(t));;	

let rec toStringInheritancePairs(l: (string*string) list) = 
	match l with 
	| [] -> ""
	| h::t -> String.concat "" [toStringPair(h); toStringInheritancePairs(t)];;	
	
let first(child, _) = child;;
let last(_, parent) = parent;;		

let searchForPairs(h: string*string) (l: (string*string) list) = 
	let x = (List.filter (fun x -> first(x) = last(h)) l) in
				if (x == []) then
					begin	
							(*Printf.printf "%s\n" "x empty";*)		
							[];
					end						
         else	
					begin	
							(*Printf.printf "%s\n" "x  not empty";*)				
       				(List.map (fun y -> (first(h), last(y))) x);
					end;;

let rec searchForAllPairs (l: (string*string) list) (copyL: (string*string) list) = 
	match l with
	| [] -> []
	| [x] -> searchForPairs x copyL
	| h::t -> append (searchForPairs h copyL) (searchForAllPairs t copyL);;

let rec existsNewPairs l1 l2 = 
  	match l1 with
  	| [] -> false
  	| h::t -> if find h l2 then existsNewPairs t l2
  					  else true;;

let rec transitiveClosure (l: (string*string) list) = 
  	let newPairs = (searchForAllPairs l l) in
		if (existsNewPairs newPairs l) then
			begin
			Printf.printf "-%s-\n" (toStringInheritancePairs newPairs);
			transitiveClosure (union l newPairs);
			end
		else
			begin
			Printf.printf "-%s-\n" "[]";
			l end;;				

					
					