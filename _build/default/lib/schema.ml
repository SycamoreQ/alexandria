[@@@ocaml.warning "-23-27-30-39-44"]

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

and array_ = {
  mutable values : value list;
}

and document = {
  mutable fields : (string * value) list;
}

type label = {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable name : string;
  mutable parents : string list;
  mutable properties : document option;
}

type weight = {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable name : string;
  mutable value : float;
}

type version = {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable version_id : int64;
  mutable created_at : int64;
  mutable updated_at : int64;
  mutable updated_by : string;
  mutable delta : document option;
}

type node = {
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

type edge = {
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

type graph = {
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

type database_meta = {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 6 fields *)
  mutable name : string;
  mutable version : string;
  mutable created_at : int64;
  mutable page_size : int64;
  mutable page_count : int64;
  mutable graph_names : string list;
  mutable schema_version : int64;
}

let default_value (): value = Null_value (false)

let default_array_ (): array_ =
{
  values=[];
}

let default_document (): document =
{
  fields=[];
}

let default_label (): label =
{
  _presence=Pbrt.Bitfield.empty;
  name="";
  parents=[];
  properties=None;
}

let default_weight (): weight =
{
  _presence=Pbrt.Bitfield.empty;
  name="";
  value=0.;
}

let default_version (): version =
{
  _presence=Pbrt.Bitfield.empty;
  version_id=0L;
  created_at=0L;
  updated_at=0L;
  updated_by="";
  delta=None;
}

let default_node (): node =
{
  _presence=Pbrt.Bitfield.empty;
  id=0L;
  alias="";
  labels=[];
  properties=None;
  created_at=0L;
  updated_at=0L;
  version=0L;
  history=[];
  is_deleted=false;
  deleted_at=0L;
  graph_names=[];
}

let default_edge_direction () = (Directed:edge_direction)

let default_edge (): edge =
{
  _presence=Pbrt.Bitfield.empty;
  id=0L;
  alias="";
  source=0L;
  target=0L;
  direction=default_edge_direction ();
  labels=[];
  weights=[];
  properties=None;
  created_at=0L;
  updated_at=0L;
  version=0L;
  history=[];
  is_deleted=false;
  deleted_at=0L;
  graph_names=[];
}

let default_graph (): graph =
{
  _presence=Pbrt.Bitfield.empty;
  name="";
  description="";
  properties=None;
  created_at=0L;
  updated_at=0L;
  is_deleted=false;
  deleted_at=0L;
  node_count=0L;
  edge_count=0L;
}

let default_database_meta (): database_meta =
{
  _presence=Pbrt.Bitfield.empty;
  name="";
  version="";
  created_at=0L;
  page_size=0L;
  page_count=0L;
  graph_names=[];
  schema_version=0L;
}


(** {2 Make functions} *)


let[@inline] array__set_values (self:array_) (x:value list) : unit =
  self.values <- x

let copy_array_ (self:array_) : array_ =
  { self with values = self.values }

let make_array_ 
  ?(values=[])
  () : array_  =
  let _res = default_array_ () in
  array__set_values _res values;
  _res


let[@inline] document_set_fields (self:document) (x:(string * value) list) : unit =
  self.fields <- x

let copy_document (self:document) : document =
  { self with fields = self.fields }

let make_document 
  ?(fields=[])
  () : document  =
  let _res = default_document () in
  document_set_fields _res fields;
  _res

let[@inline] label_has_name (self:label) : bool = (Pbrt.Bitfield.get self._presence 0)
let[@inline] label_has_properties (self:label) : bool = self.properties != None

let[@inline] label_set_name (self:label) (x:string) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 0); self.name <- x
let[@inline] label_set_parents (self:label) (x:string list) : unit =
  self.parents <- x
let[@inline] label_set_properties (self:label) (x:document) : unit =
  self.properties <- Some x

let copy_label (self:label) : label =
  { self with name = self.name }

let make_label 
  ?(name:string option)
  ?(parents=[])
  ?(properties:document option)
  () : label  =
  let _res = default_label () in
  (match name with
  | None -> ()
  | Some v -> label_set_name _res v);
  label_set_parents _res parents;
  (match properties with
  | None -> ()
  | Some v -> label_set_properties _res v);
  _res

let[@inline] weight_has_name (self:weight) : bool = (Pbrt.Bitfield.get self._presence 0)
let[@inline] weight_has_value (self:weight) : bool = (Pbrt.Bitfield.get self._presence 1)

let[@inline] weight_set_name (self:weight) (x:string) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 0); self.name <- x
let[@inline] weight_set_value (self:weight) (x:float) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 1); self.value <- x

let copy_weight (self:weight) : weight =
  { self with name = self.name }

let make_weight 
  ?(name:string option)
  ?(value:float option)
  () : weight  =
  let _res = default_weight () in
  (match name with
  | None -> ()
  | Some v -> weight_set_name _res v);
  (match value with
  | None -> ()
  | Some v -> weight_set_value _res v);
  _res

let[@inline] version_has_version_id (self:version) : bool = (Pbrt.Bitfield.get self._presence 0)
let[@inline] version_has_created_at (self:version) : bool = (Pbrt.Bitfield.get self._presence 1)
let[@inline] version_has_updated_at (self:version) : bool = (Pbrt.Bitfield.get self._presence 2)
let[@inline] version_has_updated_by (self:version) : bool = (Pbrt.Bitfield.get self._presence 3)
let[@inline] version_has_delta (self:version) : bool = self.delta != None

let[@inline] version_set_version_id (self:version) (x:int64) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 0); self.version_id <- x
let[@inline] version_set_created_at (self:version) (x:int64) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 1); self.created_at <- x
let[@inline] version_set_updated_at (self:version) (x:int64) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 2); self.updated_at <- x
let[@inline] version_set_updated_by (self:version) (x:string) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 3); self.updated_by <- x
let[@inline] version_set_delta (self:version) (x:document) : unit =
  self.delta <- Some x

let copy_version (self:version) : version =
  { self with version_id = self.version_id }

let make_version 
  ?(version_id:int64 option)
  ?(created_at:int64 option)
  ?(updated_at:int64 option)
  ?(updated_by:string option)
  ?(delta:document option)
  () : version  =
  let _res = default_version () in
  (match version_id with
  | None -> ()
  | Some v -> version_set_version_id _res v);
  (match created_at with
  | None -> ()
  | Some v -> version_set_created_at _res v);
  (match updated_at with
  | None -> ()
  | Some v -> version_set_updated_at _res v);
  (match updated_by with
  | None -> ()
  | Some v -> version_set_updated_by _res v);
  (match delta with
  | None -> ()
  | Some v -> version_set_delta _res v);
  _res

let[@inline] node_has_id (self:node) : bool = (Pbrt.Bitfield.get self._presence 0)
let[@inline] node_has_alias (self:node) : bool = (Pbrt.Bitfield.get self._presence 1)
let[@inline] node_has_properties (self:node) : bool = self.properties != None
let[@inline] node_has_created_at (self:node) : bool = (Pbrt.Bitfield.get self._presence 2)
let[@inline] node_has_updated_at (self:node) : bool = (Pbrt.Bitfield.get self._presence 3)
let[@inline] node_has_version (self:node) : bool = (Pbrt.Bitfield.get self._presence 4)
let[@inline] node_has_is_deleted (self:node) : bool = (Pbrt.Bitfield.get self._presence 5)
let[@inline] node_has_deleted_at (self:node) : bool = (Pbrt.Bitfield.get self._presence 6)

