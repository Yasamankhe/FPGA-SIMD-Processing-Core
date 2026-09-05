module simd_unit(
    A,
    B,
    ALUop,
    result
);

input [15:0] A;
input [15:0] B;

input [2:0] ALUop;

output [15:0] result;


// Lane 0
simd_lane lane0 (
    .A(A[3:0]),
    .B(B[3:0]),
    .ALUop(ALUop),
    .result(result[3:0])
);


// Lane 1
simd_lane lane1 (
    .A(A[7:4]),
    .B(B[7:4]),
    .ALUop(ALUop),
    .result(result[7:4])
);


// Lane 2
simd_lane lane2 (
    .A(A[11:8]),
    .B(B[11:8]),
    .ALUop(ALUop),
    .result(result[11:8])
);


// Lane 3
simd_lane lane3 (
    .A(A[15:12]),
    .B(B[15:12]),
    .ALUop(ALUop),
    .result(result[15:12])
);


endmodule
