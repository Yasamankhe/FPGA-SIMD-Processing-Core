module simd_lane(
    A,
    B,
    ALUop,
    result
);

input [3:0] A;
input [3:0] B;
input [2:0] ALUop;

output logic [3:0] result;


always_comb begin

    case (ALUop)

        3'b000: result = A + B;   // ADD

        3'b001: result = A - B;   // SUB

        3'b010: result = A & B;   // AND

        3'b011: result = A | B;   // OR

        default: result = 4'b0000;

    endcase

end

endmodule
