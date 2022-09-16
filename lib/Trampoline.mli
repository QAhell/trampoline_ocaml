(** The type of a trampoline that doesn't use the stack for recursive computation. *)
module type Trampoline =
sig
  (** The type of the trampoline, e g the return type of tail-recursive functions. *)
  type 'a t

  (** Performs all suspended computations. *)
  val execute : 'a t -> 'a

  (** Turns a literal value into a trampoline. *)
  val return : 'a -> 'a t

  (** Delays the computation of a result. *)
  val suspend : (unit -> 'a t) -> 'a t

  (** Convenience function for recursive calls with one argument. *)
  val recursive_call : ('a -> 'b t) -> 'a -> 'b t

  (** Accesses values from suspended computations
    to create new suspended computations. *)
  val bind : 'a t -> ('a -> 'b t) -> 'b t

  (** Convenience function so you don't have to use bind
    when you want to have a simple map. *)
  val map : ('a -> 'b) -> 'a t -> 'b t
end

module Trampoline : Trampoline
