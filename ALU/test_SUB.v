module test;

reg signed [63:0]A,B;
wire signed [63:0] result;
wire carry_overflow;

Sub uut(.A(A),.B(B),.result(result),.carry_overflow(carry_overflow));

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,test);
    //A = 64'b0000000000000000000000000000000011111111111111111111111111111111;
    //B = 64'b1111111111111111111111111111111100000000000000000000000000000000;
    //A =64'b0000000000000000000000000000000000000000000000000000000000000000;
    //B = 64'b1111111111111111111111111111111111111111111111111111111111111111;
    A = 64'd4;
    B = 64'd1;

    #20 $finish;
end

initial 
    $monitor("time = %0t,A = %b,B = %b,result = %b,overflow = %b",$time,A,B,result,carry_overflow);

endmodule