let[@inline] node_set_id (self:node) (x:int64) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 0); self.id <- x
let[@inline] node_set_alias (self:node) (x:string) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 1); self.alias <- x
let[@inline] node_set_labels (self:node) (x:label list) : unit =
  self.labels <- x
let[@inline] node_set_properties (self:node) (x:document) : unit =
  self.properties <- Some x
let[@inline] node_set_created_at (self:node) (x:int64) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 2); self.created_at <- x
let[@inline] node_set_updated_at (self:node) (x:int64) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 3); self.updated_at <- x
let[@inline] node_set_version (self:node) (x:int64) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 4); self.version <- x
let[@inline] node_set_history (self:node) (x:version list) : unit =
  self.history <- x
let[@inline] node_set_is_deleted (self:node) (x:bool) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 5); self.is_deleted <- x
let[@inline] node_set_deleted_at (self:node) (x:int64) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 6); self.deleted_at <- x
let[@inline] node_set_graph_names (self:node) (x:string list) : unit =
  self.graph_names <- x

let copy_node (self:node) : node =
  { self with id = self.id }

let make_node 
  ?(id:int64 option)
  ?(alias:string option)
  ?(labels=[])
  ?(properties:document option)
  ?(created_at:int64 option)
  ?(updated_at:int64 option)
  ?(version:int64 option)
  ?(history=[])
  ?(is_deleted:bool option)
  ?(deleted_at:int64 option)
  ?(graph_names=[])
  () : node  =
  let _res = default_node () in
  (match id with
  | None -> ()
  | Some v -> node_set_id _res v);
  (match alias with
  | None -> ()
  | Some v -> node_set_alias _res v);
  node_set_labels _res labels;
  (match properties with
  | None -> ()
  | Some v -> node_set_properties _res v);
  (match created_at with
  | None -> ()
  | Some v -> node_set_created_at _res v);
  (match updated_at with
  | None -> ()
  | Some v -> node_set_updated_at _res v);
  (match version with
  | None -> ()
  | Some v -> node_set_version _res v);
  node_set_history _res history;
  (match is_deleted with
  | None -> ()
  | Some v -> node_set_is_deleted _res v);
  (match deleted_at with
  | None -> ()
  | Some v -> node_set_deleted_at _res v);
  node_set_graph_names _res graph_names;
  _res

let[@inline] edge_has_id (self:edge) : bool = (Pbrt.Bitfield.get self._presence 0)
let[@inline] edge_has_alias (self:edge) : bool = (Pbrt.Bitfield.get self._presence 1)
let[@inline] edge_has_source (self:edge) : bool = (Pbrt.Bitfield.get self._presence 2)
let[@inline] edge_has_target (self:edge) : bool = (Pbrt.Bitfield.get self._presence 3)
let[@inline] edge_has_direction (self:edge) : bool = (Pbrt.Bitfield.get self._presence 4)
let[@inline] edge_has_properties (self:edge) : bool = self.properties != None
let[@inline] edge_has_created_at (self:edge) : bool = (Pbrt.Bitfield.get self._presence 5)
let[@inline] edge_has_updated_at (self:edge) : bool = (Pbrt.Bitfield.get self._presence 6)
let[@inline] edge_has_version (self:edge) : bool = (Pbrt.Bitfield.get self._presence 7)
let[@inline] edge_has_is_deleted (self:edge) : bool = (Pbrt.Bitfield.get self._presence 8)
let[@inline] edge_has_deleted_at (self:edge) : bool = (Pbrt.Bitfield.get self._presence 9)

let[@inline] edge_set_id (self:edge) (x:int64) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 0); self.id <- x
let[@inline] edge_set_alias (self:edge) (x:string) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 1); self.alias <- x
let[@inline] edge_set_source (self:edge) (x:int64) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 2); self.source <- x
let[@inline] edge_set_target (self:edge) (x:int64) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 3); self.target <- x
let[@inline] edge_set_direction (self:edge) (x:edge_direction) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 4); self.direction <- x
let[@inline] edge_set_labels (self:edge) (x:label list) : unit =
  self.labels <- x
let[@inline] edge_set_weights (self:edge) (x:weight list) : unit =
  self.weights <- x
let[@inline] edge_set_properties (self:edge) (x:document) : unit =
  self.properties <- Some x
let[@inline] edge_set_created_at (self:edge) (x:int64) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 5); self.created_at <- x
let[@inline] edge_set_updated_at (self:edge) (x:int64) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 6); self.updated_at <- x
let[@inline] edge_set_version (self:edge) (x:int64) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 7); self.version <- x
let[@inline] edge_set_history (self:edge) (x:version list) : unit =
  self.history <- x
let[@inline] edge_set_is_deleted (self:edge) (x:bool) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 8); self.is_deleted <- x
let[@inline] edge_set_deleted_at (self:edge) (x:int64) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 9); self.deleted_at <- x
let[@inline] edge_set_graph_names (self:edge) (x:string list) : unit =
  self.graph_names <- x

let copy_edge (self:edge) : edge =
  { self with id = self.id }

let make_edge 
  ?(id:int64 option)
  ?(alias:string option)
  ?(source:int64 option)
  ?(target:int64 option)
  ?(direction:edge_direction option)
  ?(labels=[])
  ?(weights=[])
  ?(properties:document option)
  ?(created_at:int64 option)
  ?(updated_at:int64 option)
  ?(version:int64 option)
  ?(history=[])
  ?(is_deleted:bool option)
  ?(deleted_at:int64 option)
  ?(graph_names=[])
  () : edge  =
  let _res = default_edge () in
  (match id with
  | None -> ()
  | Some v -> edge_set_id _res v);
  (match alias with
  | None -> ()
  | Some v -> edge_set_alias _res v);
  (match source with
  | None -> ()
  | Some v -> edge_set_source _res v);
  (match target with
  | None -> ()
  | Some v -> edge_set_target _res v);
  (match direction with
  | None -> ()
  | Some v -> edge_set_direction _res v);
  edge_set_labels _res labels;
  edge_set_weights _res weights;
  (match properties with
  | None -> ()
  | Some v -> edge_set_properties _res v);
  (match created_at with
  | None -> ()
  | Some v -> edge_set_created_at _res v);
  (match updated_at with
  | None -> ()
  | Some v -> edge_set_updated_at _res v);
  (match version with
  | None -> ()
  | Some v -> edge_set_version _res v);
  edge_set_history _res history;
  (match is_deleted with
  | None -> ()
  | Some v -> edge_set_is_deleted _res v);
  (match deleted_at with
  | None -> ()
  | Some v -> edge_set_deleted_at _res v);
  edge_set_graph_names _res graph_names;
  _res

let[@inline] graph_has_name (self:graph) : bool = (Pbrt.Bitfield.get self._presence 0)
let[@inline] graph_has_description (self:graph) : bool = (Pbrt.Bitfield.get self._presence 1)
let[@inline] graph_has_properties (self:graph) : bool = self.properties != None
let[@inline] graph_has_created_at (self:graph) : bool = (Pbrt.Bitfield.get self._presence 2)
let[@inline] graph_has_updated_at (self:graph) : bool = (Pbrt.Bitfield.get self._presence 3)
let[@inline] graph_has_is_deleted (self:graph) : bool = (Pbrt.Bitfield.get self._presence 4)
let[@inline] graph_has_deleted_at (self:graph) : bool = (Pbrt.Bitfield.get self._presence 5)
let[@inline] graph_has_node_count (self:graph) : bool = (Pbrt.Bitfield.get self._presence 6)
let[@inline] graph_has_edge_count (self:graph) : bool = (Pbrt.Bitfield.get self._presence 7)

