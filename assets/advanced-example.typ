#import "../lib.typ": *
#import "@preview/lilaq:0.6.0" as lq

#set page(height: auto, margin: 1cm, width: auto)

// set vertical spacing between the two functions' legends 
#show lq.selector(lq.legend): set grid(row-gutter: 5pt)

// set a custom grid styling
#show: lq.set-grid(
  stroke: (paint: luma(150), dash: "dotted", thickness: .5pt),
)

#plot(
  // set bottom-left limit coordinates
  start: (-6, -1.5),
  // set top-right limit coordinates
  end: (5.8, 1.5),
  // scale the axes' tick-distance
  scale: 1.2,
  // add axes' offset
  offset: (0, 0.3),
  // add labels to axes
  labels: ($x$, $y$),
  // add/update some arguments to pass to the xaxis() function
  add-to-xaxis: (
    tick-distance: 1/ 2,

    // sets horizontal ticks to follow multiples of pi
    locate-ticks: lq.tick-locate.linear.with(unit: calc.pi),

    // define custom tick label format
    format-ticks: lq.tick-format.fraction.with(suffix: $pi$),
  ),

  // place the legends box
  legend: (position: top + right, dy: -15pt),
    
  // add functions to the plot
  add-func(x => calc.sin(x), start: -6.5, end: 6.5, label: lq.label($sin(x)$, dy: 2cm)),
  add-func(x => calc.cos(x), start: -6.5, end: 6.5, label: $cos(x)$),
)

