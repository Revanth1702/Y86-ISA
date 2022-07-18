`include "ALU.v"
module execute(clk,d_srcA,d_srcB,E_icode,e_icode,e_ifun,e_rA,e_rB,e_valC,e_valP,e_valA,e_valB,e_cnd,e_valE,e_dstE,e_dstM,E_stat,
             M_icode,m_ifun,m_rA,m_rB,m_valC,m_valP,m_valA,m_valB,m_cnd,m_valE,m_dstE,m_dstM,M_stat);
input [3:0] E_icode,e_ifun,e_rA,e_rB,e_dstM;
reg [3:0] ee_icode;
input [2:0] E_stat;
input [3:0] d_srcA,d_srcB;
input [63:0] e_valA, e_valB, e_valC,e_valP;
input clk;
output reg [63:0] e_valE;
output reg e_cnd;
output reg [3:0] e_icode;
  output reg [3:0]  M_icode;
  output reg [3:0]  m_ifun;
  output reg [3:0]  m_rA;
  output reg [3:0]  m_rB;
  output reg [63:0] m_valC;
  output reg [63:0] m_valP;
  output reg [63:0] m_valA;
  output reg [63:0] m_valB;
  output reg        m_cnd;
  output reg [63:0] m_valE;
  output reg [3:0] e_dstE,m_dstE;
  output reg [2:0] M_stat;
  output reg [3:0] m_dstM;
reg zf,sf,of;
reg load = 0;
reg[1:0] control;
reg signed[63:0] t,a,b;
wire signed [63:0] ans;
wire overflow;
initial 
begin
    zf = 0;
    of = 0;
    sf = 0;
    a = 63'b0;
    b = 63'b0;
    control = 2'b00;
end

always@(*)
begin
    if(E_icode == 4'b0110)
    begin
        zf = (ans == 63'b0);
        sf = (ans < 1'b0);
        of = (a<1'b0 == b<1'b0)&&(ans<1'b0!=a<1'b0);
    end
    
end

alu alu1(.control(control),.a(a),.b(b),.end_result(ans),.carry_overflow(overflow));

wire o1;

xor(o1,sf,of);

always@(*)
begin
  if(load == 1)
  ee_icode = 1; //Inserting NOP to handle Load Use Hazard
  else
  begin
case(E_icode)

  4'b0010 : // Reg to Reg move or Cond.move
  begin
    case(e_ifun)

      4'b0000: //Reg to Reg mov
      e_cnd = 1;

      4'b0001: //Cmovle
      begin
         if(o1) e_cnd = 1;
         else if(zf) e_cnd = 1;   
      end

      4'b0010: //Cmovl
          if(o1) e_cnd =1;
    
      4'b0011: //Cmove
          if(zf) e_cnd =1;

      4'b0100: //Cmovne
        if(!zf) e_cnd =1;

      4'b0101: //Cmovge
        if(!o1) e_cnd =1;
    
      4'b0110: //Cmovg
      begin
          if(!o1)
          if(!zf) e_cnd =1;
      end
    endcase

      e_valE = e_valA + e_valB;
  end

  4'b0011 : // Imm to Reg move
  begin
      e_valE = 63'b0 + e_valC;
  end
  
  4'b0100 : // Reg to Mem move
  begin
      e_valE = e_valB + e_valC;
  end

  4'b0101 : //Mem to Reg move
  begin
      e_valE = e_valB + e_valC;
  end

  4'b0110 : //OPq
  begin
      case(e_ifun)
          4'b0000: //ADD
          begin
              control <= 2'b00;
              a <= e_valA;
              b <= e_valB;
          end

           4'b0001: //SUB
          begin
              control = 2'b01;
              a = e_valB;
              b = e_valA;
          end

           4'b0010: //AND
          begin
              control = 2'b11;
              a = e_valA;
              b = e_valB;
          end

           4'b0011: //XOR
          begin
              control = 2'b10;
              a = e_valA;
              b = e_valB;
          end
      endcase
      e_valE = ans;
   end

   4'b0111: //Jump
   begin 
    case(e_ifun)

      4'b0000: //Jump
      e_cnd = 1;

      4'b0001: //Jmple
      begin
         if(o1) e_cnd = 1;
         else if(zf) e_cnd = 1;   
      end

      4'b0010: //Jmpl
          if(o1) e_cnd =1;
    
      4'b0011: //Jmpe
          if(zf) e_cnd =1;

      4'b0100: //Jmpne
        if(!zf) e_cnd =1;

      4'b0101: //Jmpge
        if(!o1) e_cnd =1;
    
      4'b0110: //Jmpg
      begin
          if(!o1)
          if(!zf) e_cnd =1;
      end
    endcase           
   end
   4'b1000 : // Call
   e_valE = -64'd8 + e_valB;

   4'b1001 : //Return
   e_valE = 64'd8 + e_valA; 

   4'b1010: //Push
   e_valE = -64'd8 + e_valB;

   4'b1011://Pop
   e_valE = 64'd8 + e_valA; 

  endcase
  end
end

always@(negedge clk)
begin
  if(load == 1)
    M_icode  <=   ee_icode;
  else
    M_icode  <=   E_icode;
    m_ifun   <=   e_ifun;
    m_rA     <=   e_rA;
    m_rB     <=   e_rB;
    m_valC   <=   e_valC;
    m_valP   <=   e_valP;
    m_valA   <=   e_valA;
    m_valB   <=   e_valB;
    m_cnd    <=   e_cnd;
    m_valE   <=   e_valE;
    m_dstE   <=   e_dstE;
    M_stat   <=   E_stat;
    m_dstM   <=   e_dstM;
end
always @(*) begin
  if(E_icode == 2 && e_ifun == 0)  
  e_dstE = e_rB;
  else if(E_icode == 3 || E_icode==6)
  e_dstE = e_rB;
  else if(E_icode == 11 || E_icode == 12 ||E_icode ==8 || E_icode ==9)
  e_dstE = 4;
end

// Load Use Hazard
initial
begin
  if(E_icode == 5 || E_icode == 12)
  begin
  if(e_dstM == d_srcA || e_dstM == d_srcB)
  begin
  load = 1;
  end
  end
end
always@(*)
begin
   e_icode = E_icode;
  //$display("\ne_icode=%d",e_icode);
end


endmodule
