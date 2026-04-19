
(** Code for schema.proto *)

(* generated from "schema.proto", do not edit *)



(** {2 Types} *)

type value =
  | Null_value of bool
  | Bool_value of bool
  | Int_value of int64
  | Float_value of float
  | String_value of string
  | Binary_value of bytes
  | Object_id of string
  | Array_value of array_
  | Doc_value of document
  | Timestamp of int64
  | Node_id of int64
  | Edge_id of int64

and array_ = private {
  mutable values : value list;
}

and document = private {
  mutable fields : (string * value) list;
}

type label = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable name : string;
  mutable parents : string list;
  mutable properties : document option;
}

type weight = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable name : string;
  mutable value : float;
}

type version = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable version_id : int64;
  mutable created_at : int64;
  mutable updated_at : int64;
  mutable updated_by : string;
  mutable delta : document option;
}

type node = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 7 fields *)
  mutable id : int64;
  mutable alias : string;
  mutable labels : label list;
  mutable properties : document option;
  mutable created_at : int64;
  mutable updated_at : int64;
  mutable version : int64;
  mutable history : version list;
  mutable is_deleted : bool;
  mutable deleted_at : int64;
  mutable graph_names : string list;
}

type edge_direction =
  | Directed 
  | Undirected 

type edge = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 10 fields *)
  mutable id : int64;
  mutable alias : string;
  mutable source : int64;
  mutable target : int64;
  mutable direction : edge_direction;
  mutable labels : label list;
  mutable weights : weight list;
  mutable properties : document option;
  mutable created_at : int64;
  mutable updated_at : int64;
  mutable version : int64;
  mutable history : version list;
  mutable is_deleted : bool;
  mutable deleted_at : int64;
  mutable graph_names : string list;
}

type graph = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 8 fields *)
  mutable name : string;
  mutable description : string;
  mutable properties : document option;
  mutable created_at : int64;
  mutable updated_at : int64;
  mutable is_deleted : bool;
  mutable deleted_at : int64;
  mutable node_count : int64;
  mutable edge_count : int64;
}

type database_meta = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 6 fields *)
  mutable name : string;
  mutable version : string;
  mutable created_at : int64;
  mutable page_size : int64;
  mutable page_count : int64;
  mutable graph_names : string list;
  mutable schema_version : int64;
}


(** {2 Basic values} *)

val default_value : unit -> value
(** [default_value ()] is a new empty value for type [value] *)

val default_array_ : unit -> array_ 
(** [default_array_ ()] is a new empty value for type [array_] *)

val default_document : unit -> document 
(** [default_document ()] is a new empty value for type [document] *)

val default_label : unit -> label 
(** [default_label ()] is a new empty value for type [label] *)

val default_weight : unit -> weight 
(** [default_weight ()] is a new empty value for type [weight] *)

val default_version : unit -> version 
(** [default_version ()] is a new empty value for type [version] *)

val default_node : unit -> node 
(** [default_node ()] is a new empty value for type [node] *)

val default_edge_direction : unit -> edge_direction
(** [default_edge_direction ()] is a new empty value for type [edge_direction] *)

val default_edge : unit -> edge 
(** [default_edge ()] is a new empty value for type [edge] *)

val default_graph : unit -> graph 
(** [default_graph ()] is a new empty value for type [graph] *)

val default_database_meta : unit -> database_meta 
(** [default_database_meta ()] is a new empty value for type [database_meta] *)


(** {2 Make functions} *)

val make_array_ : 
  ?values:value list ->
  unit ->
  array_
(** [make_array_ … ()] is a builder for type [array_] *)

val copy_array_ : array_ -> array_

val array__set_values : array_ -> value list -> unit
  (** set field values in array_ *)

val make_document : 
  ?fields:(string * value) list ->
  unit ->
  document
(** [make_document … ()] is a builder for type [document] *)

val copy_document : document -> document

val document_set_fields : document -> (string * value) list -> unit
  (** set field fields in document *)

