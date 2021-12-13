type module_type_407 =
  | Mty_ident of Path.t
  | Mty_signature of Types.signature
  | Mty_functor of Ident.t * Types.module_type option * Types.module_type
  | Mty_alias of unit * Path.t

let migrate_module_type : Types.module_type -> module_type_407 = function
  | Mty_ident p -> Mty_ident p
  | Mty_signature s -> Mty_signature s
  | Mty_functor (fp, mt) -> (
    match fp with
    | Unit -> Mty_functor (Ident.create_local "_", None, mt)
    | Named (i, mt) ->
      let i = match i with None -> Ident.create_local "_" | Some i -> i in
      Mty_functor (i, Some mt, mt) )
  | Mty_alias p -> Mty_alias ((), p)


type ('lbl, 'cstr) type_kind_407 = 
  | Type_abstract
  | Type_record of 'lbl list * Types.record_representation
  | Type_variant of 'cstr list
  | Type_open

let migrate_type_kind : ('lbl, 'cstr) Types.type_kind -> ('lbl, 'cstr) type_kind_407 = function
  | Type_abstract -> Type_abstract
  | Type_record (lbl, repr) -> Type_record (lbl, repr)
  | Type_variant (cstr, _) -> Type_variant cstr
  | Type_open -> Type_open
