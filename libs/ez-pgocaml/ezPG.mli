
val connect :
  ?host:string ->
  ?port:int ->
  ?user:string ->
  ?password:string ->
  string -> 'a PGOCaml.t

val close : 'a PGOCaml.t -> unit

val exec :
  ?verbose:bool -> (* print commands, true by default *)
  'a PGOCaml.t -> (* database handler *)
  ?callback: (* function called with results, None = error *)
    (string list list option -> unit) ->
  string -> (* Query *)
  unit

val execs : (* same as exec, but with a list of queries *)
  ?verbose:bool ->
  'a PGOCaml.t ->
  string list ->
  unit

val update :
  ?verbose:bool -> (* print commands, false by default *)
  versions: (* migration scripts *)
    (int * ('a PGOCaml.t -> unit)) list ->
  ?target:int -> (* target version *)
  ?witness:string -> (* a file modified if the db is modified *)
  'a PGOCaml.t -> (* database handler *)
  unit

val touch_witness : ?witness:string -> int -> unit
val init_version0 : 'a PGOCaml.t -> unit

(* Useful functions to create the initial database *)
val createdb : ?verbose:bool -> string -> unit
val dropdb : ?verbose:bool -> string -> unit

val begin_tr : 'a PGOCaml.t -> unit
val end_tr : 'a PGOCaml.t -> unit
val abort_tr : 'a PGOCaml.t -> unit

val in_tr : 'a PGOCaml.t -> ('a PGOCaml.t -> 'b) -> unit
