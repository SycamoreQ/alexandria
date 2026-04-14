let () =
  (* 1. compare_value ordering *)
  assert (Types.compare_value Types.Null (Types.Bool true) < 0);
  assert (Types.compare_value (Types.Int 1L) (Types.Int 2L) < 0);
  assert (Types.compare_value (Types.Int 5L) (Types.Int 5L) = 0);
  assert (Types.compare_value (Types.String "a") (Types.String "b") < 0);
  assert (Types.compare_value (Types.Float 1.0) (Types.Float 2.0) < 0);
  assert (Types.compare_value Types.Null (Types.Int 1L) < 0);
  assert (Types.compare_value (Types.Int 1L) Types.Null > 0);

  (* 2. equal_value *)
  assert (Types.equal_value Types.Null Types.Null = true);
  assert (Types.equal_value (Types.Int 1L) (Types.Int 2L) = false);
  assert (Types.equal_value (Types.String "hi") (Types.String "hi") = true);
  assert (Types.equal_value (Types.Bool true) (Types.Bool false) = false);

  (* 3. document_get / document_set *)
  let d = Types.StringMap.empty in
  let d = Types.document_set d "x" (Types.Int 1L) in
  assert (Types.document_get d "x" = Some (Types.Int 1L));
  assert (Types.document_get d "y" = None);
  let d = Types.document_set d "x" (Types.Int 99L) in
  assert (Types.document_get d "x" = Some (Types.Int 99L));
  let d = Types.document_set d "z" (Types.Bool true) in
  assert (Types.document_get d "z" = Some (Types.Bool true));

  (* 4. type_name *)
  assert (Types.type_name Types.Null = "null");
  assert (Types.type_name (Types.Bool true) = "bool");
  assert (Types.type_name (Types.Int 1L) = "int");
  assert (Types.type_name (Types.Array []) = "array");
  assert (Types.type_name (Types.Document Types.StringMap.empty) = "document");
  assert (Types.type_name (Types.NodeId 1L) = "nodeid");
  assert (Types.type_name (Types.EdgeId 1L) = "edgeid");

  (* 5. is_null *)
  assert (Types.is_null Types.Null = true);
  assert (Types.is_null (Types.Bool false) = false);
  assert (Types.is_null (Types.Int 0L) = false);

  (* 6. Array comparison *)
  let a1 = Types.Array [Types.Int 1L; Types.Int 2L] in
  let a2 = Types.Array [Types.Int 1L; Types.Int 3L] in
  assert (Types.compare_value a1 a2 < 0);

  (* 7. Document comparison *)
  let doc1 = Types.document_set Types.StringMap.empty "a" (Types.Int 1L) in
  let doc2 = Types.document_set Types.String
