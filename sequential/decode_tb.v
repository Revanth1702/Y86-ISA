`include "fetch.v"
`include "execute.v"
`include "decode.v"
`include "memory.v"
module fdecode_tb;

reg clk;

reg [63:0] reg_mem[0:14];
reg [63:0] PC;
wire [3:0] rA,rB,icode,ifun;
wire signed [63:0] valA,valB,valC,valP,valM,valE;
wire signed [63:0] regmem0,regmem1,regmem2,regmem3,regmem4,regmem5,regmem6,regmem7,regmem8,regmem9,regmem10,regmem11;
wire signed [63:0] regmem12,regmem13,regmem14,regmem15;
wire cnd,hlt;
fetch uut1(clk,PC,icode,ifun,rA,rB,valP,valC,hlt);
execute uut3(icode,ifun,clk,valA,valB,valC,valE,cnd);
decode uut2(icode,clk,rA,rB,cnd,valE,valM,regmem0,regmem1,regmem2,regmem3,regmem4,regmem5,regmem6,regmem7,regmem8,regmem9,regmem10,regmem11,regmem12,regmem13,regmem14,regmem15,valA,valB);
memory uut4(clk,icode,valE,valP,valA,valM);

initial begin

    //clk = 0;PC=64'd0;

     clk=1;PC=64'd1;
    #20 clk=~clk;
    #20 clk=~clk;PC=valP;
    #20 clk=~clk;
    // #20 clk=~clk;PC=valP;
    // #20 clk=~clk;
    // #20 clk=~clk;PC=valP;
    // #20 clk=~clk;
    // #20 clk=~clk;PC=valP;
    // #20 clk=~clk;
    // #20 clk=~clk;PC=valP;
    // #20 clk=~clk;
end

initial 
//	$monitor("clk=%d PC=%d icode=%b ifun=%b \nrA=%b rB=%b valA=%d valB=%d valE=%d\nr3=%d r2=%d\nr6=%d r7=%d\n",clk,PC,icode,ifun,rA,rB,valA,valB,valE,regmem3,regmem2,regmem6,regmem7);
  $monitor("clk=%d PC=%d icode=%b ifun=%b \nrA=%b rB=%b valA=%d valB=%d valE=%d\nr4=%d r2=%d\n",clk,PC,icode,ifun,rA,rB,valA,valB,valE,regmem4,regmem2);
  //  $monitor("clk=%d PC=%d reg_mem[ra]=%b reg_mem[rb]=%b reg_mem[4]=%b\n",clk,PC,reg_mem[0000],reg_mem[0001],reg_mem[0100]);
endmodule
