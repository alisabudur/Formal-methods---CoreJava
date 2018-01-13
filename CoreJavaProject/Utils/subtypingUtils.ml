open ListUtils;;

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
	| h::t -> union (searchForPairs h copyL) (searchForAllPairs t copyL);;

let rec existsNewPairs l1 l2 = 
  	match l1 with
  	| [] -> false
  	| h::t -> if find h l2 then existsNewPairs t l2
  					  else true;;

let rec transitiveClosure (l: (string*string) list) = 
  	let newPairs = (searchForAllPairs l l) in
		if (existsNewPairs newPairs l) then
			transitiveClosure (union l newPairs)
		else
			l;;	
	 
	

				