open Base
open Dunedb
module T = Types

let () =
  (* 1. compare_value ordering *)
  assert (Dunedb.Types.compare_value Dunedb.Types.Null (Dunedb.Types.Bool true) < 0);
  assert (Dunedb.Types.compare_value (Dunedb.Types.Int 1L) (Dunedb.Types.Int 2L) < 0);
  assert (Dunedb.Types.compare_value (Dunedb.Types.Int 5L) (Dunedb.Types.Int 5L) = 0);
  assert (Dunedb.Types.compare_value (Dunedb.Types.String "a") (Dunedb.Types.String "b") < 0);
  assert (Dunedb.Types.compare_value (Dunedb.Types.Float 1.0) (Dunedb.Types.Float 2.0) < 0);
  assert (Dunedb.Types.compare_value Dunedb.Types.Null (Dunedb.Types.Int 1L) < 0);
  assert (Dunedb.Types.compare_value (Dunedb.Types.Int 1L) Dunedb.Types.Null > 0);

  (* 2. equal_value *)
  assert (Dunedb.Types.equal_value Dunedb.Types.Null Dunedb.Types.Null = true);
  assert (Dunedb.Types.equal_value (Dunedb.Types.Int 1L) (Dunedb.Types.Int 2L) = false);
  assert (Dunedb.Types.equal_value (Dunedb.Types.String "hi") (Dunedb.Types.String "hi") = true);
  assert (Dunedb.Types.equal_value (Dunedb.Types.Bool true) (Dunedb.Types.Bool false) = false);

  (* 3. document_get / document_set *)
  let d = Dunedb.Types.StringMap.empty in
  let d = Dunedb.Types.document_set d "x" (Dunedb.Types.Int 1L) in
  assert (Dunedb.Types.document_get d "x" = Some (Dunedb.Types.Int 1L));
  assert (Dunedb.Types.document_get d "y" = None);
  let d = Dunedb.Types.document_set d "x" (Dunedb.Types.Int 99L) in
  assert (Dunedb.Types.document_get d "x" = Some (Dunedb.Types.Int 99L));
  let d = Dunedb.Types.document_set d "z" (Dunedb.Types.Bool true) in
  assert (Dunedb.Types.document_get d "z" = Some (Dunedb.Types.Bool true));

  (* 4. type_name *)
  assert (Dunedb.Types.type_name Dunedb.Types.Null = "null");
  assert (Dunedb.Types.type_name (Dunedb.Types.Bool true) = "bool");
  assert (Dunedb.Types.type_name (Dunedb.Types.Int 1L) = "int");
  assert (Dunedb.Types.type_name (Dunedb.Types.Array []) = "array");
  assert (Dunedb.Types.type_name (Dunedb.Types.Document Dunedb.Types.StringMap.empty) = "document");
  assert (Dunedb.Types.type_name (Dunedb.Types.NodeId 1L) = "nodeid");
  assert (Dunedb.Types.type_name (Dunedb.Types.EdgeId 1L) = "edgeid");

  (* 5. is_null *)
  assert (Dunedb.Types.is_null Dunedb.Types.Null = true);
  assert (Dunedb.Types.is_null (Dunedb.Types.Bool false) = false);
  assert (Dunedb.Types.is_null (Dunedb.Types.Int 0L) = false);

  (* 6. Array comparison *)
  let a1 = Dunedb.Types.Array [Dunedb.Types.Int 1L; Dunedb.Types.Int 2L] in
  let a2 = Dunedb.Types.Array [Dunedb.Types.Int 1L; Dunedb.Types.Int 3L] in
  assert (Dunedb.Types.compare_value a1 a2 < 0);

  (* 7. Document comparison *)
  let doc1 = Dunedb.Types.document_set Dunedb.Types.StringMap.empty "a" (Dunedb.Types.Int 1L) in
  let doc2 = Dunedb.Types.document_set Dunedb.Types.StringMap.empty "a" (Dunedb.Types.Int 2L) in
  assert (Dunedb.Types.compare_value (Dunedb.Types.Document doc1) (Dunedb.Types.Document doc2) < 0);

  Stdio.printf "All types tests passed!\n"
