;; extends

[
  ; prevent double indent for `return new class ...`
  (return_statement
    (object_creation_expression))
] @indent.dedent
