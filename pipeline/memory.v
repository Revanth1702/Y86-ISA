module memory(clk,M_icode,m_icode,m_ifun,m_rA,m_rB,m_valC,m_valP,m_valA,m_valB,m_cnd,m_valE,m_valM,m_dstM,M_stat,m_stat,
              w_icode,w_ifun,w_rA,w_rB,w_valC,w_valP,w_valA,w_valB,w_cnd,w_valE,w_valM,w_dstM,W_stat);
input clk;
input [3:0] M_icode,m_ifun,m_rA,m_rB;
input [2:0] M_stat;
input [63:0] m_valE,m_valP,m_valA,m_valC,m_valB;
input m_cnd;
output reg[63:0] m_valM;
output reg[0:1024] data_mem = 0;// DEFINE SIZE 
  output reg [3:0]  w_icode,m_icode;
  output reg [3:0]  w_ifun;
  output reg [3:0]  w_rA;
  output reg [3:0]  w_rB;
  output reg [63:0] w_valC;
  output reg [63:0] w_valP;
  output reg [63:0] w_valA;
  output reg [63:0] w_valB;
  output reg        w_cnd;
  output reg [63:0] w_valE;
  output reg [63:0] w_valM;
  output reg [3:0]  w_dstM;
  input [3:0]  m_dstM;
  output reg [2:0]  m_stat;
  output reg [2:0]  W_stat;
  reg read = 0;
always@(*)
begin

   if(M_icode == 4 || M_icode == 5 || M_icode == 9 ||M_icode == 12 || M_icode ==8 || M_icode == 10)
   begin
   read = 1;
   end
   case(M_icode)
  
  4'b0100 : // Reg to Mem move
  begin
     data_mem[m_valE] = m_valA;
  end

  4'b0101 : //Mem to Reg move
  begin
      m_valM = data_mem[m_valE];
  end

   4'b1000 : // Call
   begin
      data_mem[m_valE] = m_valP;
   end

   4'b1001 : //Return
   begin
       m_valM = data_mem[m_valA];
   end

   4'b1010: //Push
   begin
      data_mem[m_valE] = m_valA;
   end

   4'b1011://Pop
   begin
      m_valM = data_mem[m_valA];
   end
  endcase
end
always@(*)
begin
   m_icode = M_icode;
end
always@(negedge clk)
begin
    w_icode   <=   M_icode;
    w_ifun    <=   m_ifun;
    w_rA      <=   m_rA;
    w_rB      <=   m_rB;
    w_valC    <=   m_valC;
    w_valP    <=   m_valP;
    w_valA    <=   m_valA;
    w_valB    <=   m_valB;
    w_cnd     <=   m_cnd;
    w_valE    <=   m_valE;
    w_valM    <=   m_valM;
    w_dstM    <=   m_dstM;
    W_stat    <=   m_stat;
end
//Status codes
always@(*)
begin
   if((m_valE>1024 && read==1)||(m_valE<0 && read == 1))
   begin
      m_stat = 2'b10;
   end
   else  m_stat = M_stat;
end
// always@(*)
// begin
//    if(m_icode == 5 || m_icode == 11)
//    m_dstM = m_rA;
// end
endmodule