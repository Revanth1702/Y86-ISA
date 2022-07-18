module Sub(A,B,result,carry_overflow);

input signed [63:0]A,B;
output signed [63:0] result;

wire [63:0]notB; 
wire [63:0]one;
wire [63:0]complB;
output carry_overflow;

assign notB = ~B;

assign one = 64'b1;

Add H2(notB,one,complB,dummy);
            
Add H3(A,complB,result,carry_overflow);

endmodule
 