val make_label : 
  ?name:string ->
  ?parents:string list ->
  ?properties:document ->
  unit ->
  label
(** [make_label … ()] is a builder for type [label] *)

val copy_label : label -> label

val label_has_name : label -> bool
  (** presence of field "name" in [label] *)

val label_set_name : label -> string -> unit
  (** set field name in label *)

val label_set_parents : label -> string list -> unit
  (** set field parents in label *)

val label_has_properties : label -> bool
  (** presence of field "properties" in [label] *)

val label_set_properties : label -> document -> unit
  (** set field properties in label *)

val make_weight : 
  ?name:string ->
  ?value:float ->
  unit ->
  weight
(** [make_weight … ()] is a builder for type [weight] *)

val copy_weight : weight -> weight

val weight_has_name : weight -> bool
  (** presence of field "name" in [weight] *)

val weight_set_name : weight -> string -> unit
  (** set field name in weight *)

val weight_has_value : weight -> bool
  (** presence of field "value" in [weight] *)

val weight_set_value : weight -> float -> unit
  (** set field value in weight *)

val make_version : 
  ?version_id:int64 ->
  ?created_at:int64 ->
  ?updated_at:int64 ->
  ?updated_by:string ->
  ?delta:document ->
  unit ->
  version
(** [make_version … ()] is a builder for type [version] *)

val copy_version : version -> version

val version_has_version_id : version -> bool
  (** presence of field "version_id" in [version] *)

val version_set_version_id : version -> int64 -> unit
  (** set field version_id in version *)

val version_has_created_at : version -> bool
  (** presence of field "created_at" in [version] *)

val version_set_created_at : version -> int64 -> unit
  (** set field created_at in version *)

val version_has_updated_at : version -> bool
  (** presence of field "updated_at" in [version] *)

val version_set_updated_at : version -> int64 -> unit
  (** set field updated_at in version *)

val version_has_updated_by : version -> bool
  (** presence of field "updated_by" in [version] *)

val version_set_updated_by : version -> string -> unit
  (** set field updated_by in version *)

val version_has_delta : version -> bool
  (** presence of field "delta" in [version] *)

val version_set_delta : version -> document -> unit
  (** set field delta in version *)

val make_node : 
  ?id:int64 ->
  ?alias:string ->
  ?labels:label list ->
  ?properties:document ->
  ?created_at:int64 ->
  ?updated_at:int64 ->
  ?version:int64 ->
  ?history:version list ->
  ?is_deleted:bool ->
  ?deleted_at:int64 ->
  ?graph_names:string list ->
  unit ->
  node
(** [make_node … ()] is a builder for type [node] *)

val copy_node : node -> node

val node_has_id : node -> bool
  (** presence of field "id" in [node] *)

val node_set_id : node -> int64 -> unit
  (** set field id in node *)

val node_has_alias : node -> bool
  (** presence of field "alias" in [node] *)

val node_set_alias : node -> string -> unit
  (** set field alias in node *)

val node_set_labels : node -> label list -> unit
  (** set field labels in node *)

val node_has_properties : node -> bool
  (** presence of field "properties" in [node] *)

val node_set_properties : node -> document -> unit
  (** set field properties in node *)

val node_has_created_at : node -> bool
  (** presence of field "created_at" in [node] *)

val node_set_created_at : node -> int64 -> unit
  (** set field created_at in node *)

val node_has_updated_at : node -> bool
  (** presence of field "updated_at" in [node] *)

val node_set_updated_at : node -> int64 -> unit
  (** set field updated_at in node *)

val node_has_version : node -> bool
  (** presence of field "version" in [node] *)

val node_set_version : node -> int64 -> unit
  (** set field version in node *)

val node_set_history : node -> version list -> unit
  (** set field history in node *)

val node_has_is_deleted : node -> bool
  (** presence of field "is_deleted" in [node] *)

