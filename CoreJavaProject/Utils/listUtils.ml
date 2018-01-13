let append l1 l2 =
  let rec loop acc l1 l2 =
    match l1, l2 with
    | [], [] -> List.rev acc
    | [], h :: t -> loop (h :: acc) [] t
    | h :: t, l -> loop (h :: acc) t l
    in
    loop [] l1 l2;;

let rec find e l =
	match l with
    | [] -> false
    | h::t -> h = e || find e t;;

let rec union l1 l2 =
    match l1 with
    | [] -> l2
    | h::t -> if find h l2 then union t l2
              else union t (h::l2);;		

let rec difference l1 l2 res : (string*string) list = 
  	match l1 with
  	| [] -> []
  	| h::t -> if find h l2 then difference t l2 res
  					  else difference t l2 (h::res);;

let rec check_dup l = match l with
    [] -> false
    | (h::t) ->
       let x = (List.filter (fun x -> x = h) t) in
         if (x == []) then
            check_dup t
         else
       true;;

let toStringPair(c: string*string) =
	match c with
	| (child, parent) -> String.concat " " [child; parent; "\n"];;

let rec toStringPairs(l: (string*string) list) = 
	match l with 
	| [] -> ""
	| h::t -> String.concat "" [toStringPair(h); toStringPairs(t)];;