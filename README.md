# 16-bit SIMD Processor

I've been building a small 16-bit processor in SystemVerilog, mostly to get more comfortable with RTL design, processor architecture, and verification. It's not finished, and honestly the plan has already shifted a couple of times as I've gone.

I started with the basic scalar pieces on their own: ALU, register file, instruction decoder, program counter, and I'm now wiring those together while also adding a 4-lane SIMD unit on the side. The core idea is that the same processor should be able to run normal 16-bit scalar instructions, or split a register into four smaller lanes and do the same operation on all of them at once.

## Where things stand right now

16-bit datapath, 8 general-purpose registers, two read ports and one write port on the register file, an 8-bit program counter, and 16-bit instructions. Right now the ALU only does ADD, SUB, AND, and OR, and there's a bit in the instruction that picks between running that as a normal scalar op or as a SIMD op across four 4-bit lanes.

Scalar path right now looks roughly like this : PC feeds instruction memory, that goes to the decoder, the decoder tells the register file and control logic what to do, the register file hands operands to the ALU, and the ALU result gets written back:

```
Program Counter -> Instruction Memory -> Instruction Decoder
                                                |
                                    Register File <-> Control
                                                |
                                          Scalar ALU
                                                |
                                          Register File (writeback)
```

The SIMD unit is going to sit next to the scalar ALU rather than replace it, and something downstream picks which result actually gets written back.

## Instruction format

This is what I have now but it might change again:
Only one opcode is actually used at the moment - 000, meaning "this is an ALU instruction." Everything else is unused for now, probably load/store or branching later. The function bits are 000 ADD, 001 SUB, 010 AND, 011 OR, and whether that runs as scalar or SIMD depends entirely on the SIMD flag bit. So the same 3-bit function code means two different things depending on that one bit - scalar ADD vs SIMD ADD, for example.

## The modules

**alu.sv** :just a combinational 16-bit ALU, takes two operands and a 3-bit op code, does ADD/SUB/AND/OR.

**regfile.sv** : eight 16-bit registers, two combinational reads, one synchronous write, register 0 hardwired to zero like you'd expect.

**instruction_decoder.sv** :takes the raw 16-bit instruction and splits it into the fields everything else needs (read addresses, write address, ALU op, whether it's SIMD, write enable, and a valid bit). It doesn't do any actual math, just figures out what should happen and flags instructions it doesn't recognize.

**program_counter.sv** : dead simple 8-bit counter, resets to zero, increments by one every clock edge. No branching or jumps yet - everything just runs in sequence for now.

**instruction_memory.sv** : 256 slots, 16 bits each, addressed directly by the PC. I'm feeding it a small hand-written test program while I bring the rest of the processor up.

**processor_top.sv** : where all of the above actually gets wired together into one scalar pipeline.

## The SIMD side

SIMD just means running one instruction across multiple smaller pieces of data at once. My first version splits a 16-bit register into four 4-bit lanes and does the same op on all four in parallel, then packs the four results back into 16 bits. So if you SIMD-ADD two registers, you get four independent 4-bit additions happening at the same time, each with its own overflow/wraparound behavior since I'm keeping it unsigned for now.

I'm planning to split this into two files - `simd_lane.sv` for one 4-bit lane (same ADD/SUB/AND/OR op codes as the scalar ALU), and `simd_unit.sv` which just instantiates four of those lanes and feeds them the same op code but different slices of the input data. Once that's built, both the scalar ALU and the SIMD unit see the same register operands, and whichever one actually gets written back depends on the SIMD flag from the decoder.

## Testing so far

I've mostly been testing pieces individually in ModelSim/Questa before hooking anything together - the ALU on its own, register file reads/writes and the R0-stays-zero behavior, decoding, and the PC's reset/increment behavior, plus checking that invalid opcodes actually get flagged instead of silently doing something weird.

Right now I'm still eyeballing a lot of this through waveforms, which works but doesn't scale well. I want to move toward proper self-checking testbenches, and eventually build a small Python or C model I can just diff against the RTL output instead of checking by hand.

## What's left

The scalar side is basically done at the block level :ALU, register file, decoder, PC, and instruction memory all exist and have been simulated individually. What's not done yet is actually wiring the full scalar datapath together and running a real program through it end to end.

After that, the SIMD lane and unit need to get built and tested (each op, plus the overflow/wraparound edge cases), then connected into the top-level design with the scalar/SIMD selection logic.

Verification-wise I want a proper processor-level testbench with full instruction sequences and some randomized operand testing, not just my current one-block-at-a-time approach.


## Repo layout

RTL lives under `rtl/` (alu, regfile, instruction_decoder, program_counter, instruction_memory, processor_top, and eventually simd_lane/simd_unit), testbenches under `tb/`, notes and waveforms under `docs/`, and a Python reference model script under `scripts/`. Some of these folders are still filling in as I go.

## Tools

SystemVerilog and ModelSim/Questa for now. Vivado once I get to synthesis, and Python or C for the reference model comparison later on.

## Next up

Finish wiring the scalar datapath, get a program actually running through it, then build the SIMD lane and unit, hook in the scalar/SIMD selection, simulate the whole thing, and only then move on to synthesis and benchmarking. The instruction set will probably keep shifting a bit as I go, but I'd rather get scalar + SIMD solid before touching things like load/store or branching.
