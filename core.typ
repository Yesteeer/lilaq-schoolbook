#import "@preview/lilaq:0.6.0" as lq
#import "@preview/zero:0.5.0" as zero
#import "@preview/tiptoe:0.4.0" as tiptoe

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

#let plot-axis-defaults(tick-distance: 1, subticks: 0, filter: none, ..args) = {
  return (
    tick-distance: tick-distance, 
    subticks: subticks, 
    filter: filter, 
    position: 0,
    scale: "linear", 
    format-ticks: sf-formatter, 
    tip: tiptoe.tikz,
    tick-args: (inset: 2.0pt, outset: 2.0pt, pad: 0.4em, shorten-sub: 40%),
  ) + args.named()
}

#let plot(
  ..body,
  start: (0, 0),
  end: (2, 2),
  offset: (-0.3, 0.3),
  scale: 1,
  tick-distance: 1,
  subticks: 0,
  show-origin: false,
  add-to-xaxis: none,
  add-to-yaxis: none,
  labels: none,
) = {
  let (xlim, ylim) = to-ntuple(start).zip(to-ntuple(end))

  let (offset, scale, tick-distance, subticks) = (offset, scale, tick-distance, subticks).map(to-ntuple)

  let (width, height) = lq.vec.add(lq.vec.subtract(..(end, start).map(to-ntuple)), (offset.at(1)-offset.at(0),)*2)

  let filter = {(value, distance) => if not show-origin {value != 0 and distance >= 5pt} else {distance >= 5pt}}

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
      pad: none, 
      angle: 0deg, 
      dx: 50% + .4em,
      dy: .4em,
    )} else {none}, 
    ylabel: if labels != none {lq.label(
      labels.at(1, default: $y$),
      kind: "y",
      pad: none,
      angle: 0deg,
      dx: -.5em,
      dy: -50% - .4em,
    )} else {none},
    xaxis: plot-axis-defaults(
      tick-distance: tick-distance.at(0),
      subticks: subticks.at(0),
      filter: filter,
    ) + add-to-xaxis,
    yaxis: plot-axis-defaults(
      tick-distance: tick-distance.at(1),
      subticks: subticks.at(1),
      filter: filter,
    ) + add-to-yaxis,
    ..body
  )
}

#let add-func(
  func,
  start: 0, 
  end: 2, 
  num: 100,
  include-end: true,
  mark: none,
  ..args
) = lq.plot(
  lq.linspace(start, end, num: num, include-end: include-end),
  func,
  mark: mark,
  ..args
)
