`timescale 1ns/1ps

module tb_alu4;

reg  [3:0] A;
reg  [3:0] B;
reg  [2:0] sel;
wire [3:0] Y;
wire carry;
wire zero;

alu4 uut (
    .A(A),
    .B(B),
    .sel(sel),
    .Y(Y),
    .carry(carry),
    .zero(zero)
);

initial begin
    $dumpfile("alu4.vcd");
    $dumpvars(0, tb_alu4);

    $display("Time\tA\tB\tsel\tY\tcarry\tzero");
    $monitor("%0t\t%b\t%b\t%b\t%b\t%b\t%b", 
              $time, A, B, sel, Y, carry, zero);

    A = 4'b0101; 
    B = 4'b0011;

    sel = 3'b000; #10;
    sel = 3'b001; #10;
    sel = 3'b010; #10;
    sel = 3'b011; #10;
    sel = 3'b100; #10;
    sel = 3'b101; #10;
    sel = 3'b110; #10;
    sel = 3'b111; #10;

    A = 4'b0001;
    B = 4'b0001;
    sel = 3'b001; #10;

    A = 4'b1111;
    B = 4'b0001;
    sel = 3'b000; #10;

    $finish;
end

endmodule
