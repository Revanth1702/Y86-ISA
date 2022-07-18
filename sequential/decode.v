module decode(icode,clk,rA,rB,cnd,valE,valM,regmem0,regmem1,regmem2,regmem3,regmem4,regmem5,regmem6,regmem7,regmem8,regmem9,
               regmem10,regmem11,regmem12,regmem13,regmem14,regmem15,valA,valB);

input[3:0] icode,rA,rB;
input [63:0] valE,valM;
output reg [63:0] valA,valB;
input clk,cnd;
reg [63:0] reg_mem[0:15];
output reg [63:0] regmem0,regmem1,regmem2,regmem3,regmem4,regmem5,regmem6,regmem7,regmem8,regmem9,regmem10,regmem11;
output reg [63:0] regmem12,regmem13,regmem14,regmem15;
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
    reg_mem[15]=64'd15;
end

//reg_memA = R[rA];reg_memB = R[rB]; reg_mem4 = R[%rsp];  
always@(*)
   begin
   case(icode)
      4'b0010 : // Reg to Reg move or Cond.move
      begin
         valA = reg_mem[rA];
         valB = 64'b0;
      end

      4'b0100 : // Reg to Mem move
      begin
         valA = reg_mem[rA];
         valB = reg_mem[rB];
      end

      4'b0101 : //Mem to Reg move
      begin
         valB = reg_mem[rB];
      end

      4'b0110 : //OPq
      begin
         valA = reg_mem[rA];
         valB = reg_mem[rB];

         //$display("valA=%d valB=%d regmemA=%d regmemB=%d",valA,valB,reg_mem[rA],reg_mem[rB]);
      end

      4'b1000 : // Call
      begin
         valB = reg_mem[4];
      end

      4'b1001 : //Return
      begin
         valA = reg_mem[4];
      end

      4'b1010: //Push
      begin
         valA = reg_mem[rA];
         valB = reg_mem[4];
      end

      4'b1011://Pop
      begin
         valA = reg_mem[4];
      end
  endcase
    regmem0=reg_mem[0];
    regmem1=reg_mem[1];
    regmem2=reg_mem[2];
    regmem3=reg_mem[3];
    regmem4=reg_mem[4];
    regmem5=reg_mem[5];
    regmem6=reg_mem[6];
    regmem7=reg_mem[7];
    regmem8=reg_mem[8];
    regmem9=reg_mem[9];
    regmem10=reg_mem[10];
    regmem11=reg_mem[11];
    regmem12=reg_mem[12];
    regmem13=reg_mem[13];
    regmem14=reg_mem[14];
    regmem15=reg_mem[15];
end


always@(negedge clk)
begin

   case(icode)

  4'b0010 : // Reg to Reg move or Cond.move
     begin
         if(cnd)
        reg_mem[rB] = valE; 
        else
        reg_mem[rB] = 0;
     end 

  4'b0101 : //Mem to Reg move
      reg_mem[rA] = valM;

  4'b0011 : //Imm to reg move
      reg_mem[rB] = valE;

  4'b0110 : //OPq
      reg_mem[rB] = valE;

   4'b1000 : // Call
      reg_mem[4] = valE;

   4'b1001 : //Return
      reg_mem[4] = valE;

   4'b1010: //Push
      reg_mem[4] = valE;

   4'b1011://Pop
    begin
        reg_mem[4] = valE;
        reg_mem[rA] = valM;
    end
  endcase
    regmem0=reg_mem[0];
    regmem1=reg_mem[1];
    regmem2=reg_mem[2];
    regmem3=reg_mem[3];
    regmem4=reg_mem[4];
    regmem5=reg_mem[5];
    regmem6=reg_mem[6];
    regmem7=reg_mem[7];
    regmem8=reg_mem[8];
    regmem9=reg_mem[9];
    regmem10=reg_mem[10];
    regmem11=reg_mem[11];
    regmem12=reg_mem[12];
    regmem13=reg_mem[13];
    regmem14=reg_mem[14];
    regmem15=reg_mem[15];
end
endmodule
