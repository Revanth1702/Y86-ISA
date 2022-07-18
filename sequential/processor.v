`include "fetch.v"
`include "execute.v"
`include "decode.v"
`include "memory.v"
`include "pcupdate.v"
module proc_tb;

reg clk=0;

reg [63:0] reg_mem[0:14];
reg [63:0] PC;
reg [2:0]status;
wire inst_valid, mem_error;
wire [3:0] rA,rB,icode,ifun;
wire signed [63:0] valA,valB,valC,valP,valM,valE;
wire signed [63:0] regmem0,regmem1,regmem2,regmem3,regmem4,regmem5,regmem6,regmem7,regmem8,regmem9,regmem10,regmem11;
wire signed [63:0] regmem12,regmem13,regmem14,regmem15;
wire cnd,hlt;
wire [63:0] pcupd;
fetch uut1(clk,PC,icode,ifun,rA,rB,valP,valC,hlt,inst_valid,mem_error);
execute uut3(icode,ifun,clk,valA,valB,valC,valE,cnd);
decode uut2(icode,clk,rA,rB,cnd,valE,valM,regmem0,regmem1,regmem2,regmem3,regmem4,regmem5,regmem6,regmem7,regmem8,regmem9,regmem10,regmem11,regmem12,regmem13,regmem14,regmem15,valA,valB);
memory uut4(clk,icode,valE,valP,valA,valM);
pcupdate uut5(clk,valP,valC,valM,cnd,icode,pcupd);

initial 
begin
    //clk=0;
    PC = 64'd1;
    clk=~clk;
    #10 clk=~clk;
    #10 clk=~clk;
    #10 clk=~clk;
    #10 clk=~clk;
    #10 clk=~clk;
    #10 clk=~clk;
    #10 clk=~clk;
    #10 clk=~clk;
    #10 clk=~clk;
end
 always@(*)
 begin
   if(hlt==1) 
   begin
   status = 2'b01;
    $display("status=%d Halt has occured!",status);
    $finish;
   end
   if(mem_error==1) 
   begin
   status = 2'b10;
   $display("status=%d memory error has occured!",status);
   $finish;
   end
   if(inst_valid==0) 
   begin 
     status = 2'b11;
     $display("status=%d instr invalid error has occured!",status);
     $finish;
   end
   else  status = 2'b00;
 end   
 
always@(negedge clk) PC = pcupd;



initial 
//	$monitor("clk=%d PC=%d icode=%b ifun=%b \nrA=%b rB=%b valA=%d valB=%d valE=%d\nr3=%d r2=%d\nr6=%d r7=%d\n",clk,PC,icode,ifun,rA,rB,valA,valB,valE,regmem3,regmem2,regmem6,regmem7);
  $monitor("clk=%d PC=%d icode=%b ifun=%b \nrA=%b rB=%b valA=%d valB=%d\nr4=%d r2=%d\nr6=%d r7=%d\n",clk,PC,icode,ifun,rA,rB,valA,valB,regmem4,regmem2,regmem6,regmem7);
  //  $monitor("clk=%d PC=%d reg_mem[ra]=%b reg_mem[rb]=%b reg_mem[4]=%b\n",clk,PC,reg_mem[0000],reg_mem[0001],reg_mem[0100]);
endmodule
