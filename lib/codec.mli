type encode_error =
  | Unsupported_value of string
  | Depth_limit_exceeded
  | Missing_field of string

type decode_error =
  | Corrupt_data of string
  | Unknown_type of string
  | Missing_field of string
  | Depth_limit_exceeded

val value_to_proto   : Types.value -> (Schema.value, encode_error) result
val value_from_proto : Schema.value -> (Types.value, decode_error) result

val document_to_proto   : Types.document -> (Schema.document, encode_error) result
val document_from_proto : Schema.document -> (Types.document, decode_error) result

val node_to_proto   : Types.document -> int64 -> string -> (Schema.node, encode_error) result
val node_from_proto : Schema.node -> (Types.document * int64 * string, decode_error) result

val edge_to_proto   : Schema.edge_direction -> int64 -> int64 -> Types.document -> (Schema.edge, encode_error) result
val edge_from_proto : Schema.edge -> (Schema.edge_direction * int64 * int64 * Types.document, decode_error) result

val encode_node  : Schema.node  -> (bytes, encode_error) result
val decode_node  : bytes        -> (Schema.node, decode_error) result

val encode_edge  : Schema.edge  -> (bytes, encode_error) result
val decode_edge  : bytes        -> (Schema.edge, decode_error) result

val encode_graph : Schema.graph -> (bytes, encode_error) result
val decode_graph : bytes        -> (Schema.graph, decode_error) result
