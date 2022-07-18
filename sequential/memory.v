module memory(clk,icode,valE,valP,valA,valM);
input clk;
input [3:0] icode;
input [63:0] valE,valP,valA;

output reg[63:0] valM;
output reg[0:512] data_mem = 0;// DEFINE SIZE 

always@(*)
begin
   case(icode)
  
  4'b0100 : // Reg to Mem move
  begin
     data_mem[valE] = valA;
  end

  4'b0101 : //Mem to Reg move
  begin
      valM = data_mem[valE];
  end

   4'b1000 : // Call
   begin
      data_mem[valE] = valP;
   end

   4'b1001 : //Return
   begin
       valM = data_mem[valA];
   end

   4'b1010: //Push
   begin
      data_mem[valE] = valA;
   end

   4'b1011://Pop
   begin
      valM = data_mem[valA];
   end
  endcase
end
endmodule