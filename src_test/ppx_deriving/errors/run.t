  $ cat >dune-project <<EOF
  > (lang dune 3.0)
  > EOF
  $ cat >dune <<EOF
  > (library
  >  (name test)
  >  (preprocess
  >   (staged_pps ppx_import)))
  > EOF

Functor error
  $ cat >test.ml <<EOF
  > [%%import: type t =  Map.Make(String).t]
  > EOF

  $ dune build 2>&1 | sed 's/\(Command line: \).*/\1Error/'
  File ".test.objs/byte/_unknown_", line 1, characters 0-0:
  Fatal error: exception Invalid_argument("Ppxlib.Longident.flatten")
  File "test.ml", line 1:
  Error: Error while running external preprocessor
  Command line: Error
  
Parameters error
  $ cat >test.ml <<EOF
  > [%%import: type t =  List.t]
  > EOF

  $ dune build
  File "test.ml", line 1, characters 21-27:
  1 | [%%import: type t =  List.t]
                           ^^^^^^
  Error: Imported type has 1 parameter(s), but 0 are passed
  [1]

Abstract module error
  $ cat >stuff.ml <<EOF
  > module type T
  > EOF

  $ cat >test.ml <<EOF
  > module type T = [%import: (module Stuff.T)]
  > EOF

  $ dune build
  File "test.ml", line 1, characters 34-41:
  1 | module type T = [%import: (module Stuff.T)]
                                        ^^^^^^^
  Error: Imported module is abstract
  [1]

With error
  $ cat >test.ml <<EOF
  > [%%import: type p = (String.t[@with])]
  > EOF

  $ dune build
  File "test.ml", line 1, characters 21-29:
  1 | [%%import: type p = (String.t[@with])]
                           ^^^^^^^^
  Error: Invalid [@with] syntax
  [1]

Cannot find signature error
  $ cat >test.ml <<EOF
  > [%%import: type t =  Map.K.t]
  > EOF

  $ dune build
  File "test.ml", line 1, characters 21-28:
  1 | [%%import: type t =  Map.K.t]
                           ^^^^^^^
  Error: [%import]: cannot find the signature of K in Map
  [1]

Cannot find component error
  $ cat >test.ml <<EOF
  > [%%import: type t =  Map.Make.t]
  > EOF

  $ dune build
  File "test.ml", line 1, characters 21-31:
  1 | [%%import: type t =  Map.Make.t]
                           ^^^^^^^^^^
  Error: [%import]: cannot find the components of Map.Make
  [1]

Cannot find module error
  $ cat >stuff.ml <<EOF
  > module type S = sig
  >  module M: sig end
  > end
  > EOF

  $ cat >test.ml <<EOF
  > module type A = [%import: (module Stuff.S.M)]
  > EOF

  $ dune build
  File "_none_", line 1:
  Error: [%import]: cannot find the module type M in Stuff.S
  [1]

Multiple signature items
  $ cat >test.ml <<EOF
  > [%%import:
  > type b = int
  > type a = string]
  > EOF

  $ dune build
  File "test.ml", lines 1-3, characters 0-16:
  1 | [%%import:
  2 | type b = int
  3 | type a = string]
  Error: [] expected
  [1]
