module instruction_decoder_tb;

logic [15:0] instruction;

logic [2:0] ALUop;
logic [2:0] read_addr1;
logic [2:0] read_addr2;
logic [2:0] write_addr;

logic write_enable;
logic use_simd;
logic valid_instruction;


// Instantiate decoder
instruction_decoder dut (
    .instruction(instruction),

    .ALUop(ALUop),

    .read_addr1(read_addr1),
    .read_addr2(read_addr2),
    .write_addr(write_addr),

    .write_enable(write_enable),
    .use_simd(use_simd),
    .valid_instruction(valid_instruction)
);


initial begin

    $display("Starting decoder test");


    // 1. Scalar ADD
    instruction = 16'b0_000_011_001_010_000;
    #1;

    $display("Scalar ADD: instruction=%b ALUop=%b write=%b read1=%b read2=%b WE=%b SIMD=%b valid=%b",
             instruction, ALUop, write_addr, read_addr1, read_addr2,
             write_enable, use_simd, valid_instruction);


    // 2. Scalar SUB
    instruction = 16'b0_000_011_001_010_001;
    #1;

    $display("Scalar SUB: instruction=%b ALUop=%b write=%b read1=%b read2=%b WE=%b SIMD=%b valid=%b",
             instruction, ALUop, write_addr, read_addr1, read_addr2,
             write_enable, use_simd, valid_instruction);


    // 3. Scalar AND
    instruction = 16'b0_000_011_001_010_010;
    #1;

    $display("Scalar AND: instruction=%b ALUop=%b WE=%b SIMD=%b valid=%b",
             instruction, ALUop, write_enable, use_simd, valid_instruction);


    // 4. Scalar OR
    instruction = 16'b0_000_011_001_010_011;
    #1;

    $display("Scalar OR: instruction=%b ALUop=%b WE=%b SIMD=%b valid=%b",
             instruction, ALUop, write_enable, use_simd, valid_instruction);


    // 5. SIMD ADD
    instruction = 16'b1_000_011_001_010_000;
    #1;

    $display("SIMD ADD: instruction=%b ALUop=%b WE=%b SIMD=%b valid=%b",
             instruction, ALUop, write_enable, use_simd, valid_instruction);


    // 6. SIMD SUB
    instruction = 16'b1_000_011_001_010_001;
    #1;

    $display("SIMD SUB: instruction=%b ALUop=%b WE=%b SIMD=%b valid=%b",
             instruction, ALUop, write_enable, use_simd, valid_instruction);


    // 7. SIMD AND
    instruction = 16'b1_000_011_001_010_010;
    #1;

    $display("SIMD AND: instruction=%b ALUop=%b WE=%b SIMD=%b valid=%b",
             instruction, ALUop, write_enable, use_simd, valid_instruction);


    // 8. SIMD OR
    instruction = 16'b1_000_011_001_010_011;
    #1;

    $display("SIMD OR: instruction=%b ALUop=%b WE=%b SIMD=%b valid=%b",
             instruction, ALUop, write_enable, use_simd, valid_instruction);


    // 9. Invalid function
    instruction = 16'b0_000_011_001_010_100;
    #1;

    $display("Invalid FUNC: instruction=%b ALUop=%b WE=%b SIMD=%b valid=%b",
             instruction, ALUop, write_enable, use_simd, valid_instruction);


    // 10. Invalid opcode
    instruction = 16'b0_001_011_001_010_000;
    #1;

    $display("Invalid OPCODE: instruction=%b ALUop=%b WE=%b SIMD=%b valid=%b",
             instruction, ALUop, write_enable, use_simd, valid_instruction);


    $display("Decoder test finished");

    $finish;

end

endmodule
