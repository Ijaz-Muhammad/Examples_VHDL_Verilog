# FSM Design in both  VHDL and Verilog: Moore vs Mealy (1-Process, 2-Process, 3-Process)

A compact reference implementation of a 2-state finite state machine (S0, S1) written six different ways: Moore and Mealy output models, each coded in the three common VHDL process partitioning styles.

## Contents

| File | Description |
|---|---|
| `moore_1Process.vhd` | Moore FSM, single clocked process |
| `moore_2Process.vhd` | Moore FSM, state register + combined next-state/output process |
| `Moore_3Process.vhd` | Moore FSM, fully separated register, next-state, and output processes |
| `Mealy_1process.vhd` | Mealy FSM, single clocked process |
| `Mealy_2Process.vhd` | Mealy FSM, state register + combined next-state/output process |
| `Mealy_3Process.vhd` | Mealy FSM, fully separated register, next-state, and output processes |

| File | Description |
|---|---|
| `moore_1Process.v` | Moore FSM, single clocked process |
| `moore_2Process.v` | Moore FSM, state register + combined next-state/output process |
| `Moore_3Process.v` | Moore FSM, fully separated register, next-state, and output processes |
| `Mealy_1process.v` | Mealy FSM, single clocked process |
| `Mealy_2Process.v` | Mealy FSM, state register + combined next-state/output process |
| `Mealy_3Process.v` | Mealy FSM, fully separated register, next-state, and output processes |

## Interface

| Signal | Direction | Description |
|---|---|---|
| `clk` | in | System clock, rising edge triggered |
| `rst` | in | Synchronous, active-high reset to S0 |
| `din` | in | Single-bit serial input |
| `dout` | out | Output bit, registered in Moore, combinational in Mealy |

## Key difference

- **Moore**: output depends only on the present state, so `dout` updates one clock cycle after `din` changes.
- **Mealy**: output depends on present state and input, so `dout` can respond within the same clock cycle.

All six designs were verified in Vivado behavioral simulation and produce matching S0 to S1 to S0 state sequences.

## Reference poster

A one-page summary comparing the theory, process architectures, and simulation results is included as `FSM_Moore_Mealy_Poster_A4.pdf`.

## Recommended style

The 3-process style is suggested as the default for readability, debugging, and code review, since each functional block sits in its own process. The 1-process style remains a reasonable, compact option for very small FSMs.
