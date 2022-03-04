type 'a t = 'a option

let some x = Some x
let none = None
let is_some = function Some _ -> true | None -> false
let is_none = function None -> true | Some _ -> false
let map f = function Some x -> Some (f x) | None -> None
let bind f = function Some x -> f x | None -> None
let apply fa xa = match (fa, xa) with Some f, Some x -> Some (f x) | _ -> None
let value ~default = function Some x -> x | None -> default
let product a b = apply (map (fun a b -> (a, b)) a) b
let join = function Some x -> x | None -> None
let fold ~none ~some = function None -> none | Some x -> some x

let equal eq a b =
  match (a, b) with None, None -> true | Some x, Some y -> eq x y | _ -> false

let compare cmp a b =
  match (a, b) with
  | None, None -> 0
  | Some x, Some y -> cmp x y
  | Some _, _ -> 1
  | None, _ -> -1

let pp aux ppf = function
  | None -> Format.fprintf ppf "None"
  | Some x -> Format.fprintf ppf "Some(%a)" aux x

module Infix = struct
  let ( <$> ) = map
  let ( >|= ) x f = map f x
  let ( =|< ) = map
  let ( >>= ) x f = bind f x
  let ( =<< ) = bind
  let ( <*> ) = apply
end

module Syntax = struct
  let ( let+ ) x f = map f x
  let ( let* ) x f = bind f x
  let ( and+ ) = product
end

include Infix
include Syntax
