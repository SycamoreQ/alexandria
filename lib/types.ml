open Base

type value =
  | Null
  | Bool of bool
  | Int of int64
  | Float of float
  | String of string
  | Binary of bytes
  | ObjectId of string
  | Array of value list
  | Document of value Map.M(String).t
  | Timestamp of int64
  | NodeId of int64
  | EdgeId of int64

type document = value Map.M(String).t

let type_order = function
  | Null       -> 0
  | Bool _     -> 1
  | Int _      -> 2
  | Float _    -> 3
  | String _   -> 4
  | Binary _   -> 5
  | ObjectId _ -> 6
  | Array _    -> 7
  | Document _ -> 8
  | Timestamp _ -> 9
  | NodeId _   -> 10
  | EdgeId _   -> 11

let rec compare_value a b =
  match a, b with
  | Null,        Null        -> 0
  | Bool x,      Bool y      -> Bool.compare x y
  | Int x,       Int y       -> Int64.compare x y
  | Float x,     Float y     -> Float.compare x y
  | String x,    String y    -> String.compare x y
  | Binary x,    Binary y    -> Bytes.compare x y
  | ObjectId x,  ObjectId y  -> String.compare x y
  | Timestamp x, Timestamp y -> Int64.compare x y
  | NodeId x,    NodeId y    -> Int64.compare x y
  | EdgeId x,    EdgeId y    -> Int64.compare x y
  | Array x,     Array y     -> List.compare compare_value x y
  | Document x,  Document y  -> Map.compare_direct compare_value x y
  | a, b -> Int.compare (type_order a) (type_order b)

let equal_value a b =
  match compare_value a b with
  | 0 -> true
  | _ -> false

let rec pp_value fmt v =
  match v with
  | Null       -> Stdlib.Format.fprintf fmt "null"
  | Bool b     -> Stdlib.Format.fprintf fmt "%b" b
  | Int i      -> Stdlib.Format.fprintf fmt "%Ld" i
  | Float f    -> Stdlib.Format.fprintf fmt "%g" f
  | String s   -> Stdlib.Format.fprintf fmt "%S" s
  | Binary b   -> Stdlib.Format.fprintf fmt "<binary:%d>" (Bytes.length b)
  | ObjectId s -> Stdlib.Format.fprintf fmt "ObjectId(%s)" s
  | Timestamp t -> Stdlib.Format.fprintf fmt "%Ld" t
  | NodeId n   -> Stdlib.Format.fprintf fmt "NodeId(%Ld)" n
  | EdgeId e   -> Stdlib.Format.fprintf fmt "EdgeId(%Ld)" e
  | Array vs   ->
      Stdlib.Format.fprintf fmt "[";
      Stdlib.Format.pp_print_list
        ~pp_sep:(fun fmt () -> Stdlib.Format.fprintf fmt ", ")
        pp_value fmt vs;
      Stdlib.Format.fprintf fmt "]"
| Document fields ->
      Stdlib.Format.fprintf fmt "{ ";
      (* The accumulator 'is_first' starts as true *)
      let _ = Map.fold fields ~init:true ~f:(fun ~key ~data is_first ->
        if not is_first then Stdlib.Format.fprintf fmt ", ";
        Stdlib.Format.fprintf fmt "%s: %a" key pp_value data;
        false (* Every subsequent iteration, is_first will be false *)
      ) in
      Stdlib.Format.fprintf fmt " }"

let pp_document fmt doc =
  pp_value fmt (Document doc)

let pp_document fmt doc =
  pp_value fmt (Document doc)

let document_get doc key =
  Map.find doc key

let document_set doc key value =
  Map.set doc ~key ~data:value

let is_null = function
  | Null -> true
  | _    -> false

let type_name = function
  | Null       -> "null"
  | Bool _     -> "bool"
  | Int _      -> "int"
  | Float _    -> "float"
  | String _   -> "string"
  | Binary _   -> "binary"
  | ObjectId _ -> "objectid"
  | Array _    -> "array"
  | Document _ -> "document"
  | Timestamp _ -> "timestamp"
  | NodeId _   -> "nodeid"
  | EdgeId _   -> "edgeid"