val node_set_is_deleted : node -> bool -> unit
  (** set field is_deleted in node *)

val node_has_deleted_at : node -> bool
  (** presence of field "deleted_at" in [node] *)

val node_set_deleted_at : node -> int64 -> unit
  (** set field deleted_at in node *)

val node_set_graph_names : node -> string list -> unit
  (** set field graph_names in node *)

val make_edge : 
  ?id:int64 ->
  ?alias:string ->
  ?source:int64 ->
  ?target:int64 ->
  ?direction:edge_direction ->
  ?labels:label list ->
  ?weights:weight list ->
  ?properties:document ->
  ?created_at:int64 ->
  ?updated_at:int64 ->
  ?version:int64 ->
  ?history:version list ->
  ?is_deleted:bool ->
  ?deleted_at:int64 ->
  ?graph_names:string list ->
  unit ->
  edge
(** [make_edge … ()] is a builder for type [edge] *)

val copy_edge : edge -> edge

val edge_has_id : edge -> bool
  (** presence of field "id" in [edge] *)

val edge_set_id : edge -> int64 -> unit
  (** set field id in edge *)

val edge_has_alias : edge -> bool
  (** presence of field "alias" in [edge] *)

val edge_set_alias : edge -> string -> unit
  (** set field alias in edge *)

val edge_has_source : edge -> bool
  (** presence of field "source" in [edge] *)

val edge_set_source : edge -> int64 -> unit
  (** set field source in edge *)

val edge_has_target : edge -> bool
  (** presence of field "target" in [edge] *)

val edge_set_target : edge -> int64 -> unit
  (** set field target in edge *)

val edge_has_direction : edge -> bool
  (** presence of field "direction" in [edge] *)

val edge_set_direction : edge -> edge_direction -> unit
  (** set field direction in edge *)

val edge_set_labels : edge -> label list -> unit
  (** set field labels in edge *)

val edge_set_weights : edge -> weight list -> unit
  (** set field weights in edge *)

val edge_has_properties : edge -> bool
  (** presence of field "properties" in [edge] *)

val edge_set_properties : edge -> document -> unit
  (** set field properties in edge *)

val edge_has_created_at : edge -> bool
  (** presence of field "created_at" in [edge] *)

val edge_set_created_at : edge -> int64 -> unit
  (** set field created_at in edge *)

val edge_has_updated_at : edge -> bool
  (** presence of field "updated_at" in [edge] *)

val edge_set_updated_at : edge -> int64 -> unit
  (** set field updated_at in edge *)

val edge_has_version : edge -> bool
  (** presence of field "version" in [edge] *)

val edge_set_version : edge -> int64 -> unit
  (** set field version in edge *)

val edge_set_history : edge -> version list -> unit
  (** set field history in edge *)

val edge_has_is_deleted : edge -> bool
  (** presence of field "is_deleted" in [edge] *)

val edge_set_is_deleted : edge -> bool -> unit
  (** set field is_deleted in edge *)

val edge_has_deleted_at : edge -> bool
  (** presence of field "deleted_at" in [edge] *)

val edge_set_deleted_at : edge -> int64 -> unit
  (** set field deleted_at in edge *)

val edge_set_graph_names : edge -> string list -> unit
  (** set field graph_names in edge *)

val make_graph : 
  ?name:string ->
  ?description:string ->
  ?properties:document ->
  ?created_at:int64 ->
  ?updated_at:int64 ->
  ?is_deleted:bool ->
  ?deleted_at:int64 ->
  ?node_count:int64 ->
  ?edge_count:int64 ->
  unit ->
  graph
(** [make_graph … ()] is a builder for type [graph] *)

val copy_graph : graph -> graph

val graph_has_name : graph -> bool
  (** presence of field "name" in [graph] *)

val graph_set_name : graph -> string -> unit
  (** set field name in graph *)

val graph_has_description : graph -> bool
  (** presence of field "description" in [graph] *)

