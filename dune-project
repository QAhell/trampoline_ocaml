(lang dune 3.4)

(name trampoline)

(generate_opam_files true)

(source
 (github QAhell/trampoline_ocaml))

(authors "Armin Heller <support@arminheller.de>")

(maintainers "Armin Heller <support@arminheller.de>")

(license "Apache-2.0")

(package
 (name trampoline)
 (version 0.1.0)
 (synopsis "A trampoline library enabling deep recursions that don't fit into stack memory")
 (description "Using this library you can perform deep recursion that is not limitied by the stack but only by the size of the available random access memory (RAM). In OCaml the number of nested recursive calls that are not tail-calls is limited by the stack. The stack usually consists of a fraction of the RAM available to the OCaml program. The difference between stack and RAM can be important for compilation targets where the default stack size is rather small, e. g. OCaml bytecode or JavaScript. The trampoline library provides a trampoline monad and a few convenience functions.")
 (depends ocaml dune)
 (tags (topics trampoline)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
