module instruction_memory(
    address,
    instruction
);

input  [7:0]  address;
output [15:0] instruction;

logic [15:0] memory [0:255];

integer i;


initial begin

    // Default all locations to zero
    for (i = 0; i < 256; i = i + 1)
        memory[i] = 16'b0;



    // R3 = R1 + R2
    memory[0] = 16'b0_000_011_001_010_000;

    // R4 = R3 - R1
    memory[1] = 16'b0_000_100_011_001_001;

    // R5 = R2 & R3
    memory[2] = 16'b0_000_101_010_011_010;

    // R6 = R1 | R5
    memory[3] = 16'b0_000_110_001_101_011;

end


assign instruction = memory[address];


endmodule