val graph_set_description : graph -> string -> unit
  (** set field description in graph *)

val graph_has_properties : graph -> bool
  (** presence of field "properties" in [graph] *)

val graph_set_properties : graph -> document -> unit
  (** set field properties in graph *)

val graph_has_created_at : graph -> bool
  (** presence of field "created_at" in [graph] *)

val graph_set_created_at : graph -> int64 -> unit
  (** set field created_at in graph *)

val graph_has_updated_at : graph -> bool
  (** presence of field "updated_at" in [graph] *)

val graph_set_updated_at : graph -> int64 -> unit
  (** set field updated_at in graph *)

val graph_has_is_deleted : graph -> bool
  (** presence of field "is_deleted" in [graph] *)

val graph_set_is_deleted : graph -> bool -> unit
  (** set field is_deleted in graph *)

val graph_has_deleted_at : graph -> bool
  (** presence of field "deleted_at" in [graph] *)

val graph_set_deleted_at : graph -> int64 -> unit
  (** set field deleted_at in graph *)

val graph_has_node_count : graph -> bool
  (** presence of field "node_count" in [graph] *)

val graph_set_node_count : graph -> int64 -> unit
  (** set field node_count in graph *)

val graph_has_edge_count : graph -> bool
  (** presence of field "edge_count" in [graph] *)

val graph_set_edge_count : graph -> int64 -> unit
  (** set field edge_count in graph *)

val make_database_meta : 
  ?name:string ->
  ?version:string ->
  ?created_at:int64 ->
  ?page_size:int64 ->
  ?page_count:int64 ->
  ?graph_names:string list ->
  ?schema_version:int64 ->
  unit ->
  database_meta
(** [make_database_meta … ()] is a builder for type [database_meta] *)

val copy_database_meta : database_meta -> database_meta

val database_meta_has_name : database_meta -> bool
  (** presence of field "name" in [database_meta] *)

val database_meta_set_name : database_meta -> string -> unit
  (** set field name in database_meta *)

val database_meta_has_version : database_meta -> bool
  (** presence of field "version" in [database_meta] *)

val database_meta_set_version : database_meta -> string -> unit
  (** set field version in database_meta *)

val database_meta_has_created_at : database_meta -> bool
  (** presence of field "created_at" in [database_meta] *)

val database_meta_set_created_at : database_meta -> int64 -> unit
  (** set field created_at in database_meta *)

val database_meta_has_page_size : database_meta -> bool
  (** presence of field "page_size" in [database_meta] *)

val database_meta_set_page_size : database_meta -> int64 -> unit
  (** set field page_size in database_meta *)

val database_meta_has_page_count : database_meta -> bool
  (** presence of field "page_count" in [database_meta] *)

val database_meta_set_page_count : database_meta -> int64 -> unit
  (** set field page_count in database_meta *)

val database_meta_set_graph_names : database_meta -> string list -> unit
  (** set field graph_names in database_meta *)

val database_meta_has_schema_version : database_meta -> bool
  (** presence of field "schema_version" in [database_meta] *)

val database_meta_set_schema_version : database_meta -> int64 -> unit
  (** set field schema_version in database_meta *)


(** {2 Formatters} *)

val pp_value : Format.formatter -> value -> unit 
(** [pp_value v] formats v *)

val pp_array_ : Format.formatter -> array_ -> unit 
(** [pp_array_ v] formats v *)

val pp_document : Format.formatter -> document -> unit 
(** [pp_document v] formats v *)

val pp_label : Format.formatter -> label -> unit 
(** [pp_label v] formats v *)

val pp_weight : Format.formatter -> weight -> unit 
(** [pp_weight v] formats v *)

val pp_version : Format.formatter -> version -> unit 
(** [pp_version v] formats v *)

val pp_node : Format.formatter -> node -> unit 
(** [pp_node v] formats v *)

val pp_edge_direction : Format.formatter -> edge_direction -> unit 
(** [pp_edge_direction v] formats v *)

