(** This module implements a trampoline for deeply recursive functions,
 most useful for the bytecode interpreter and JavaScript targets. *)

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

(** This is a real trampoline implementation. *)
module Trampoline : Trampoline

(** If you don't want to use trampolines because you're sure that your stack
 is large enough but you have a functor that depends on the Trampoline module then
 you can use Not_a_trampoline to use the stack instead of trampolines. *)
module Not_a_trampoline : Trampoline
