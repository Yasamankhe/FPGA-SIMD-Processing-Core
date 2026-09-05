module program_counter(
    clk,
    reset,
    pc
);

input clk;
input reset;

output logic [7:0] pc;


// Program counter:
// reset = 1  -> go back to instruction 0
// reset = 0  -> move to the next instruction every clock

always_ff @(posedge clk) begin

    if (reset)
        pc <= 8'b00000000;

    else
        pc <= pc + 1'b1;

end


endmodule
