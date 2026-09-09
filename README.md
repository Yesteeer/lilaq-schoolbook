# Lilaq-schoolbook

_Lilaq-schoolbook_ is a typst package that provides a simple way to plot functions with schoolbook style whilst controlling the axes length and scale intervals.

## Dependencies

As the name suggests, this package is based on the incredible [lilaq](https://typst.app/universe/package/lilaq/) package.

## Quickstart

Download the package locally (as described on the [Typst Packages](https://github.com/typst/packages)) repository. Then import and use _lilaq-schoolbook_.

```typst
#import "@local/lilaq-schoolbook:0.1.0": *
```

## Functions

The package comes with the main functions `plot()` and `add-func()` which correspond respectively to _lilaq_'s `diagram()` and `plot()` functions.

## Examples

By default, `plot()` generates two perpendicular axes from 0 to 2, with a background grid. The scale of the axes' graduation is 1:1cm. 

```typst
#import "@local/lilaq-schoolbook:0.1.0": *

#set page(height: auto, margin: 1cm, width: auto)

#plot()
```

![image](./assets/default-example.png)

It is also possible to remove the grid using _lilaq_'s custom set rules.

```typst
[...]

#import "@preview/lilaq:0.6.0" as lq

#show: lq.set-grid(
  stroke: none
)

#plot()
```

![image](./assets/empty-example.png)

We can now add a function and labels to our system and scale the axis for better visualization.

```typst
[...]

#plot(
  scale: (3, 2),
  labels: ($x$, $y$),
  add-func(x => calc.pow(x, 2), label: $f(x) = x^2$),
  show-origin: true,
)
```

![image](./assets/simple-example.png)

Finally, we can use still use all of _lilaq_'s power for some more advanced results.

```typst
[...]

#import "@preview/lilaq:0.6.0" as lq

// set vertical spacing between the two functions' legends 
#show lq.selector(lq.legend): set grid(row-gutter: 5pt)

// set a custom grid styling
#show: lq.set-grid(
  stroke: (paint: luma(150), dash: "dotted", thickness: .5pt),
)

#plot(
  start: (-6, -1.5),
  end: (5.8, 1.5),
  scale: 1.2,
  offset: (0, 0.3),
  labels: ($x$, $y$),
  add-to-xaxis: (
    tick-distance: 1/ 2,

    // sets horizontal ticks to follow multiples of pi
    locate-ticks: lq.tick-locate.linear.with(unit: calc.pi),

    // define custom tick label format
    format-ticks: lq.tick-format.fraction.with(suffix: $pi$),
  ),

  // place the legends box
  legend: (position: top + right, dy: -15pt),
    
  // add functions to plot
  add-func(x => calc.sin(x), start: -6.5, end: 6.5, label: lq.label($sin(x)$, dy: 2cm)),
  add-func(x => calc.cos(x), start: -6.5, end: 6.5, label: $cos(x)$),
)
```

![image](./assets/advanced-example.png)