let[@inline] graph_set_name (self:graph) (x:string) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 0); self.name <- x
let[@inline] graph_set_description (self:graph) (x:string) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 1); self.description <- x
let[@inline] graph_set_properties (self:graph) (x:document) : unit =
  self.properties <- Some x
let[@inline] graph_set_created_at (self:graph) (x:int64) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 2); self.created_at <- x
let[@inline] graph_set_updated_at (self:graph) (x:int64) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 3); self.updated_at <- x
let[@inline] graph_set_is_deleted (self:graph) (x:bool) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 4); self.is_deleted <- x
let[@inline] graph_set_deleted_at (self:graph) (x:int64) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 5); self.deleted_at <- x
let[@inline] graph_set_node_count (self:graph) (x:int64) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 6); self.node_count <- x
let[@inline] graph_set_edge_count (self:graph) (x:int64) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 7); self.edge_count <- x

let copy_graph (self:graph) : graph =
  { self with name = self.name }

let make_graph 
  ?(name:string option)
  ?(description:string option)
  ?(properties:document option)
  ?(created_at:int64 option)
  ?(updated_at:int64 option)
  ?(is_deleted:bool option)
  ?(deleted_at:int64 option)
  ?(node_count:int64 option)
  ?(edge_count:int64 option)
  () : graph  =
  let _res = default_graph () in
  (match name with
  | None -> ()
  | Some v -> graph_set_name _res v);
  (match description with
  | None -> ()
  | Some v -> graph_set_description _res v);
  (match properties with
  | None -> ()
  | Some v -> graph_set_properties _res v);
  (match created_at with
  | None -> ()
  | Some v -> graph_set_created_at _res v);
  (match updated_at with
  | None -> ()
  | Some v -> graph_set_updated_at _res v);
  (match is_deleted with
  | None -> ()
  | Some v -> graph_set_is_deleted _res v);
  (match deleted_at with
  | None -> ()
  | Some v -> graph_set_deleted_at _res v);
  (match node_count with
  | None -> ()
  | Some v -> graph_set_node_count _res v);
  (match edge_count with
  | None -> ()
  | Some v -> graph_set_edge_count _res v);
  _res

let[@inline] database_meta_has_name (self:database_meta) : bool = (Pbrt.Bitfield.get self._presence 0)
let[@inline] database_meta_has_version (self:database_meta) : bool = (Pbrt.Bitfield.get self._presence 1)
let[@inline] database_meta_has_created_at (self:database_meta) : bool = (Pbrt.Bitfield.get self._presence 2)
let[@inline] database_meta_has_page_size (self:database_meta) : bool = (Pbrt.Bitfield.get self._presence 3)
let[@inline] database_meta_has_page_count (self:database_meta) : bool = (Pbrt.Bitfield.get self._presence 4)
let[@inline] database_meta_has_schema_version (self:database_meta) : bool = (Pbrt.Bitfield.get self._presence 5)

let[@inline] database_meta_set_name (self:database_meta) (x:string) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 0); self.name <- x
let[@inline] database_meta_set_version (self:database_meta) (x:string) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 1); self.version <- x
let[@inline] database_meta_set_created_at (self:database_meta) (x:int64) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 2); self.created_at <- x
let[@inline] database_meta_set_page_size (self:database_meta) (x:int64) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 3); self.page_size <- x
let[@inline] database_meta_set_page_count (self:database_meta) (x:int64) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 4); self.page_count <- x
let[@inline] database_meta_set_graph_names (self:database_meta) (x:string list) : unit =
  self.graph_names <- x
let[@inline] database_meta_set_schema_version (self:database_meta) (x:int64) : unit =
  self._presence <- (Pbrt.Bitfield.set self._presence 5); self.schema_version <- x

let copy_database_meta (self:database_meta) : database_meta =
  { self with name = self.name }

let make_database_meta 
  ?(name:string option)
  ?(version:string option)
  ?(created_at:int64 option)
  ?(page_size:int64 option)
  ?(page_count:int64 option)
  ?(graph_names=[])
  ?(schema_version:int64 option)
  () : database_meta  =
  let _res = default_database_meta () in
  (match name with
  | None -> ()
  | Some v -> database_meta_set_name _res v);
  (match version with
  | None -> ()
  | Some v -> database_meta_set_version _res v);
  (match created_at with
  | None -> ()
  | Some v -> database_meta_set_created_at _res v);
  (match page_size with
  | None -> ()
  | Some v -> database_meta_set_page_size _res v);
  (match page_count with
  | None -> ()
  | Some v -> database_meta_set_page_count _res v);
  database_meta_set_graph_names _res graph_names;
  (match schema_version with
  | None -> ()
  | Some v -> database_meta_set_schema_version _res v);
  _res

[@@@ocaml.warning "-23-27-30-39"]

(** {2 Formatters} *)

let rec pp_value fmt (v:value) =
  match v with
  | Null_value x -> Format.fprintf fmt "@[<hv2>Null_value(@,%a)@]" Pbrt.Pp.pp_bool x
  | Bool_value x -> Format.fprintf fmt "@[<hv2>Bool_value(@,%a)@]" Pbrt.Pp.pp_bool x
  | Int_value x -> Format.fprintf fmt "@[<hv2>Int_value(@,%a)@]" Pbrt.Pp.pp_int64 x
  | Float_value x -> Format.fprintf fmt "@[<hv2>Float_value(@,%a)@]" Pbrt.Pp.pp_float x
  | String_value x -> Format.fprintf fmt "@[<hv2>String_value(@,%a)@]" Pbrt.Pp.pp_string x
  | Binary_value x -> Format.fprintf fmt "@[<hv2>Binary_value(@,%a)@]" Pbrt.Pp.pp_bytes x
  | Object_id x -> Format.fprintf fmt "@[<hv2>Object_id(@,%a)@]" Pbrt.Pp.pp_string x
  | Array_value x -> Format.fprintf fmt "@[<hv2>Array_value(@,%a)@]" pp_array_ x
  | Doc_value x -> Format.fprintf fmt "@[<hv2>Doc_value(@,%a)@]" pp_document x
  | Timestamp x -> Format.fprintf fmt "@[<hv2>Timestamp(@,%a)@]" Pbrt.Pp.pp_int64 x
  | Node_id x -> Format.fprintf fmt "@[<hv2>Node_id(@,%a)@]" Pbrt.Pp.pp_int64 x
  | Edge_id x -> Format.fprintf fmt "@[<hv2>Edge_id(@,%a)@]" Pbrt.Pp.pp_int64 x

and pp_array_ fmt (v:array_) = 
  let pp_i fmt () =
    Pbrt.Pp.pp_record_field ~first:true "values" (Pbrt.Pp.pp_list pp_value) fmt v.values;
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

and pp_document fmt (v:document) = 
  let pp_i fmt () =
    Pbrt.Pp.pp_record_field ~first:true "fields" (Pbrt.Pp.pp_associative_list Pbrt.Pp.pp_string pp_value) fmt v.fields;
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

