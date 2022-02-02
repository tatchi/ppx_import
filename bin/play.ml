(* module type Hashable = [%import: (module Hashtbl.HashedType)] [@@deriving show]

   [%%import: module type Hashable2 = Hashtbl.HashedType [@@deriving show]]

   module type%import Hashable3 = Hashtbl.HashedType [@@deriving show] *)

(* module type S_optional = [%import: (module Stuff.S_optional)]

   [%%import: module type S_optional2 = Stuff.S_optional]

   module type%import S_optional3 = Stuff.S_optional *)

(*
   module type S = [%import: (module Play_self_import.S)]


   [%%import: module type S2 = Play_self_import.S] *)

(* Types *)

(* type a = [%import: Stuff.a][@@deriving show]

   [%%import : type a2 = Stuff.a [@@deriving show]]


   type%import a3 = Stuff.a[@@deriving show] *)

(* type a = [%import: Stuff.a]
   [%%import: type a2 = Stuff.a]
   type b = [%import: Stuff.b]
   [%%import: type b2 = Stuff.b]
   type c = [%import: Stuff.c]
   [%%import: type c2 = Stuff.c]
   type d = [%import: Stuff.d]
   [%%import: type d2 = Stuff.d]
   type e = [%import: Stuff.e]
   [%%import: type e2 = Stuff.e]
   type f = [%import: Stuff.S.f]
   [%%import: type f2 = Stuff.S.f]
   type 'a g = [%import: 'a Stuff.g]
   [%%import: type 'a g2 = 'a Stuff.g]
   type 'b g' = [%import: 'b Stuff.g]
   [%%import: type 'b g2' = 'b Stuff.g]
   type h = [%import: Stuff.h]
   [%%import: type h2 = Stuff.h] *)

(* module MI = Stuff.MI

   type i = [%import: Stuff.i]
   [%%import: type i2 = Stuff.i] *)

type package_type =
  [%import:
    (Parsetree.package_type
    [@with
      core_type := (Parsetree.core_type [@printer Pprintast.core_type]);
      Asttypes.loc :=
        (Asttypes.loc [@polyprinter fun pp fmt x -> pp fmt x.Asttypes.txt]);
      Longident.t := (Longident.t [@printer pp_longident])] )]
[@@deriving show]

[%%import:
type package_type2 =
  (Parsetree.package_type
  [@with
    core_type := (Parsetree.core_type [@printer Pprintast.core_type]);
    Asttypes.loc :=
      (Asttypes.loc [@polyprinter fun pp fmt x -> pp fmt x.Asttypes.txt]);
    Longident.t := (Longident.t [@printer pp_longident])] )
[@@deriving show]]
