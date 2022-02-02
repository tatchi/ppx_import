module MI = struct
  type i = int

  let pp () = Stdlib.print_endline "cool"
end

module type S_optional = sig
  val f : ?opt:int -> unit -> unit
end
