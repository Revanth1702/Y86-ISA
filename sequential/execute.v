`include "ALU.v"
module execute(icode,ifun,clk,valA,valB,valC,valE,cnd);
input [3:0] icode,ifun;
input [63:0] valA, valB, valC;
input clk;
output reg [63:0] valE;
output reg cnd;

reg zf,sf,of;
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
    if(icode == 4'b0110)
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
case(icode)

  4'b0010 : // Reg to Reg move or Cond.move
  begin
    case(ifun)

      4'b0000: //Reg to Reg mov
      cnd = 1;

      4'b0001: //Cmovle
      begin
         if(o1) cnd = 1;
         else if(zf) cnd = 1;   
      end

      4'b0010: //Cmovl
          if(o1) cnd =1;
    
      4'b0011: //Cmove
          if(zf) cnd =1;

      4'b0100: //Cmovne
        if(!zf) cnd =1;

      4'b0101: //Cmovge
        if(!o1) cnd =1;
    
      4'b0110: //Cmovg
      begin
          if(!o1)
          if(!zf) cnd =1;
      end
    endcase

      valE = valA + valB;
  end

  4'b0011 : // Imm to Reg move
  begin
      valE = 63'b0 + valC;
  end
  
  4'b0100 : // Reg to Mem move
  begin
      valE = valB + valC;
  end

  4'b0101 : //Mem to Reg move
  begin
      valE = valB + valC;
  end

  4'b0110 : //OPq
  begin
      case(ifun)
          4'b0000: //ADD
          begin
              control <= 2'b00;
              a <= valA;
              b <= valB;
          end

           4'b0001: //SUB
          begin
              control = 2'b01;
              a = valB;
              b = valA;
          end

           4'b0010: //AND
          begin
              control = 2'b11;
              a = valA;
              b = valB;
          end

           4'b0011: //XOR
          begin
              control = 2'b10;
              a = valA;
              b = valB;
          end
      endcase
      valE = ans;
   end

   4'b0111: //Jump
   begin 
    case(ifun)

      4'b0000: //Jump
      cnd = 1;

      4'b0001: //Jmple
      begin
         if(o1) cnd = 1;
         else if(zf) cnd = 1;   
      end

      4'b0010: //Jmpl
          if(o1) cnd =1;
    
      4'b0011: //Jmpe
          if(zf) cnd =1;

      4'b0100: //Jmpne
        if(!zf) cnd =1;

      4'b0101: //Jmpge
        if(!o1) cnd =1;
    
      4'b0110: //Jmpg
      begin
          if(!o1)
          if(!zf) cnd =1;
      end
    endcase           
   end
   4'b1000 : // Call
   valE = -64'd8 + valB;

   4'b1001 : //Return
   valE = 64'd8 + valA; 

   4'b1010: //Push
   valE = -64'd8 + valB;

   4'b1011://Pop
   valE = 64'd8 + valA; 

  endcase
end
endmodule
