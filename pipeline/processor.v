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
reg[4:0] clock;
// wire [3:0] rA,rB,icode,ifun;
// wire signed [63:0] valA,valB,valC,valP,valM,valE;
  wire [2:0]  f_stat;
  wire [3:0]  f_icode;
  wire [3:0]  f_ifun; 
  wire [3:0]  f_rA;
  wire [3:0]  f_rB;
  wire [63:0] f_valC;
  wire [63:0] f_valP;
  wire [3:0]  f_dstM;
  
  wire [2:0]  d_stat;
  wire [2:0]  D_stat;
  wire [3:0]  d_icode;
  wire [3:0]  d_ifun;
  wire [3:0]  d_rA;
  wire [3:0]  d_rB;
  wire [63:0] d_valC;
  wire [63:0] d_valP;
  wire [63:0] d_valA;
  wire [63:0] d_valB;
  wire [3:0]  d_srcA;
  wire [3:0]  d_srcB;
  wire [3:0]  d_dstM;
  wire d_bubble;


  wire [2:0]  e_stat;
  wire [2:0]  E_stat;
  wire [3:0]  e_icode,E_icode;
  wire [3:0]  e_ifun;
  wire        e_cnd;
  wire [3:0]  e_rA;
  wire [3:0]  e_rB;
  wire [63:0] e_valC;
  wire [63:0] e_valP;
  wire [63:0] e_valA;
  wire [63:0] e_valB;
  wire [63:0] e_valE;
  wire [3:0]  e_dstE;
  wire [3:0]  e_dstM;


  wire [2:0]  m_stat;
  wire [2:0]  M_stat;
  wire [3:0]  m_icode,m_ifun,M_icode;
  wire        m_cnd;
  wire [3:0]  m_rA;
  wire [3:0]  m_rB;
  wire [63:0] m_valC;
  wire [63:0] m_valP;
  wire [63:0] m_valA;
  wire [63:0] m_valB;
  wire [63:0] m_valE;
  wire [63:0] m_valM;
  wire [3:0]  m_dstE;
  wire [3:0]  m_dstM;
  
  wire [2:0]  w_stat ;
  wire [2:0]  W_stat;
  wire [3:0]  w_icode,w_ifun;
  wire        w_cnd;
  wire [3:0]  w_rA;
  wire [3:0]  w_rB;
  wire [63:0] w_valC;
  wire [63:0] w_valP;
  wire [63:0] w_valA;
  wire [63:0] w_valB;
  wire [63:0] w_valE;
  wire [63:0] w_valM;
  wire [3:0]  w_dstE;
  wire [3:0]  w_dstM;

wire signed [63:0] regmem0,regmem1,regmem2,regmem3,regmem4,regmem5,regmem6;
wire signed [63:0] regmem7,regmem8,regmem9,regmem10,regmem11;
wire signed [63:0] regmem12,regmem13,regmem14,regmem15;
wire hlt;
wire [63:0] pc_pred;
fetch uut1(clk,PC,m_icode,m_ifun,m_cnd,m_valA,w_icode,w_valM,
           f_stat,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP,f_dstM,
           pc_pred,D_stat,d_icode,d_ifun,d_rA,d_rB,d_valC,d_valP,d_dstM,d_srcA,d_srcB,d_bubble,
           e_icode,e_dstM);

execute uut3(clk,d_srcA,d_srcB,E_icode,e_icode,e_ifun,e_rA,e_rB,e_valC,e_valP,e_valA,e_valB,e_cnd,e_valE,e_dstE,e_dstM,E_stat,
             M_icode,m_ifun,m_rA,m_rB,m_valC,m_valP,m_valA,m_valB,m_cnd,m_valE,m_dstE,m_dstM,M_stat);

decode uut2(clk,d_icode,d_ifun,d_rA,d_rB,d_dstM,D_stat,
            w_rA,w_rB,w_icode,w_dstE,w_dstM,w_valM,w_valE,d_valC,d_valP,m_cnd,m_valE,
            m_valM,m_dstM,m_dstE,m_icode,
            regmem0,regmem1,regmem2,regmem3,
            regmem4,regmem5,regmem6,regmem7,regmem8,regmem9,regmem10,regmem11,regmem12,regmem13,regmem14,
            regmem15,d_valA,d_valB,d_srcA,d_srcB,d_bubble,
            e_valE,E_icode,e_icode,e_ifun,e_rA,e_rB,e_valC,e_valP,e_valA,e_valB,e_dstE,e_dstM,E_stat,e_cnd);

memory uut4(clk,M_icode,m_icode,m_ifun,m_rA,m_rB,m_valC,m_valP,m_valA,m_valB,m_cnd,m_valE,m_valM,m_dstM,M_stat,m_stat,
            w_icode,w_ifun,w_rA,w_rB,w_valC,w_valP,w_valA,w_valB,w_cnd,w_valE,w_valM,w_dstM,W_stat);
//pcupdate uut5(clk,valP,valC,valM,cnd,icode,pcupd);

initial 
begin
  $dumpfile("dump.vcd");
    $dumpvars(0,proc_tb);
    //clk=0;
    clock = 0;
    PC = 64'd39;
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
    #10 clk=~clk;
    #10 clk=~clk;
    #10 clk=~clk;
    #10 clk=~clk;
    #10 clk=~clk;
    #10 clk=~clk;
    #10 clk=~clk;
    // #10 clk=~clk;
    // #10 clk=~clk;
    // #10 clk=~clk;
    // #10 clk=~clk;
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
  //  if(inst_valid==0) 
  //  begin 
  //    status = 2'b11;
  //    $display("status=%d instr invalid error has occured!",status);
  //    $finish;
  //  end
   else  status = 2'b00;

  if(clk==1)clock = clock+1;
 end   
 
always@(negedge clk) PC = pc_pred;



initial 
  //$monitor("clk=%d PC=%d icode=%b ifun=%b \nrA=%b rB=%b valA=%d valB=%d valE=%d\nr3=%d r2=%d\nr6=%d r7=%d\n",clk,PC,icode,ifun,rA,rB,valA,valB,valE,regmem3,regmem2,regmem6,regmem7);
  //$monitor("clk=%d PC=%d icode=%b ifun=%b \nrA=%b rB=%b valA=%d valB=%d\nr3=%d r2=%d\nr6=%d r7=%d\n",clk,PC,icode,ifun,rA,rB,valA,valB,regmem3,regmem2,regmem6,regmem7);
  //$monitor("clk=%d PC=%d reg_mem[ra]=%b reg_mem[rb]=%b reg_mem[4]=%b\n",clk,PC,reg_mem[0000],reg_mem[0001],reg_mem[0100]);
 // $monitor("clk=%d PC=%d f_ic=%b d_ic=%b e_ic=%b m_ic=%b w_ic=%b",clk,PC,f_icode,d_icode,e_icode,m_icode,w_icode);
  $monitor("clk=%d,pc=%d,m_valM=%d,e_valE=%d,f_icode=%d,reg[3]=%d",clock,PC,m_valM,e_valE,f_icode,regmem3);
  //$monitor("clk=%d,PC=%d,r3=%d,r0=%d,e_valE=%d,w_valE=%d",clock,PC,regmem3,regmem0,e_valE,w_valE);
endmodule
