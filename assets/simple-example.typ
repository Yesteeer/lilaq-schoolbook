#import "../lib.typ": *

#set page(height: auto, margin: 1cm, width: auto)

#plot(
  // scale the axes' tick-distance
  scale: (3, 2),
  // add labels to axes
  labels: ($x$, $y$),
  // add a function to the plot
  add-func(x => calc.pow(x, 2), label: $f(x) = x^2$),
  // show the origin
  show-origin: true,
)
