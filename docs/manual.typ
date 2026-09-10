#import "@preview/tidy:0.4.3"
#import "@preview/lilaq:0.6.0" as lq
#import "../core.typ"


#set document(title: "Lilaq-schoolbook")

#v(5em)
#align(center)[
  #show: core.lilaq-schoolbook
  #title() Revisit lilaq's schoolbook style. #v(20%)

  #core.diagram(
    start: (-3, -1.5),
    end: (3, 1.5),
    scale: (2, 2),
    labels: ($x$, $y$),
    core.plot(x => calc.sin(1 / x), x: lq.logspace(-5, 0, num: 1000), include-end: false, color: blue),
    core.plot(x => calc.sin(1 / x), x: lq.linspace(1, 4), include-end: false, color: blue),
    core.plot(x => calc.sin(1 / x), x: lq.logspace(-5, 0, num: 1000).map(it => - it), include-end: false, color: blue),
    core.plot(x => calc.sin(1 / x), x: lq.linspace(-4, -1), include-end: false, color: blue),
    lq.place(2, 1.3)[#text(blue)[$display(f(x) = sin(1/x))$]]
  )#v(20%)

  Version 0.1.0 #v(0em)
  #datetime.today().display() #v(0em)
  #link("https://github.com/Yesteeer/typst-lilaq-schoolbook")
]

#pagebreak()

#show heading.where(level: 2): set text(1.3em)
#show heading.where(level: 3): it => {
  set text(1.4em)
  set align(center)
  set block(below: 1.2em)
  it
}

#let core-functions = tidy.parse-module(
  read("../core.typ"),
  name: "lilaq-schoolbook", 
  scope: (core: core),
  preamble: "#import core: *\n",
)

#tidy.show-module(
  core-functions, 
  style: tidy.styles.default, 
  sort-functions: false, 
)