let rec pp_label fmt (v:label) = 
  let pp_i fmt () =
    Pbrt.Pp.pp_record_field ~absent:(not (label_has_name v)) ~first:true "name" Pbrt.Pp.pp_string fmt v.name;
    Pbrt.Pp.pp_record_field ~first:false "parents" (Pbrt.Pp.pp_list Pbrt.Pp.pp_string) fmt v.parents;
    Pbrt.Pp.pp_record_field ~first:false "properties" (Pbrt.Pp.pp_option pp_document) fmt v.properties;
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

let rec pp_weight fmt (v:weight) = 
  let pp_i fmt () =
    Pbrt.Pp.pp_record_field ~absent:(not (weight_has_name v)) ~first:true "name" Pbrt.Pp.pp_string fmt v.name;
    Pbrt.Pp.pp_record_field ~absent:(not (weight_has_value v)) ~first:false "value" Pbrt.Pp.pp_float fmt v.value;
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

let rec pp_version fmt (v:version) = 
  let pp_i fmt () =
    Pbrt.Pp.pp_record_field ~absent:(not (version_has_version_id v)) ~first:true "version_id" Pbrt.Pp.pp_int64 fmt v.version_id;
    Pbrt.Pp.pp_record_field ~absent:(not (version_has_created_at v)) ~first:false "created_at" Pbrt.Pp.pp_int64 fmt v.created_at;
    Pbrt.Pp.pp_record_field ~absent:(not (version_has_updated_at v)) ~first:false "updated_at" Pbrt.Pp.pp_int64 fmt v.updated_at;
    Pbrt.Pp.pp_record_field ~absent:(not (version_has_updated_by v)) ~first:false "updated_by" Pbrt.Pp.pp_string fmt v.updated_by;
    Pbrt.Pp.pp_record_field ~first:false "delta" (Pbrt.Pp.pp_option pp_document) fmt v.delta;
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

let rec pp_node fmt (v:node) = 
  let pp_i fmt () =
    Pbrt.Pp.pp_record_field ~absent:(not (node_has_id v)) ~first:true "id" Pbrt.Pp.pp_int64 fmt v.id;
    Pbrt.Pp.pp_record_field ~absent:(not (node_has_alias v)) ~first:false "alias" Pbrt.Pp.pp_string fmt v.alias;
    Pbrt.Pp.pp_record_field ~first:false "labels" (Pbrt.Pp.pp_list pp_label) fmt v.labels;
    Pbrt.Pp.pp_record_field ~first:false "properties" (Pbrt.Pp.pp_option pp_document) fmt v.properties;
    Pbrt.Pp.pp_record_field ~absent:(not (node_has_created_at v)) ~first:false "created_at" Pbrt.Pp.pp_int64 fmt v.created_at;
    Pbrt.Pp.pp_record_field ~absent:(not (node_has_updated_at v)) ~first:false "updated_at" Pbrt.Pp.pp_int64 fmt v.updated_at;
    Pbrt.Pp.pp_record_field ~absent:(not (node_has_version v)) ~first:false "version" Pbrt.Pp.pp_int64 fmt v.version;
    Pbrt.Pp.pp_record_field ~first:false "history" (Pbrt.Pp.pp_list pp_version) fmt v.history;
    Pbrt.Pp.pp_record_field ~absent:(not (node_has_is_deleted v)) ~first:false "is_deleted" Pbrt.Pp.pp_bool fmt v.is_deleted;
    Pbrt.Pp.pp_record_field ~absent:(not (node_has_deleted_at v)) ~first:false "deleted_at" Pbrt.Pp.pp_int64 fmt v.deleted_at;
    Pbrt.Pp.pp_record_field ~first:false "graph_names" (Pbrt.Pp.pp_list Pbrt.Pp.pp_string) fmt v.graph_names;
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

let rec pp_edge_direction fmt (v:edge_direction) =
  match v with
  | Directed -> Format.fprintf fmt "Directed"
  | Undirected -> Format.fprintf fmt "Undirected"

let rec pp_edge fmt (v:edge) = 
  let pp_i fmt () =
    Pbrt.Pp.pp_record_field ~absent:(not (edge_has_id v)) ~first:true "id" Pbrt.Pp.pp_int64 fmt v.id;
    Pbrt.Pp.pp_record_field ~absent:(not (edge_has_alias v)) ~first:false "alias" Pbrt.Pp.pp_string fmt v.alias;
    Pbrt.Pp.pp_record_field ~absent:(not (edge_has_source v)) ~first:false "source" Pbrt.Pp.pp_int64 fmt v.source;
    Pbrt.Pp.pp_record_field ~absent:(not (edge_has_target v)) ~first:false "target" Pbrt.Pp.pp_int64 fmt v.target;
    Pbrt.Pp.pp_record_field ~absent:(not (edge_has_direction v)) ~first:false "direction" pp_edge_direction fmt v.direction;
    Pbrt.Pp.pp_record_field ~first:false "labels" (Pbrt.Pp.pp_list pp_label) fmt v.labels;
    Pbrt.Pp.pp_record_field ~first:false "weights" (Pbrt.Pp.pp_list pp_weight) fmt v.weights;
    Pbrt.Pp.pp_record_field ~first:false "properties" (Pbrt.Pp.pp_option pp_document) fmt v.properties;
    Pbrt.Pp.pp_record_field ~absent:(not (edge_has_created_at v)) ~first:false "created_at" Pbrt.Pp.pp_int64 fmt v.created_at;
    Pbrt.Pp.pp_record_field ~absent:(not (edge_has_updated_at v)) ~first:false "updated_at" Pbrt.Pp.pp_int64 fmt v.updated_at;
    Pbrt.Pp.pp_record_field ~absent:(not (edge_has_version v)) ~first:false "version" Pbrt.Pp.pp_int64 fmt v.version;
    Pbrt.Pp.pp_record_field ~first:false "history" (Pbrt.Pp.pp_list pp_version) fmt v.history;
    Pbrt.Pp.pp_record_field ~absent:(not (edge_has_is_deleted v)) ~first:false "is_deleted" Pbrt.Pp.pp_bool fmt v.is_deleted;
    Pbrt.Pp.pp_record_field ~absent:(not (edge_has_deleted_at v)) ~first:false "deleted_at" Pbrt.Pp.pp_int64 fmt v.deleted_at;
    Pbrt.Pp.pp_record_field ~first:false "graph_names" (Pbrt.Pp.pp_list Pbrt.Pp.pp_string) fmt v.graph_names;
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

let rec pp_graph fmt (v:graph) = 
  let pp_i fmt () =
    Pbrt.Pp.pp_record_field ~absent:(not (graph_has_name v)) ~first:true "name" Pbrt.Pp.pp_string fmt v.name;
    Pbrt.Pp.pp_record_field ~absent:(not (graph_has_description v)) ~first:false "description" Pbrt.Pp.pp_string fmt v.description;
    Pbrt.Pp.pp_record_field ~first:false "properties" (Pbrt.Pp.pp_option pp_document) fmt v.properties;
    Pbrt.Pp.pp_record_field ~absent:(not (graph_has_created_at v)) ~first:false "created_at" Pbrt.Pp.pp_int64 fmt v.created_at;
    Pbrt.Pp.pp_record_field ~absent:(not (graph_has_updated_at v)) ~first:false "updated_at" Pbrt.Pp.pp_int64 fmt v.updated_at;
    Pbrt.Pp.pp_record_field ~absent:(not (graph_has_is_deleted v)) ~first:false "is_deleted" Pbrt.Pp.pp_bool fmt v.is_deleted;
    Pbrt.Pp.pp_record_field ~absent:(not (graph_has_deleted_at v)) ~first:false "deleted_at" Pbrt.Pp.pp_int64 fmt v.deleted_at;
    Pbrt.Pp.pp_record_field ~absent:(not (graph_has_node_count v)) ~first:false "node_count" Pbrt.Pp.pp_int64 fmt v.node_count;
    Pbrt.Pp.pp_record_field ~absent:(not (graph_has_edge_count v)) ~first:false "edge_count" Pbrt.Pp.pp_int64 fmt v.edge_count;
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

