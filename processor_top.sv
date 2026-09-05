module processor_top(
    clk,
    reset,
    pc,
    instruction,
    alu_result
);

input clk;
input reset;

// Debug outputs for now
output [7:0]  pc;
output [15:0] instruction;
output [15:0] alu_result;




wire [2:0] ALUop;

wire [2:0] read_addr1;
wire [2:0] read_addr2;
wire [2:0] write_addr;

wire [15:0] read_data1;
wire [15:0] read_data2;

wire write_enable;
wire reg_write_enable;

wire use_simd;
wire valid_instruction;


program_counter pc_unit (
    .clk(clk),
    .reset(reset),
    .pc(pc)
);


instruction_memory instruction_mem (
    .address(pc),
    .instruction(instruction)
);



instruction_decoder decoder (
    .instruction(instruction),

    .ALUop(ALUop),

    .read_addr1(read_addr1),
    .read_addr2(read_addr2),
    .write_addr(write_addr),

    .write_enable(write_enable),
    .use_simd(use_simd),
    .valid_instruction(valid_instruction)
);





assign reg_write_enable =
    write_enable &&
    valid_instruction &&
    !use_simd &&
    !reset;


regfile register_file (
    .clk(clk),

    .read_addr1(read_addr1),
    .read_addr2(read_addr2),

    .write_addr(write_addr),
    .write_data(alu_result),

    .write_enable(reg_write_enable),

    .read_data1(read_data1),
    .read_data2(read_data2)
);



alu scalar_alu (
    .A(read_data1),
    .B(read_data2),
    .ALUop(ALUop),
    .result(alu_result)
);


endmodule
