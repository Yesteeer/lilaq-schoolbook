#import "../lib.typ": *
#import "@preview/lilaq:0.6.0" as lq

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
      start: (-6, -1.5),
      end: (5.8, 1.5),
      scale: 1.2,
      offset: (0, 0.3),
      labels: ($x$, $y$),
      add-to-xaxis: (
        tick-distance: 1/ 2,
        locate-ticks: lq.tick-locate.linear.with(unit: calc.pi),
        format-ticks: lq.tick-format.fraction.with(suffix: $pi$),
      ),
      plot(x => calc.sin(x), start: -6.5, end: 6.5, label: $sin(x)$),
      plot(x => calc.cos(x), start: -6.5, end: 6.5, label: $cos(x)$),
    )
  ],
  [
    #diagram(
      start: (-6, -1.5),
      end: (5.8, 1.5),
      scale: 1.2,
      offset: (0, 0.3),
      labels: ($x$, $y$),
      add-to-xaxis: (
        tick-distance: 1/ 2,
        locate-ticks: lq.tick-locate.linear.with(unit: calc.pi),
        format-ticks: lq.tick-format.fraction.with(suffix: $pi$),
      ),
      plot(x => calc.sin(x), start: -6.5, end: 6.5, label: $sin(x)$),
      plot(x => calc.cos(x), start: -6.5, end: 6.5, label: $cos(x)$),
    )
  ]
)