let rec pp_database_meta fmt (v:database_meta) = 
  let pp_i fmt () =
    Pbrt.Pp.pp_record_field ~absent:(not (database_meta_has_name v)) ~first:true "name" Pbrt.Pp.pp_string fmt v.name;
    Pbrt.Pp.pp_record_field ~absent:(not (database_meta_has_version v)) ~first:false "version" Pbrt.Pp.pp_string fmt v.version;
    Pbrt.Pp.pp_record_field ~absent:(not (database_meta_has_created_at v)) ~first:false "created_at" Pbrt.Pp.pp_int64 fmt v.created_at;
    Pbrt.Pp.pp_record_field ~absent:(not (database_meta_has_page_size v)) ~first:false "page_size" Pbrt.Pp.pp_int64 fmt v.page_size;
    Pbrt.Pp.pp_record_field ~absent:(not (database_meta_has_page_count v)) ~first:false "page_count" Pbrt.Pp.pp_int64 fmt v.page_count;
    Pbrt.Pp.pp_record_field ~first:false "graph_names" (Pbrt.Pp.pp_list Pbrt.Pp.pp_string) fmt v.graph_names;
    Pbrt.Pp.pp_record_field ~absent:(not (database_meta_has_schema_version v)) ~first:false "schema_version" Pbrt.Pp.pp_int64 fmt v.schema_version;
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

[@@@ocaml.warning "-23-27-30-39"]

(** {2 Protobuf Encoding} *)

let rec encode_pb_value (v:value) encoder = 
  begin match v with
  | Null_value x ->
    Pbrt.Encoder.bool x encoder;
    Pbrt.Encoder.key 1 Pbrt.Varint encoder; 
  | Bool_value x ->
    Pbrt.Encoder.bool x encoder;
    Pbrt.Encoder.key 2 Pbrt.Varint encoder; 
  | Int_value x ->
    Pbrt.Encoder.int64_as_varint x encoder;
    Pbrt.Encoder.key 3 Pbrt.Varint encoder; 
  | Float_value x ->
    Pbrt.Encoder.float_as_bits64 x encoder;
    Pbrt.Encoder.key 4 Pbrt.Bits64 encoder; 
  | String_value x ->
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 5 Pbrt.Bytes encoder; 
  | Binary_value x ->
    Pbrt.Encoder.bytes x encoder;
    Pbrt.Encoder.key 6 Pbrt.Bytes encoder; 
  | Object_id x ->
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 7 Pbrt.Bytes encoder; 
  | Array_value x ->
    Pbrt.Encoder.nested encode_pb_array_ x encoder;
    Pbrt.Encoder.key 8 Pbrt.Bytes encoder; 
  | Doc_value x ->
    Pbrt.Encoder.nested encode_pb_document x encoder;
    Pbrt.Encoder.key 9 Pbrt.Bytes encoder; 
  | Timestamp x ->
    Pbrt.Encoder.int64_as_varint x encoder;
    Pbrt.Encoder.key 10 Pbrt.Varint encoder; 
  | Node_id x ->
    Pbrt.Encoder.int64_as_varint x encoder;
    Pbrt.Encoder.key 11 Pbrt.Varint encoder; 
  | Edge_id x ->
    Pbrt.Encoder.int64_as_varint x encoder;
    Pbrt.Encoder.key 12 Pbrt.Varint encoder; 
  end

and encode_pb_array_ (v:array_) encoder = 
  Pbrt.List_util.rev_iter_with (fun x encoder ->
    Pbrt.Encoder.nested encode_pb_value x encoder;
    Pbrt.Encoder.key 1 Pbrt.Bytes encoder; 
  ) v.values encoder;
  ()

and encode_pb_document (v:document) encoder = 
  let encode_key = Pbrt.Encoder.string in
  let encode_value = (fun x encoder ->
    Pbrt.Encoder.nested encode_pb_value x encoder;
  ) in
  Pbrt.List_util.rev_iter_with (fun (k, v) encoder ->
    let map_entry = (k, Pbrt.Bytes), (v, Pbrt.Bytes) in
    Pbrt.Encoder.map_entry ~encode_key ~encode_value map_entry encoder;
    Pbrt.Encoder.key 1 Pbrt.Bytes encoder; 
  ) v.fields encoder;
  ()

let rec encode_pb_label (v:label) encoder = 
  if label_has_name v then (
    Pbrt.Encoder.string v.name encoder;
    Pbrt.Encoder.key 1 Pbrt.Bytes encoder; 
  );
  Pbrt.List_util.rev_iter_with (fun x encoder ->
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 2 Pbrt.Bytes encoder; 
  ) v.parents encoder;
  begin match v.properties with
  | Some x -> 
    Pbrt.Encoder.nested encode_pb_document x encoder;
    Pbrt.Encoder.key 3 Pbrt.Bytes encoder; 
  | None -> ();
  end;
  ()

let rec encode_pb_weight (v:weight) encoder = 
  if weight_has_name v then (
    Pbrt.Encoder.string v.name encoder;
    Pbrt.Encoder.key 1 Pbrt.Bytes encoder; 
  );
  if weight_has_value v then (
    Pbrt.Encoder.float_as_bits64 v.value encoder;
    Pbrt.Encoder.key 2 Pbrt.Bits64 encoder; 
  );
  ()

let rec encode_pb_version (v:version) encoder = 
  if version_has_version_id v then (
    Pbrt.Encoder.int64_as_varint v.version_id encoder;
    Pbrt.Encoder.key 1 Pbrt.Varint encoder; 
  );
  if version_has_created_at v then (
    Pbrt.Encoder.int64_as_varint v.created_at encoder;
    Pbrt.Encoder.key 2 Pbrt.Varint encoder; 
  );
  if version_has_updated_at v then (
    Pbrt.Encoder.int64_as_varint v.updated_at encoder;
    Pbrt.Encoder.key 3 Pbrt.Varint encoder; 
  );
  if version_has_updated_by v then (
    Pbrt.Encoder.string v.updated_by encoder;
    Pbrt.Encoder.key 4 Pbrt.Bytes encoder; 
  );
  begin match v.delta with
  | Some x -> 
    Pbrt.Encoder.nested encode_pb_document x encoder;
    Pbrt.Encoder.key 5 Pbrt.Bytes encoder; 
  | None -> ();
  end;
  ()

