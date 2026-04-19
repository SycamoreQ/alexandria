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

val compare_value : value -> value -> int
val equal_value   : value -> value -> bool

val pp_value    : Stdlib.Format.formatter -> value -> unit
val pp_document : Stdlib.Format.formatter -> document -> unit

val document_get : document -> string -> value option
val document_set : document -> string -> value -> document
val is_null      : value -> bool
val type_name    : value -> string
