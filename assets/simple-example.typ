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
    #diagram(
      scale: 2,
      labels: ($x$, $y$),
      plot(x => calc.pow(x, 2), label: $f(x) = x^2$),
    )
  ],
  [
    #diagram(
      scale: 2,
      labels: ($x$, $y$),
      plot(x => calc.pow(x, 2), label: $f(x) = x^2$),
    )
  ],
)
