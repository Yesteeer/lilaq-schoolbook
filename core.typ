#import "@preview/lilaq:0.6.0" as lq
#import "@preview/zero:0.6.1" as zero
#import "@preview/tiptoe:0.4.0" as tiptoe
#import "@preview/elembic:1.1.1" as e

#let to-ntuple(arg, n: 2) = {
  if type(arg) != array or arg == none {
    return (arg,)*n
  }
  else {
    return arg
  }
}

#let sf-formatter(ticks, text-size: 1em, math: false, ..args) = {
  let result = lq.tick-format.linear(ticks, ..args)
  ticks.zip(result.labels).map(((tick, label)) => {
    zero.set-num(math: math)
    text(text-size)[#label]
  })
}

#let diagram-axis-defaults(tick-distance: 1, subticks: 0, ..args) = {
  return (
    tick-distance: tick-distance, 
    subticks: subticks, 
  ) + args.named()
}

#let diagram(
  ..body,
  start: (0, 0),
  end: (2, 2),
  offset: (-0.3, 0.3),
  scale: 1,
  tick-distance: 1,
  subticks: 0,
  add-to-xaxis: none,
  add-to-yaxis: none,
  labels: none,
) = {
  let (xlim, ylim) = to-ntuple(start).zip(to-ntuple(end))

  let (offset, scale, tick-distance, subticks) = (offset, scale, tick-distance, subticks).map(to-ntuple)

  let (width, height) = lq.vec.add(lq.vec.subtract(..(end, start).map(to-ntuple)), (offset.at(1)-offset.at(0),)*2)

  let new-add-to-xaxis = if add-to-xaxis == none {(:)} else {add-to-xaxis}
  let new-add-to-yaxis = if add-to-yaxis == none {(:)} else {add-to-yaxis}

  lq.diagram(
    width: width*scale.at(0)*1cm, 
    height: height*scale.at(1)*1cm,
    xlim: lq.vec.add(xlim, offset), 
    ylim: lq.vec.add(ylim, offset),
    xlabel: if labels != none {lq.label(
      labels.at(0, default: $x$), 
      kind: "x",
    )} else {none}, 
    ylabel: if labels != none {lq.label(
      labels.at(1, default: $y$),
      kind: "y",
    )} else {none},
    xaxis: diagram-axis-defaults(
      tick-distance: tick-distance.at(0),
      subticks: subticks.at(0),
    ) + add-to-xaxis,
    yaxis: diagram-axis-defaults(
      tick-distance: tick-distance.at(1),
      subticks: subticks.at(1),
    ) + add-to-yaxis,
    ..body
  )
}

#let plot(
  y,
  x: auto,
  start: 0, 
  end: 2, 
  num: 100,
  include-end: true,
  mark: none,
  ..args
) = lq.plot(
  if x == auto {lq.linspace(start, end, num: num, include-end: include-end)} else {x},
  y,
  mark: mark,
  ..args
)

#let lilaq-schoolbook(body, show-origin: false) = {

  // set some labels defaults
  show: lq.set-label(pad: none, angle: 0deg)
  show: e.show_(
    lq.label.with(kind: "x"),
    it => place(left + top, dx: 100% + .0em, dy: .4em, it)
  )
  show: e.show_(
    lq.label.with(kind: "y"),
    it => place(bottom + right, dy: -100% - .0em, dx: -.5em, it)
  )

  // set default legend styling
  show lq.selector(lq.legend): set grid(row-gutter: 5pt, columns: 2)

  // set default grid
  show: lq.set-grid(
    stroke: (paint: luma(150), dash: "dotted", thickness: .5pt),
  )

  // set default spine
  show: lq.set-spine(tip: tiptoe.tikz)

  // set some axes defaults
  let filter = {(value, distance) => if not show-origin {value != 0 and distance >= 5pt} else {distance >= 5pt}}

  let axis-args = (
    filter: filter,
    position: 0,
    scale: "linear", 
    format-ticks: sf-formatter, 
  )
  show: lq.set-diagram(xaxis: axis-args, yaxis: axis-args)

  // set ticks defaults
  show: lq.set-tick(inset: 2.0pt, outset: 2.0pt, pad: 0.4em, shorten-sub: 40%)

  // set default styling for tick label
  show lq.selector(lq.tick-label): set text(0.9em)

  body
}
