`include"fetch.v"
`include "decode.v"
module fetchdecodetb;
  reg clk;
  wire cnd;
  reg [63:0] PC;
  reg [63:0] reg_mem[0:14];

  wire [3:0] icode,ifun,rA,rB;

  wire signed [63:0] valC,valP,valA,valB,valE;


fetch uut1(clk,PC,icode,ifun,rA,rB,valP,valC);

decode uut2(icode,clk,rA,rB,reg_mem[rA],reg_mem[rB],reg_mem[4],valA,valB);

execute uut3(icode,ifun,clk,valA,valB,valC,valE,cnd);

  initial begin
    reg_mem[0]=64'd0;
    reg_mem[1]=64'd1;
    reg_mem[2]=64'd2;
    reg_mem[3]=64'd3;
    reg_mem[4]=64'd4;
    reg_mem[5]=64'd5;
    reg_mem[6]=64'd6;
    reg_mem[7]=64'd7;
    reg_mem[8]=64'd8;
    reg_mem[9]=64'd9;
    reg_mem[10]=64'd10;
    reg_mem[11]=64'd11;
    reg_mem[12]=64'd12;
    reg_mem[13]=64'd13;
    reg_mem[14]=64'd14;

    //clk=0;PC=64'd0;

    clk=1;PC=64'd19;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    // #10 clk=~clk;PC=valP;
    // #10 clk=~clk;
    // #10 clk=~clk;PC=valP;
    // #10 clk=~clk;
    // #10 clk=~clk;PC=valP;
    // #10 clk=~clk;
    // #10 clk=~clk;PC=valP;
    // #10 clk=~clk;
    // #10 clk=~clk;PC=valP;
    // #10 clk=~clk;
  end 

  initial 
		$monitor("clk=%d PC = %d icode=%b ifun=%b rA=%b rB=%b valA=%d valB=%d valE=%d\n",clk,PC,icode,ifun,rA,rB,valA,valB,valE);
endmodule