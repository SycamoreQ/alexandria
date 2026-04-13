type value =
  | Null
  | Bool of bool
  | Int of int64
  | Float of float
  | String of string
  | Binary of bytes
  | ObjectId of string        (* 12-byte unique identifier *)
  | Array of value list
  | Document of (string * value) list
  | Timestamp of int64

type document = (string * value) list

val compare_value : value -> value -> int
val equal_value   : value -> value -> bool

val pp_value    : Format.formatter -> value -> unit
val pp_document : Format.formatter -> document -> unit

val document_get : document -> string -> value option
val document_set : document -> string -> value -> document
val is_null      : value -> bool
val type_name    : value -> string
