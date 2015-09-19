#!/usr/bin/gnuplot

reset
set terminal svg size 800,800

set xdata time
set timefmt "%s"
set format x ""
set xrange ["1":"1500"]

#set key reverse Left outside
set grid
set lmargin at screen 0.15

set multiplot layout 3,1

set ylabel "Guifi.net Routes"
set tmargin at screen 0.99
set bmargin at screen 0.69
plot "< grep Routes ".datafile using 2:18 title "" smooth bezier

set ylabel "System Load"
set tmargin at screen 0.69
set bmargin at screen 0.37
set yrange [0:1.5]
plot "< grep bgp1 ".datafile using 2:9 title "BGPx1" smooth bezier, \
	"< grep bgp2 ".datafile using 2:9 title "BGPx2" smooth bezier, \
	"< grep bmx3 ".datafile using 2:9 title "BMX 3" smooth bezier

set ylabel "Used Memory, Total 128MB"
set tmargin at screen 0.37
set bmargin at screen 0.07
set yrange [0:128]
set ytics ("0MB" 0,"20MB" 20,"40MB" 40, "60MB" 60, "80MB" 80, "100MB" 100, "120MB" 120)
set format x "%M"
set xlabel "System uptime in minutes"
plot "< grep bgp1 ".datafile." | awk '{print $2, $13/1024}'" using 1:2 title "BGP 1" smooth bezier, \
	"< grep bgp2 ".datafile." | awk '{print $2, $13/1024}'" using 1:2 title "BGPx2" smooth bezier, \
	"< grep bmx3 ".datafile." | awk '{print $2, $13/1024}'" using 1:2 title "BMXx3" smooth bezier

unset multiplot