let rec encode_pb_node (v:node) encoder = 
  if node_has_id v then (
    Pbrt.Encoder.int64_as_varint v.id encoder;
    Pbrt.Encoder.key 1 Pbrt.Varint encoder; 
  );
  if node_has_alias v then (
    Pbrt.Encoder.string v.alias encoder;
    Pbrt.Encoder.key 2 Pbrt.Bytes encoder; 
  );
  Pbrt.List_util.rev_iter_with (fun x encoder ->
    Pbrt.Encoder.nested encode_pb_label x encoder;
    Pbrt.Encoder.key 3 Pbrt.Bytes encoder; 
  ) v.labels encoder;
  begin match v.properties with
  | Some x -> 
    Pbrt.Encoder.nested encode_pb_document x encoder;
    Pbrt.Encoder.key 4 Pbrt.Bytes encoder; 
  | None -> ();
  end;
  if node_has_created_at v then (
    Pbrt.Encoder.int64_as_varint v.created_at encoder;
    Pbrt.Encoder.key 5 Pbrt.Varint encoder; 
  );
  if node_has_updated_at v then (
    Pbrt.Encoder.int64_as_varint v.updated_at encoder;
    Pbrt.Encoder.key 6 Pbrt.Varint encoder; 
  );
  if node_has_version v then (
    Pbrt.Encoder.int64_as_varint v.version encoder;
    Pbrt.Encoder.key 7 Pbrt.Varint encoder; 
  );
  Pbrt.List_util.rev_iter_with (fun x encoder ->
    Pbrt.Encoder.nested encode_pb_version x encoder;
    Pbrt.Encoder.key 8 Pbrt.Bytes encoder; 
  ) v.history encoder;
  if node_has_is_deleted v then (
    Pbrt.Encoder.bool v.is_deleted encoder;
    Pbrt.Encoder.key 9 Pbrt.Varint encoder; 
  );
  if node_has_deleted_at v then (
    Pbrt.Encoder.int64_as_varint v.deleted_at encoder;
    Pbrt.Encoder.key 10 Pbrt.Varint encoder; 
  );
  Pbrt.List_util.rev_iter_with (fun x encoder ->
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 11 Pbrt.Bytes encoder; 
  ) v.graph_names encoder;
  ()

let rec encode_pb_edge_direction (v:edge_direction) encoder =
  match v with
  | Directed -> Pbrt.Encoder.int_as_varint (0) encoder
  | Undirected -> Pbrt.Encoder.int_as_varint 1 encoder

let rec encode_pb_edge (v:edge) encoder = 
  if edge_has_id v then (
    Pbrt.Encoder.int64_as_varint v.id encoder;
    Pbrt.Encoder.key 1 Pbrt.Varint encoder; 
  );
  if edge_has_alias v then (
    Pbrt.Encoder.string v.alias encoder;
    Pbrt.Encoder.key 2 Pbrt.Bytes encoder; 
  );
  if edge_has_source v then (
    Pbrt.Encoder.int64_as_varint v.source encoder;
    Pbrt.Encoder.key 3 Pbrt.Varint encoder; 
  );
  if edge_has_target v then (
    Pbrt.Encoder.int64_as_varint v.target encoder;
    Pbrt.Encoder.key 4 Pbrt.Varint encoder; 
  );
  if edge_has_direction v then (
    encode_pb_edge_direction v.direction encoder;
    Pbrt.Encoder.key 5 Pbrt.Varint encoder; 
  );
  Pbrt.List_util.rev_iter_with (fun x encoder ->
    Pbrt.Encoder.nested encode_pb_label x encoder;
    Pbrt.Encoder.key 6 Pbrt.Bytes encoder; 
  ) v.labels encoder;
  Pbrt.List_util.rev_iter_with (fun x encoder ->
    Pbrt.Encoder.nested encode_pb_weight x encoder;
    Pbrt.Encoder.key 7 Pbrt.Bytes encoder; 
  ) v.weights encoder;
  begin match v.properties with
  | Some x -> 
    Pbrt.Encoder.nested encode_pb_document x encoder;
    Pbrt.Encoder.key 8 Pbrt.Bytes encoder; 
  | None -> ();
  end;
  if edge_has_created_at v then (
    Pbrt.Encoder.int64_as_varint v.created_at encoder;
    Pbrt.Encoder.key 9 Pbrt.Varint encoder; 
  );
  if edge_has_updated_at v then (
    Pbrt.Encoder.int64_as_varint v.updated_at encoder;
    Pbrt.Encoder.key 10 Pbrt.Varint encoder; 
  );
  if edge_has_version v then (
    Pbrt.Encoder.int64_as_varint v.version encoder;
    Pbrt.Encoder.key 11 Pbrt.Varint encoder; 
  );
  Pbrt.List_util.rev_iter_with (fun x encoder ->
    Pbrt.Encoder.nested encode_pb_version x encoder;
    Pbrt.Encoder.key 12 Pbrt.Bytes encoder; 
  ) v.history encoder;
  if edge_has_is_deleted v then (
    Pbrt.Encoder.bool v.is_deleted encoder;
    Pbrt.Encoder.key 13 Pbrt.Varint encoder; 
  );
  if edge_has_deleted_at v then (
    Pbrt.Encoder.int64_as_varint v.deleted_at encoder;
    Pbrt.Encoder.key 14 Pbrt.Varint encoder; 
  );
  Pbrt.List_util.rev_iter_with (fun x encoder ->
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 15 Pbrt.Bytes encoder; 
  ) v.graph_names encoder;
  ()

let rec encode_pb_graph (v:graph) encoder = 
  if graph_has_name v then (
    Pbrt.Encoder.string v.name encoder;
    Pbrt.Encoder.key 1 Pbrt.Bytes encoder; 
  );
  if graph_has_description v then (
    Pbrt.Encoder.string v.description encoder;
    Pbrt.Encoder.key 2 Pbrt.Bytes encoder; 
  );
  begin match v.properties with
  | Some x -> 
    Pbrt.Encoder.nested encode_pb_document x encoder;
    Pbrt.Encoder.key 3 Pbrt.Bytes encoder; 
  | None -> ();
  end;
  if graph_has_created_at v then (
    Pbrt.Encoder.int64_as_varint v.created_at encoder;
    Pbrt.Encoder.key 4 Pbrt.Varint encoder; 
  );
  if graph_has_updated_at v then (
    Pbrt.Encoder.int64_as_varint v.updated_at encoder;
    Pbrt.Encoder.key 5 Pbrt.Varint encoder; 
  );
  if graph_has_is_deleted v then (
    Pbrt.Encoder.bool v.is_deleted encoder;
    Pbrt.Encoder.key 6 Pbrt.Varint encoder; 
  );
  if graph_has_deleted_at v then (
    Pbrt.Encoder.int64_as_varint v.deleted_at encoder;
    Pbrt.Encoder.key 7 Pbrt.Varint encoder; 
  );
  if graph_has_node_count v then (
    Pbrt.Encoder.int64_as_varint v.node_count encoder;
    Pbrt.Encoder.key 8 Pbrt.Varint encoder; 
  );
  if graph_has_edge_count v then (
    Pbrt.Encoder.int64_as_varint v.edge_count encoder;
    Pbrt.Encoder.key 9 Pbrt.Varint encoder; 
  );
  ()

