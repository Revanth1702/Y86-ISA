module test;

reg signed [63:0]A,B;
wire signed [63:0]SUM;
wire CARRY_OVERFLOW;

Add uut(.A(A),.B(B),.SUM(SUM),.CARRY_OVERFLOW(CARRY_OVERFLOW));

initial begin
  $dumpfile("dump.vcd");
  $dumpvars(0,test);
  A = 64'b1000000000000000000000000000000000000000000000000000000000000001;
  B = 64'b1000000000000000000000000000000000000000000000000000000000000011;

  #40 $finish;
end

  always #10 A = ~A;
  always #20 B = ~B;
  // always #30 A = A^B;


initial 
    $monitor("time = %0t,A = %b,B = %b,SUM = %b,CARRY_OVERFLOW = %b",$time,A,B,SUM,CARRY_OVERFLOW);

endmodule
