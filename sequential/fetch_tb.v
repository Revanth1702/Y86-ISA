module fetch_testbench();

reg clk;
reg [63:0] PC;

wire [3:0] icode,ifun,rA,rB;
wire [63:0] valC,valP;

fetch uut(clk,PC,icode,ifun,rA,rB,valP,valC);

initial begin 
    clk=0;
    PC=64'd0;

    #10 clk=~clk;PC=64'd32; // always trigger  clk  =1
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
  end 
  
  initial 
		$monitor("clk=%d,PC=%d,icode=%b,ifun=%b,rA=%b,rB=%b,valC=%d,valP=%d\n",clk,PC,icode,ifun,rA,rB,valC,valP);
endmodule