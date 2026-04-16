(*type defs for schema declerations*)
module StringMap = Map.Make(String)

type value =
  | Null
  | Bool of bool
  | Int of int64
  | Float of float
  | String of string
  | Binary of bytes
  | ObjectId of string
  | Array of value list
  | Document of value StringMap.t
  | Timestamp of int64
  | NodeId of int64
  | EdgeId of int64

(*type ordering. 0 is the lowest*)
let type_order = function
  | Null      -> 0
  | Bool _    -> 1
  | Int _     -> 2
  | Float _   -> 3
  | String _  -> 4
  | Binary _  -> 5
  | ObjectId _ -> 6
  | Array _   -> 7
  | Document _ -> 8
  | Timestamp _ -> 9
  | NodeId _ -> 10
  | EdgeId _ -> 11

type document = value StringMap.t

let rec compare_value a b =
  match a , b with
  |Null , Null -> 0
  |Bool x , Bool y -> Bool.compare x y
  |Int x , Int y -> Int64.compare x y
  |Float x , Float y -> Float.compare x y
  |String x , String y -> String.compare x y
  |Array x , Array y -> List.compare compare_value x y
  |Document x , Document y ->
    StringMap.compare compare_value x y
  |Binary x, Binary y   -> Bytes.compare x y
  |ObjectId x, ObjectId y -> String.compare x y
  |Timestamp x, Timestamp y -> Int64.compare x y
  |NodeId x , NodeId y -> Int64.compare x y
  |EdgeId x , EdgeId y -> Int64.compare x y
  |a , b -> Int.compare (type_order a) (type_order b)


let equal_value a b =
  match compare_value a b with
  |0 -> true
  |_ -> false


let rec pp_value fmt v =
  match v with
  | Null      -> Format.fprintf fmt "null"
  | Bool b    -> Format.fprintf fmt "%b" b
  | Int i     -> Format.fprintf fmt "%Ld" i    (* %Ld is the int64 format specifier *)
  | Float f   -> Format.fprintf fmt "%g" f
  | String s  -> Format.fprintf fmt "%S" s     (* %S adds the quotes around it *)
  | Array vs  ->
      Format.fprintf fmt "[";
      Format.pp_print_list
        ~pp_sep:(fun fmt () -> Format.fprintf fmt ", ")
        pp_value fmt vs;
     Format.fprintf fmt "]"
  | Document fields ->
    Format.fprintf fmt "{ ";
    let first = ref true in
    StringMap.iter (fun k v ->
      if !first then first := false
      else Format.fprintf fmt ", ";
      Format.fprintf fmt "%s: %a" k pp_value v
    ) fields;
    Format.fprintf fmt " }"
  |Timestamp t -> Format.fprintf fmt "%Ld" t
  |Binary b -> Format.fprintf fmt "<binary:%d>" (Bytes.length b)
  |ObjectId s -> Format.fprintf fmt "ObjectId(%s)" s
  |NodeId n -> Format.fprintf fmt "%Ld" n
  |EdgeId e -> Format.fprintf fmt "%Ld" e


let pp_document fmt doc =
  pp_value fmt (Document doc)

let document_get doc key =
  StringMap.find_opt key doc

let document_set doc key value =
  StringMap.add key value doc

let is_null v =
  match v with
  |Null -> true
  |_ -> false

let type_name v =
  match v with
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
