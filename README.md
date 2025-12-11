# Traffic Light Controller (Verilog RTL + Testbench)

This project implements a traffic light controller using Verilog, along with a tick generator and a complete testbench. The controller supports a manual extension input, allowing the user to extend the green time of the North–South direction based on a button/trigger.

This project was created for learning and academic purposes, focusing on RTL design, counters, and waveform simulation using Verilog + GTKWave.

### Files in This Repository
File	Description
```bash
traffic.v	Traffic light controller logic

tick1s.v	Tick generator that produces periodic pulses

tb_traffic.v	Testbench (clock, reset, waveform dump, user extension event)
```
### Design Overview

The traffic system controls two directions:

North–South (NS)

East–West (EW)

At any moment, exactly one direction can have green/yellow, while the opposite direction stays red.

Default Phase Timings
Phase	Duration (ticks)	Lights
NS Green	10	NS = Green, EW = Red
NS Yellow	3	NS = Yellow, EW = Red
EW Green	10	EW = Green, NS = Red
EW Yellow	3	EW = Yellow, NS = Red

A tick is generated periodically by the tick1s module (default: every 50 clock cycles).



### Manual Extension Feature

The traffic controller includes an extension input:

When the user sets extension = 1 during the NS green phase,

The NS green time (t1) is increased by 5 additional ticks.

The remaining timings (t2, t3) automatically adjust to maintain proper sequence.

This simulates a manual override or a pedestrian request button that extends NS time based on user choice, not sensor feedback.

### Simulation Details
Running the simulation:

```bash
iverilog -o sim.out traffic.v tick1s.v tb_traffic.v

vvp sim.out

gtkwave traffic.vcd

```
Testbench behavior

The testbench performs: Reset for initial setup Waits for 5 ticks. Applies a manual extension pulse for one tick. Observes extended NS green time. Runs additional cycles and finishes

This verifies both normal operation and manual override behavior.

### Expected Waveforms

You can expect to observe:

Regular tick pulses

Internal counter incrementing

Light outputs (ns_green, ns_yellow, ns_red, etc.)

Manual extension operation extending the NS green phase

### Key Learning Outcomes

✔ Designing sequential logic using counters

✔ Handling user-driven extension inputs

✔ Writing modular Verilog (separate tick generator + controller)

✔ Building event-driven testbenches using @(posedge tick)

✔ Debugging waveforms using GTKWave

✔ Understanding timing-based state transitions


### How to Modify Timings

Inside traffic.v:

```bash
reg [4:0] t1 = 10;  // NS Green

reg [4:0] t2 = 13;  // NS Green + Yellow

reg [4:0] t3 = 23;  // NS+EW combined duration
```

Change these values to customize durations.

### License

This project is intended only for academic and learning purposes.
No commercial use is intended.
