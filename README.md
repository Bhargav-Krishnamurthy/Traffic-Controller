#🚦 Traffic Light Controller in Verilog

A fully functional traffic light controller implemented in Verilog, featuring:

Direction-based light sequencing (North–South & East–West)

Programmable timing for each phase

Pedestrian / vehicle extension input

Testbench + waveform visualization (.vcd)

FPGA-friendly, synthesizable design

This project was written and tested using Icarus Verilog and GTKWave.

📌 Features
✔ Normal traffic cycle

The controller follows a fixed timing pattern:

Traffic Light Timing Pattern:

Phase 1: North–South Green
Duration: 10 seconds
North–South Lights: Green ON, Yellow OFF, Red OFF
East–West Lights:   Green OFF, Yellow OFF, Red ON

Phase 2: North–South Yellow
Duration: 3 seconds
North–South Lights: Green OFF, Yellow ON, Red OFF
East–West Lights:   Green OFF, Yellow OFF, Red ON

Phase 3: East–West Green
Duration: 10 seconds
North–South Lights: Green OFF, Yellow OFF, Red ON
East–West Lights:   Green ON, Yellow OFF, Red OFF

Phase 4: East–West Yellow
Duration: 3 seconds
North–South Lights: Green OFF, Yellow OFF, Red ON
East–West Lights:   Green OFF, Yellow ON, Red OFF

✔ Extension Logic (Vehicle/Pedestrian Request)

When the input extension is high during NS Green, the NS green phase extends by 5 additional seconds.

✔ 1-Second Tick Generator

A frequency divider converts a fast clock (e.g., 100 MHz FPGA clock) into a clean 1 Hz tick, used by the traffic controller.

✔ VCD Waveform Generation

The testbench automatically writes traffic.vcd for viewing in GTKWave.


🧠 Design Overview
1️⃣ Tick Generator (tick1s.v)

Takes a fast clock (e.g., 100 MHz) and produces a 1 Hz pulse.

localparam maxval = 100000000 - 1;  // Divide 100 MHz to 1 Hz


Whenever the counter hits maxval, the module sets tick = 1 for one cycle.

2️⃣ Traffic Controller (traffic.v)

Implements the traffic light logic using:

A 5-bit counter

Four timing thresholds (t1, t2, t3)

Optional green-light extension

The controller updates only on each tick, not every clock cycle.

State behavior is implemented using if-blocks (non-FSM approach), but still synthesizable.

3️⃣ Testbench (tb_traffic.v)

The testbench:

Generates a 10 ns clock

Resets the system

Waits several ticks

Activates extension

Dumps waveforms via:

$dumpfile("traffic.vcd");
$dumpvars(0, tb_traffic);


You can view the waveform in GTKWave.

▶️ Running the Simulation
Step 1 — Compile
iverilog -o sim.out tick1s.v traffic.v tb_traffic.v

Step 2 — Run
vvp sim.out

Step 3 — View waveforms

If on Linux/WSL:

gtkwave traffic.vcd


If using Windows GTKWave:
Open → traffic.vcd

You'll see signals for:

ns_green, ns_yellow, ns_red

ew_green, ew_yellow, ew_red

tick

counter

🧪 Simulation Notes

The real tick divider (100M cycles) is large; for simulation you may reduce maxval to speed up the run.

All outputs are initialized to avoid X states.

The testbench includes an example extension request.

🚀 Possible Extensions (Future Work)

Convert design to a proper FSM (Moore or Mealy).

Add pedestrian crossing system (walk/stop indicators).

Add vehicle sensors for adaptive timing.

Implement a 4-way intersection.

Port to FPGA (Basys 3 / Arty A7).

📜 License

This project is entirely for learning and academic purposes.
Feel free to modify and use in your personal VLSI/digital design journey.
