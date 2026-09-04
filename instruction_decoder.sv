module instruction_decoder(
    instruction,
    ALUop,
    read_addr1,
    read_addr2,
    write_addr,
    write_enable,
    use_simd,
    valid_instruction
);

input [15:0] instruction;

output [2:0] ALUop;
output [2:0] read_addr1;
output [2:0] read_addr2;
output [2:0] write_addr;

output write_enable;
output use_simd;
output valid_instruction;


// Internal instruction fields

logic       simd_flag;
logic    [2:0] opcode;
logic      [2:0] func;

logic valid_opcode;
logic valid_func;


// bits breakdown

assign simd_flag  = instruction[15];

assign opcode     = instruction[14:12];

assign write_addr = instruction[11:9];
assign read_addr1 = instruction[8:6];
assign read_addr2 = instruction[5:3];

assign func       = instruction[2:0];



// Is the instruction type valid?
// Current opcode:
// 000 = ALU instruction
// Other opcodes:
// 001 = LOAD
// 010 = STORE
// 011 = branch/control


assign valid_opcode = (opcode == 3'b000);

// Current functions:
// 000 = ADD
// 001 = SUB
// 010 = AND
// 011 = OR
// 100-111 are reserved for later.

assign valid_func = (func <= 3'b011);

// must be
assign valid_instruction = valid_opcode && valid_func;


// control signals

assign ALUop = valid_instruction ? func : 3'b000;
C:/Users/User/AppData/Local/quartus/instruction_decoder.sv

// A valid ALU instruction writes its result back to the reg


assign write_enable = valid_instruction;


// Bit 15 decides:
// 0 = scalar
// 1 = SIMD

assign use_simd = valid_instruction && simd_flag;


endmodule