let rec encode_pb_database_meta (v:database_meta) encoder = 
  if database_meta_has_name v then (
    Pbrt.Encoder.string v.name encoder;
    Pbrt.Encoder.key 1 Pbrt.Bytes encoder; 
  );
  if database_meta_has_version v then (
    Pbrt.Encoder.string v.version encoder;
    Pbrt.Encoder.key 2 Pbrt.Bytes encoder; 
  );
  if database_meta_has_created_at v then (
    Pbrt.Encoder.int64_as_varint v.created_at encoder;
    Pbrt.Encoder.key 3 Pbrt.Varint encoder; 
  );
  if database_meta_has_page_size v then (
    Pbrt.Encoder.int64_as_varint v.page_size encoder;
    Pbrt.Encoder.key 4 Pbrt.Varint encoder; 
  );
  if database_meta_has_page_count v then (
    Pbrt.Encoder.int64_as_varint v.page_count encoder;
    Pbrt.Encoder.key 5 Pbrt.Varint encoder; 
  );
  Pbrt.List_util.rev_iter_with (fun x encoder ->
    Pbrt.Encoder.string x encoder;
    Pbrt.Encoder.key 6 Pbrt.Bytes encoder; 
  ) v.graph_names encoder;
  if database_meta_has_schema_version v then (
    Pbrt.Encoder.int64_as_varint v.schema_version encoder;
    Pbrt.Encoder.key 7 Pbrt.Varint encoder; 
  );
  ()

[@@@ocaml.warning "-23-27-30-39"]

(** {2 Protobuf Decoding} *)

let rec decode_pb_value d = 
  let rec loop () = 
    let ret:value = match Pbrt.Decoder.key d with
      | None -> Pbrt.Decoder.malformed_variant "value"
      | Some (1, _) -> (Null_value (Pbrt.Decoder.bool d) : value) 
      | Some (2, _) -> (Bool_value (Pbrt.Decoder.bool d) : value) 
      | Some (3, _) -> (Int_value (Pbrt.Decoder.int64_as_varint d) : value) 
      | Some (4, _) -> (Float_value (Pbrt.Decoder.float_as_bits64 d) : value) 
      | Some (5, _) -> (String_value (Pbrt.Decoder.string d) : value) 
      | Some (6, _) -> (Binary_value (Pbrt.Decoder.bytes d) : value) 
      | Some (7, _) -> (Object_id (Pbrt.Decoder.string d) : value) 
      | Some (8, _) -> (Array_value (decode_pb_array_ (Pbrt.Decoder.nested d)) : value) 
      | Some (9, _) -> (Doc_value (decode_pb_document (Pbrt.Decoder.nested d)) : value) 
      | Some (10, _) -> (Timestamp (Pbrt.Decoder.int64_as_varint d) : value) 
      | Some (11, _) -> (Node_id (Pbrt.Decoder.int64_as_varint d) : value) 
      | Some (12, _) -> (Edge_id (Pbrt.Decoder.int64_as_varint d) : value) 
      | Some (n, payload_kind) -> (
        Pbrt.Decoder.skip d payload_kind; 
        loop () 
      )
    in
    ret
  in
  loop ()

and decode_pb_array_ d =
  let v = default_array_ () in
  let continue__= ref true in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
      (* put lists in the correct order *)
      array__set_values v (List.rev v.values);
    ); continue__ := false
    | Some (1, Pbrt.Bytes) -> begin
      array__set_values v ((decode_pb_value (Pbrt.Decoder.nested d)) :: v.values);
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "array_" 1 pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  (v : array_)

and decode_pb_document d =
  let v = default_document () in
  let continue__= ref true in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
      (* put lists in the correct order *)
      document_set_fields v (List.rev v.fields);
    ); continue__ := false
    | Some (1, Pbrt.Bytes) -> begin
      let decode_value = (fun d ->
        decode_pb_value (Pbrt.Decoder.nested d)
      ) in
      document_set_fields v (
        (Pbrt.Decoder.map_entry d ~decode_key:Pbrt.Decoder.string ~decode_value)::v.fields;
      );
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "document" 1 pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  (v : document)

