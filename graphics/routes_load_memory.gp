#!/usr/bin/gnuplot

reset
set terminal svg size 800,800

set format x ""
unset xtics

set timefmt "%s"

set x2data time
set x2range ["1":"1500"]
set x2tics border mirror

#set key reverse Left outside
set grid x2 y
set lmargin at screen 0.15

set multiplot layout 3,1

set format x2 "%M"
set x2label "System uptime in minutes"

set ylabel "Guifi.net Routes"
set tmargin at screen 0.94
set bmargin at screen 0.64
plot "< grep Routes ".datafile using 2:18 title "" axes x2y1 smooth bezier

set format x2 ""
unset x2label
set ylabel "System Load"
set tmargin at screen 0.64
set bmargin at screen 0.32
set yrange [0:1.5]
plot "< grep bgp1 ".datafile using 2:9 title "BGPx1" axes x2y1 smooth bezier, \
	"< grep bgp2 ".datafile using 2:9 title "BGPx2" axes x2y1 smooth bezier, \
	"< grep bmx3 ".datafile using 2:9 title "BMX 3" axes x2y1 smooth bezier

set ylabel "Used Memory, Total 128MB"
set tmargin at screen 0.32
set bmargin at screen 0.02
set yrange [0:128]
set ytics ("0MB" 0,"20MB" 20,"40MB" 40, "60MB" 60, "80MB" 80, "100MB" 100, "120MB" 120)

plot "< grep bgp1 ".datafile." | awk '{print $2, $13/1024}'" using 1:2 title "BGPx1" axes x2y1 smooth bezier, \
	"< grep bgp2 ".datafile." | awk '{print $2, $13/1024}'" using 1:2 title "BGPx2" axes x2y1 smooth bezier, \
	"< grep bmx3 ".datafile." | awk '{print $2, $13/1024}'" using 1:2 title "BMX 3" axes x2y1 smooth bezier

unset multiplot
