module type Trampoline =
sig
  type 'a t
  val execute : 'a t -> 'a
  val return : 'a -> 'a t
  val suspend : (unit -> 'a t) -> 'a t
  val recursive_call : ('a -> 'b t) -> 'a -> 'b t
  val bind : 'a t -> ('a -> 'b t) -> 'b t
  val map : ('a -> 'b) -> 'a t -> 'b t
end

module Trampoline : Trampoline =
struct
  type 'a trampoline =
    | Result  :                                    'a -> 'a trampoline
    | Suspend :               (unit -> 'a trampoline) -> 'a trampoline
    | Bind    : 'a trampoline * ('a -> 'b trampoline) -> 'b trampoline
  type 'a t = 'a trampoline

  type ('a, 'b) continuation =
    | Id      : ('a, 'a) continuation
    | Compose : ('c, 'b) continuation * ('a -> 'c trampoline) -> ('a, 'b) continuation

  let execute trampoline =
    let rec exec : type a b. a trampoline -> (a, b) continuation -> b =
      fun trampoline continuation ->
        match (trampoline, continuation) with
          | (Result result, Id) ->
              result
          | (Result result, Compose (continuation, f)) ->
              exec (f result) continuation
          | (Suspend closure, continuation) ->
              exec (closure ()) continuation
          | (Bind (x, f), continuation) ->
              exec x (Compose (continuation, f)) in
    exec trampoline Id

  let return x = Result x

  let suspend f = Suspend f

  let recursive_call f x = Suspend (fun () -> f x)

  let bind x f = Bind (x, f)

  let map f x = bind x (fun x -> return (f x))

end
