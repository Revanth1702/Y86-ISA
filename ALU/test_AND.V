module test;

reg signed [63:0]A,B;
wire signed [63:0]OUT;


Xor uut(.A(A),.B(B),.OUT(OUT));

initial begin
  $dumpfile("dump.vcd");
  $dumpvars(0,test);
  //A = 64'b0000000000000000000000000000000011111111111111111111111111111111;
  //B = 64'b1111111111111111111111111111111100000000000000000000000000000000;
  A = 64'b0000000000000000000000000000000000000000000000000000000001111111;
  B = 64'b0000000000000000000000000000000000000000000000000000000000000111;

  #40 $finish;
end

  //always #10 A = ~A;
  //always #20 B = ~B;
  // always #30 A = A^B;


initial 
    $monitor("time = %0t,A = %b,B = %b,AND= %b",$time,A,B,OUT);

endmodule
