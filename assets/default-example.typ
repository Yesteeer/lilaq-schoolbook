#import "../lib.typ": *

#set page(height: auto, margin: 1cm, width: auto)

#grid(
  columns: 2,
  align: center + horizon,
  column-gutter: 5em,
  inset: 10pt,
  [*with* lilaq-schoolbook theme],
  [*without* lilaq-schoolbook theme],
  [
    #show: lilaq-schoolbook
    #diagram()
  ],
  [#diagram()],
)