let rec decode_pb_label d =
  let v = default_label () in
  let continue__= ref true in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
      (* put lists in the correct order *)
      label_set_parents v (List.rev v.parents);
    ); continue__ := false
    | Some (1, Pbrt.Bytes) -> begin
      label_set_name v (Pbrt.Decoder.string d);
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "label" 1 pk
    | Some (2, Pbrt.Bytes) -> begin
      label_set_parents v ((Pbrt.Decoder.string d) :: v.parents);
    end
    | Some (2, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "label" 2 pk
    | Some (3, Pbrt.Bytes) -> begin
      label_set_properties v (decode_pb_document (Pbrt.Decoder.nested d));
    end
    | Some (3, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "label" 3 pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  (v : label)

let rec decode_pb_weight d =
  let v = default_weight () in
  let continue__= ref true in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
    ); continue__ := false
    | Some (1, Pbrt.Bytes) -> begin
      weight_set_name v (Pbrt.Decoder.string d);
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "weight" 1 pk
    | Some (2, Pbrt.Bits64) -> begin
      weight_set_value v (Pbrt.Decoder.float_as_bits64 d);
    end
    | Some (2, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "weight" 2 pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  (v : weight)

let rec decode_pb_version d =
  let v = default_version () in
  let continue__= ref true in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
    ); continue__ := false
    | Some (1, Pbrt.Varint) -> begin
      version_set_version_id v (Pbrt.Decoder.int64_as_varint d);
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "version" 1 pk
    | Some (2, Pbrt.Varint) -> begin
      version_set_created_at v (Pbrt.Decoder.int64_as_varint d);
    end
    | Some (2, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "version" 2 pk
    | Some (3, Pbrt.Varint) -> begin
      version_set_updated_at v (Pbrt.Decoder.int64_as_varint d);
    end
    | Some (3, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "version" 3 pk
    | Some (4, Pbrt.Bytes) -> begin
      version_set_updated_by v (Pbrt.Decoder.string d);
    end
    | Some (4, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "version" 4 pk
    | Some (5, Pbrt.Bytes) -> begin
      version_set_delta v (decode_pb_document (Pbrt.Decoder.nested d));
    end
    | Some (5, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "version" 5 pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  (v : version)

let rec decode_pb_node d =
  let v = default_node () in
  let continue__= ref true in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
      (* put lists in the correct order *)
      node_set_graph_names v (List.rev v.graph_names);
      node_set_history v (List.rev v.history);
      node_set_labels v (List.rev v.labels);
    ); continue__ := false
    | Some (1, Pbrt.Varint) -> begin
      node_set_id v (Pbrt.Decoder.int64_as_varint d);
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "node" 1 pk
    | Some (2, Pbrt.Bytes) -> begin
      node_set_alias v (Pbrt.Decoder.string d);
    end
    | Some (2, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "node" 2 pk
    | Some (3, Pbrt.Bytes) -> begin
      node_set_labels v ((decode_pb_label (Pbrt.Decoder.nested d)) :: v.labels);
    end
    | Some (3, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "node" 3 pk
    | Some (4, Pbrt.Bytes) -> begin
      node_set_properties v (decode_pb_document (Pbrt.Decoder.nested d));
    end
    | Some (4, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "node" 4 pk
    | Some (5, Pbrt.Varint) -> begin
      node_set_created_at v (Pbrt.Decoder.int64_as_varint d);
    end
    | Some (5, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "node" 5 pk
    | Some (6, Pbrt.Varint) -> begin
      node_set_updated_at v (Pbrt.Decoder.int64_as_varint d);
    end
    | Some (6, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "node" 6 pk
    | Some (7, Pbrt.Varint) -> begin
      node_set_version v (Pbrt.Decoder.int64_as_varint d);
    end
    | Some (7, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "node" 7 pk
    | Some (8, Pbrt.Bytes) -> begin
      node_set_history v ((decode_pb_version (Pbrt.Decoder.nested d)) :: v.history);
    end
    | Some (8, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "node" 8 pk
    | Some (9, Pbrt.Varint) -> begin
      node_set_is_deleted v (Pbrt.Decoder.bool d);
    end
    | Some (9, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "node" 9 pk
    | Some (10, Pbrt.Varint) -> begin
      node_set_deleted_at v (Pbrt.Decoder.int64_as_varint d);
    end
    | Some (10, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "node" 10 pk
    | Some (11, Pbrt.Bytes) -> begin
      node_set_graph_names v ((Pbrt.Decoder.string d) :: v.graph_names);
    end
    | Some (11, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "node" 11 pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  (v : node)

let rec decode_pb_edge_direction d : edge_direction = 
  match Pbrt.Decoder.int_as_varint d with
  | 0 -> Directed
  | 1 -> Undirected
  | _ -> Pbrt.Decoder.malformed_variant "edge_direction"

let rec decode_pb_edge d =
  let v = default_edge () in
  let continue__= ref true in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
      (* put lists in the correct order *)
      edge_set_graph_names v (List.rev v.graph_names);
      edge_set_history v (List.rev v.history);
      edge_set_weights v (List.rev v.weights);
      edge_set_labels v (List.rev v.labels);
    ); continue__ := false
    | Some (1, Pbrt.Varint) -> begin
      edge_set_id v (Pbrt.Decoder.int64_as_varint d);
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "edge" 1 pk
    | Some (2, Pbrt.Bytes) -> begin
      edge_set_alias v (Pbrt.Decoder.string d);
    end
    | Some (2, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "edge" 2 pk
    | Some (3, Pbrt.Varint) -> begin
      edge_set_source v (Pbrt.Decoder.int64_as_varint d);
    end
    | Some (3, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "edge" 3 pk
    | Some (4, Pbrt.Varint) -> begin
      edge_set_target v (Pbrt.Decoder.int64_as_varint d);
    end
    | Some (4, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "edge" 4 pk
    | Some (5, Pbrt.Varint) -> begin
      edge_set_direction v (decode_pb_edge_direction d);
    end
    | Some (5, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "edge" 5 pk
    | Some (6, Pbrt.Bytes) -> begin
      edge_set_labels v ((decode_pb_label (Pbrt.Decoder.nested d)) :: v.labels);
    end
    | Some (6, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "edge" 6 pk
    | Some (7, Pbrt.Bytes) -> begin
      edge_set_weights v ((decode_pb_weight (Pbrt.Decoder.nested d)) :: v.weights);
    end
    | Some (7, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "edge" 7 pk
    | Some (8, Pbrt.Bytes) -> begin
      edge_set_properties v (decode_pb_document (Pbrt.Decoder.nested d));
    end
    | Some (8, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "edge" 8 pk
    | Some (9, Pbrt.Varint) -> begin
      edge_set_created_at v (Pbrt.Decoder.int64_as_varint d);
    end
    | Some (9, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "edge" 9 pk
    | Some (10, Pbrt.Varint) -> begin
      edge_set_updated_at v (Pbrt.Decoder.int64_as_varint d);
    end
    | Some (10, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "edge" 10 pk
    | Some (11, Pbrt.Varint) -> begin
      edge_set_version v (Pbrt.Decoder.int64_as_varint d);
    end
    | Some (11, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "edge" 11 pk
    | Some (12, Pbrt.Bytes) -> begin
      edge_set_history v ((decode_pb_version (Pbrt.Decoder.nested d)) :: v.history);
    end
    | Some (12, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "edge" 12 pk
    | Some (13, Pbrt.Varint) -> begin
      edge_set_is_deleted v (Pbrt.Decoder.bool d);
    end
    | Some (13, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "edge" 13 pk
    | Some (14, Pbrt.Varint) -> begin
      edge_set_deleted_at v (Pbrt.Decoder.int64_as_varint d);
    end
    | Some (14, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "edge" 14 pk
    | Some (15, Pbrt.Bytes) -> begin
      edge_set_graph_names v ((Pbrt.Decoder.string d) :: v.graph_names);
    end
    | Some (15, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "edge" 15 pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  (v : edge)

let rec decode_pb_graph d =
  let v = default_graph () in
  let continue__= ref true in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
    ); continue__ := false
    | Some (1, Pbrt.Bytes) -> begin
      graph_set_name v (Pbrt.Decoder.string d);
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "graph" 1 pk
    | Some (2, Pbrt.Bytes) -> begin
      graph_set_description v (Pbrt.Decoder.string d);
    end
    | Some (2, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "graph" 2 pk
    | Some (3, Pbrt.Bytes) -> begin
      graph_set_properties v (decode_pb_document (Pbrt.Decoder.nested d));
    end
    | Some (3, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "graph" 3 pk
    | Some (4, Pbrt.Varint) -> begin
      graph_set_created_at v (Pbrt.Decoder.int64_as_varint d);
    end
    | Some (4, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "graph" 4 pk
    | Some (5, Pbrt.Varint) -> begin
      graph_set_updated_at v (Pbrt.Decoder.int64_as_varint d);
    end
    | Some (5, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "graph" 5 pk
    | Some (6, Pbrt.Varint) -> begin
      graph_set_is_deleted v (Pbrt.Decoder.bool d);
    end
    | Some (6, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "graph" 6 pk
    | Some (7, Pbrt.Varint) -> begin
      graph_set_deleted_at v (Pbrt.Decoder.int64_as_varint d);
    end
    | Some (7, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "graph" 7 pk
    | Some (8, Pbrt.Varint) -> begin
      graph_set_node_count v (Pbrt.Decoder.int64_as_varint d);
    end
    | Some (8, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "graph" 8 pk
    | Some (9, Pbrt.Varint) -> begin
      graph_set_edge_count v (Pbrt.Decoder.int64_as_varint d);
    end
    | Some (9, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "graph" 9 pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  (v : graph)

let rec decode_pb_database_meta d =
  let v = default_database_meta () in
  let continue__= ref true in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
      (* put lists in the correct order *)
      database_meta_set_graph_names v (List.rev v.graph_names);
    ); continue__ := false
    | Some (1, Pbrt.Bytes) -> begin
      database_meta_set_name v (Pbrt.Decoder.string d);
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "database_meta" 1 pk
    | Some (2, Pbrt.Bytes) -> begin
      database_meta_set_version v (Pbrt.Decoder.string d);
    end
    | Some (2, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "database_meta" 2 pk
    | Some (3, Pbrt.Varint) -> begin
      database_meta_set_created_at v (Pbrt.Decoder.int64_as_varint d);
    end
    | Some (3, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "database_meta" 3 pk
    | Some (4, Pbrt.Varint) -> begin
      database_meta_set_page_size v (Pbrt.Decoder.int64_as_varint d);
    end
    | Some (4, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "database_meta" 4 pk
    | Some (5, Pbrt.Varint) -> begin
      database_meta_set_page_count v (Pbrt.Decoder.int64_as_varint d);
    end
    | Some (5, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "database_meta" 5 pk
    | Some (6, Pbrt.Bytes) -> begin
      database_meta_set_graph_names v ((Pbrt.Decoder.string d) :: v.graph_names);
    end
    | Some (6, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "database_meta" 6 pk
    | Some (7, Pbrt.Varint) -> begin
      database_meta_set_schema_version v (Pbrt.Decoder.int64_as_varint d);
    end
    | Some (7, pk) -> 
      Pbrt.Decoder.unexpected_payload_message "database_meta" 7 pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  (v : database_meta)
