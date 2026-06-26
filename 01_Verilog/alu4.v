module alu4 (
    input  [3:0] A,
    input  [3:0] B,
    input  [2:0] sel,
    output reg [3:0] Y,
    output reg carry,
    output zero
);

always @(*) begin
    carry = 0;
    Y = 4'b0000;

    case (sel)
        3'b000: {carry, Y} = A + B;                 // Cong
        3'b001: Y = A - B;                          // Tru
        3'b010: Y = A & B;                          // AND
        3'b011: Y = A | B;                          // OR
        3'b100: Y = A ^ B;                          // XOR
        3'b101: Y = ~A;                             // NOT A
        3'b110: Y = (A > B) ? 4'b0001 : 4'b0000;    // So sanh A > B
        3'b111: Y = A;                              // Giu nguyen A
        default: Y = 4'b0000;
    endcase
end

assign zero = (Y == 4'b0000);

endmodule
