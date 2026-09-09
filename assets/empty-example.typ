#import "../lib.typ": *
#import "@preview/lilaq:0.6.0" as lq

#set page(height: auto, margin: 1cm, width: auto)

// remove background grid
#show: lq.set-grid(
  stroke: none
)

#plot()
