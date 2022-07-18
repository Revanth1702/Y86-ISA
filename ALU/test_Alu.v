module test_alu;

reg signed [63:0] a;
reg signed [63:0] b;
wire signed[63:0] end_result;
wire carry_overflow;
reg[1:0] control;

alu uut(.control(control),.a(a),.b(b),.end_result(end_result),.carry_overflow(carry_overflow));

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,test_alu);

    control = 2'b00;
    a = 3;
    b = 1;
    #10
    a = -2456;
    b = 99876;
    #10
    a = 5897;
    b = -123;
    #10
    a = 457869;
    b = -676745;#10;

      control = 2'b01;
    a = 3;
    b = 1;
    #10
    a = -2456;
    b = 99876;
    #10
    a = 5897;
    b = -123;
    #10
    a = 457869;
    b = -676745;#10;

      control = 2'b10;
    a = 3;
    b = 1;
    #10
    a = -2456;
    b = 99876;
    #10
    a = 5897;
    b = -123;
    #10
    a = 457869;
    b = -676745;#10;

      control = 2'b11;
    a = 3;
    b = 1;
    #10
    a = -2456;
    b = 99876;
    #10
    a = 5897;
    b = -123;
    #10
    a = 457869;
    b = -676745;
    
    #40 $finish;
end

initial
    $monitor("Time=%d\ncontrol = %b\n a = %b\t\t\t%d\n b = %b\t\t\t%d\n end_result = %b\t\t%d\n overflow = %b\n",
              $time,control,a,a,b,b,end_result,end_result,carry_overflow);

endmodule