val pp_edge : Format.formatter -> edge -> unit 
(** [pp_edge v] formats v *)

val pp_graph : Format.formatter -> graph -> unit 
(** [pp_graph v] formats v *)

val pp_database_meta : Format.formatter -> database_meta -> unit 
(** [pp_database_meta v] formats v *)


(** {2 Protobuf Encoding} *)

val encode_pb_value : value -> Pbrt.Encoder.t -> unit
(** [encode_pb_value v encoder] encodes [v] with the given [encoder] *)

val encode_pb_array_ : array_ -> Pbrt.Encoder.t -> unit
(** [encode_pb_array_ v encoder] encodes [v] with the given [encoder] *)

val encode_pb_document : document -> Pbrt.Encoder.t -> unit
(** [encode_pb_document v encoder] encodes [v] with the given [encoder] *)

val encode_pb_label : label -> Pbrt.Encoder.t -> unit
(** [encode_pb_label v encoder] encodes [v] with the given [encoder] *)

val encode_pb_weight : weight -> Pbrt.Encoder.t -> unit
(** [encode_pb_weight v encoder] encodes [v] with the given [encoder] *)

val encode_pb_version : version -> Pbrt.Encoder.t -> unit
(** [encode_pb_version v encoder] encodes [v] with the given [encoder] *)

val encode_pb_node : node -> Pbrt.Encoder.t -> unit
(** [encode_pb_node v encoder] encodes [v] with the given [encoder] *)

val encode_pb_edge_direction : edge_direction -> Pbrt.Encoder.t -> unit
(** [encode_pb_edge_direction v encoder] encodes [v] with the given [encoder] *)

val encode_pb_edge : edge -> Pbrt.Encoder.t -> unit
(** [encode_pb_edge v encoder] encodes [v] with the given [encoder] *)

val encode_pb_graph : graph -> Pbrt.Encoder.t -> unit
(** [encode_pb_graph v encoder] encodes [v] with the given [encoder] *)

val encode_pb_database_meta : database_meta -> Pbrt.Encoder.t -> unit
(** [encode_pb_database_meta v encoder] encodes [v] with the given [encoder] *)


(** {2 Protobuf Decoding} *)

val decode_pb_value : Pbrt.Decoder.t -> value
(** [decode_pb_value decoder] decodes a [value] binary value from [decoder] *)

val decode_pb_array_ : Pbrt.Decoder.t -> array_
(** [decode_pb_array_ decoder] decodes a [array_] binary value from [decoder] *)

val decode_pb_document : Pbrt.Decoder.t -> document
(** [decode_pb_document decoder] decodes a [document] binary value from [decoder] *)

val decode_pb_label : Pbrt.Decoder.t -> label
(** [decode_pb_label decoder] decodes a [label] binary value from [decoder] *)

val decode_pb_weight : Pbrt.Decoder.t -> weight
(** [decode_pb_weight decoder] decodes a [weight] binary value from [decoder] *)

val decode_pb_version : Pbrt.Decoder.t -> version
(** [decode_pb_version decoder] decodes a [version] binary value from [decoder] *)

val decode_pb_node : Pbrt.Decoder.t -> node
(** [decode_pb_node decoder] decodes a [node] binary value from [decoder] *)

val decode_pb_edge_direction : Pbrt.Decoder.t -> edge_direction
(** [decode_pb_edge_direction decoder] decodes a [edge_direction] binary value from [decoder] *)

val decode_pb_edge : Pbrt.Decoder.t -> edge
(** [decode_pb_edge decoder] decodes a [edge] binary value from [decoder] *)

val decode_pb_graph : Pbrt.Decoder.t -> graph
(** [decode_pb_graph decoder] decodes a [graph] binary value from [decoder] *)

val decode_pb_database_meta : Pbrt.Decoder.t -> database_meta
(** [decode_pb_database_meta decoder] decodes a [database_meta] binary value from [decoder] *)
