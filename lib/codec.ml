open Base

(* codec.ml is the serialization and deserialization layer.
   Bridges between the Types and Protobuf/Schema layer. *)

type encode_error =
  | Unsupported_value of string
  | Depth_limit_exceeded
  | Missing_field of string

type decode_error =
  | Corrupt_data of string
  | Unknown_type of string
  | Missing_field of string
  | Depth_limit_exceeded

let ( >>= ) = Result.bind


let rec value_to_proto = function
  | Types.Null        -> Ok (Schema.Null_value true)
  | Types.Bool b      -> Ok (Schema.Bool_value b)
  | Types.Int i       -> Ok (Schema.Int_value i)
  | Types.Float f     -> Ok (Schema.Float_value f)
  | Types.String s    -> Ok (Schema.String_value s)
  | Types.Binary b    -> Ok (Schema.Binary_value b)
  | Types.ObjectId s  -> Ok (Schema.Object_id s)
  | Types.Timestamp t -> Ok (Schema.Timestamp t)
  | Types.NodeId n    -> Ok (Schema.Node_id n)
  | Types.EdgeId e    -> Ok (Schema.Edge_id e)
  | Types.Array vs ->
      List.map vs ~f:value_to_proto
      |> Result.combine_errors
      |> Result.map_error ~f:List.hd_exn
      |> Result.map ~f:(fun proto_vs ->
         Schema.Array_value (Schema.make_array ~values:proto_vs ()) )
  | Types.Document d ->
      document_to_proto d >>= fun proto_doc ->
      Ok (Schema.Doc_value proto_doc)

and document_to_proto doc =
  let pairs = Map.to_alist doc in
  List.map pairs ~f:(fun (k, v) ->
    value_to_proto v
    |> Result.map ~f:(fun proto_v -> (k, proto_v))
  )
  |> Result.combine_errors
  |> Result.map_error ~f:List.hd_exn
  |> Result.map ~f:(fun fields -> { Schema.fields })


let rec value_from_proto = function
  | Schema.Null_value _   -> Ok Types.Null
  | Schema.Bool_value b   -> Ok (Types.Bool b)
  | Schema.Int_value i    -> Ok (Types.Int i)
  | Schema.Float_value f  -> Ok (Types.Float f)
  | Schema.String_value s -> Ok (Types.String s)
  | Schema.Binary_value b -> Ok (Types.Binary b)
  | Schema.Object_id s    -> Ok (Types.ObjectId s)
  | Schema.Timestamp t    -> Ok (Types.Timestamp t)
  | Schema.Node_id n      -> Ok (Types.NodeId n)
  | Schema.Edge_id e      -> Ok (Types.EdgeId e)
  | Schema.Array_value a ->
      List.map a.Schema.values ~f:value_from_proto
      |> Result.combine_errors
      |> Result.map_error ~f:List.hd_exn
      |> Result.map ~f:(fun vs -> Types.Array vs )
  | Schema.Doc_value d ->
      document_from_proto d >>= fun doc ->
      Ok (Types.Document doc)

and document_from_proto doc =
  List.map doc.Schema.fields ~f:(fun (k, v) ->
    value_from_proto v
    |> Result.map ~f:(fun types_v -> (k, types_v))
  )
  |> Result.combine_errors
  |> Result.map_error ~f:List.hd_exn
  |> Result.map ~f:(fun pairs ->
      List.fold pairs
        ~init:(Map.empty (module String))
        ~f:(fun acc (k, v) -> Map.set acc ~key:k ~data:v))

(* ─────────────────────────────────────────
   NODE CONVERSION
   ───────────────────────────────────────── *)

let node_to_proto doc id alias =
  document_to_proto doc >>= fun proto_doc ->
  let now = Int64.of_float (Unix.gettimeofday () *. 1000.0) in
  Ok {
    Schema.id;
    Schema.alias;
    Schema.properties  = Some proto_doc;
    Schema.created_at  = now;
    Schema.updated_at  = now;
    Schema.version     = 1L;
    Schema.is_deleted  = false;
    Schema.history     = [];
    Schema.labels      = [];
    Schema.graph_names = [];
    Schema._presence   = Pbrt.Bitfield.make ();
  }

let node_from_proto node =
  match node.Schema.properties with
  | None ->
      Error (Missing_field "properties")
  | Some proto_doc ->
      document_from_proto proto_doc >>= fun doc ->
      Ok (doc, node.Schema.id, node.Schema.alias)


let edge_to_proto direction source target doc =
  document_to_proto doc >>= fun proto_doc ->
  let now = Int64.of_float (Unix.gettimeofday () *. 1000.0) in
  Ok {
    Schema.id          = 0L;
    Schema.alias       = "";
    Schema.source;
    Schema.target;
    Schema.direction;
    Schema.properties  = Some proto_doc;
    Schema.created_at  = now;
    Schema.updated_at  = now;
    Schema.version     = 1L;
    Schema.is_deleted  = false;
    Schema.history     = [];
    Schema.labels      = [];
    Schema.weights     = [];
    Schema.graph_names = [];
    Schema._presence   = Pbrt.Bitfield.make ();
  }

let edge_from_proto edge =
  match edge.Schema.properties with
  | None ->
      Error (Missing_field "properties")
  | Some proto_doc ->
      document_from_proto proto_doc >>= fun doc ->
      Ok (edge.Schema.direction,
          edge.Schema.source,
          edge.Schema.target,
          doc)


let encode_node (node : Schema.node) =
  try
    let encoder = Pbrt.Encoder.create () in
    Schema.encode_pb_node node encoder;
    Ok (Pbrt.Encoder.to_bytes encoder)
  with exn ->
    Error (Unsupported_value (Exn.to_string exn))

let decode_node bytes =
  try
    let decoder = Pbrt.Decoder.of_bytes bytes in
    Ok (Schema.decode_pb_node decoder)
  with exn ->
    Error (Corrupt_data (Exn.to_string exn))

let encode_edge (edge : Schema.edge) =
  try
    let encoder = Pbrt.Encoder.create () in
    Schema.encode_pb_edge edge encoder;
    Ok (Pbrt.Encoder.to_bytes encoder)
  with exn ->
    Error (Unsupported_value (Exn.to_string exn))

let decode_edge bytes =
  try
    let decoder = Pbrt.Decoder.of_bytes bytes in
    Ok (Schema.decode_pb_edge decoder)
  with exn ->
    Error (Corrupt_data (Exn.to_string exn))

let encode_graph (graph : Schema.graph) =
  try
    let encoder = Pbrt.Encoder.create () in
    Schema.encode_pb_graph graph encoder;
    Ok (Pbrt.Encoder.to_bytes encoder)
  with exn ->
    Error (Unsupported_value (Exn.to_string exn))

let decode_graph bytes =
  try
    let decoder = Pbrt.Decoder.of_bytes bytes in
    Ok (Schema.decode_pb_graph decoder)
  with exn ->
    Error (Corrupt_data (Printexc.to_string exn))
