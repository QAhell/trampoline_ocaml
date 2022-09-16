open Trampoline
open Trampoline

let up_to m n =
  let rec up m n acc =
    if m > n then []
    else up m (n - 1) (n :: acc) in
  up m n []

let rec fold_right f xs acc =
  match xs with
    | [] -> return acc
    | x :: xs -> map (f x) (suspend (fun () -> fold_right f xs acc))

let long_list = up_to 0 9999999 ;;

assert (execute (fold_right (+) long_list 0) = List.fold_left (+) 0 long_list) ;;
