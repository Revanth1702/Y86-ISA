module decode(clk,
             d_icode,d_ifun,d_rA,d_rB,d_dstM,D_stat,
             w_rA,w_rB,w_icode,w_dstE,w_dstM,w_valM,w_valE,
             d_valC,d_valP,
             m_cnd,m_valE,m_valM,m_dstM,m_dstE,m_icode,
             regmem0,regmem1,regmem2,regmem3,regmem4,regmem5,regmem6,regmem7,regmem8,regmem9,
             regmem10,regmem11,regmem12,regmem13,regmem14,regmem15,
             d_valA,d_valB,d_srcA,d_srcB,d_bubble,
             e_valE,E_icode,e_icode,e_ifun,e_rA,e_rB,e_valC,e_valP,e_valA,e_valB,e_dstE,e_dstM,E_stat,e_cnd);

input[3:0] d_icode,d_rA,d_rB,d_ifun,w_rA,w_rB,w_icode,d_dstM,e_icode,m_icode;
input [2:0] D_stat;
input e_cnd;
input [63:0] m_valE,m_valM,d_valC,d_valP;
output reg [63:0] d_valA,d_valB;
input clk,m_cnd;
input [63:0] e_valE,w_valM,w_valE;
output reg [3:0] d_srcA, d_srcB ;
reg [63:0] reg_mem[0:15];
input [3:0] e_dstE,m_dstM,m_dstE,w_dstM,w_dstE;
output reg [63:0] regmem0,regmem1,regmem2,regmem3,regmem4,regmem5,regmem6,regmem7,regmem8,regmem9,regmem10,regmem11;
output reg [63:0] regmem12,regmem13,regmem14,regmem15;
  output reg [3:0]  E_icode;
  output reg [3:0]  e_ifun;
  output reg [3:0]  e_rA;
  output reg [3:0]  e_rB;
  output reg [63:0] e_valC;
  output reg [63:0] e_valP;
  output reg [63:0] e_valA;
  output reg [63:0] e_valB;
  output reg [2:0]  E_stat;
  output reg [3:0]  e_dstM;
  output reg d_bubble = 0;

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

//reg_memA = R[d_rA];reg_memB = R[d_rB]; reg_mem4 = R[%rsp];  
always@(*)
   begin
      if((d_icode == 9 || e_icode == 9 || m_icode == 9) || (e_icode == 7 && e_cnd != 1)) 
      //return and mispredicted jump handling
      begin
         d_bubble = 1;
      end
   case(d_icode)
      4'b0010 : // Reg to Reg move or Cond.move
      begin
         d_valA = reg_mem[d_rA];
         d_valB = 64'b0;
      end

      4'b0100 : // Reg to Mem move
      begin
         d_valA = reg_mem[d_rA];
         d_valB = reg_mem[d_rB];
      end

      4'b0101 : //Mem to Reg move
      begin
         d_valB = reg_mem[d_rB];
      end

      4'b0110 : //OPq
      begin
         d_valA = reg_mem[d_rA];
         d_valB = reg_mem[d_rB];

         //$display("d_valA=%d d_valB=%d regmemA=%d regmemB=%d",d_valA,d_valB,reg_mem[d_rA],reg_mem[d_rB]);
      end

      4'b1000 : // Call
      begin
         d_valB = reg_mem[4];
      end

      4'b1001 : //Return
      begin
         d_valA = reg_mem[4];
      end

      4'b1010: //Push
      begin
         d_valA = reg_mem[d_rA];
         d_valB = reg_mem[4];
      end

      4'b1011://Pop
      begin
         d_valA = reg_mem[4];
         d_valB = reg_mem[4];
      end    
  endcase
      if(d_icode == 8 || d_icode == 7)
      d_valA = d_valP;
      else if(d_srcA == e_dstE)
      d_valA = e_valE;
      else if(d_srcA == m_dstM)
      d_valA = m_valM;
      else if(d_srcA == m_dstE)
      d_valA = m_valE;
      else if(d_srcA == w_dstM)
      d_valA = w_valM;
      else if(d_srcA == w_dstE)
      d_valA = w_valE;

      if(d_srcB == e_dstE) d_valB = e_valE;
      else if(d_srcB == m_dstM) d_valB = m_valM;
      else if(d_srcB == m_dstE) d_valB = m_valE;
      else if(d_srcB == w_dstM) d_valB = w_valM;
      else if(d_srcB == w_dstE) d_valB = w_valE;
    //  $display("\nd_valA=%d, d_valB = %d, rA = %d, rB = %d",reg_mem[d_rA],reg_mem[d_rB],d_rA,d_rB);
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

   case(w_icode)
  4'b0010 : // Reg to Reg move or Cond.move
     begin
         if(m_cnd)
        reg_mem[w_rB] = m_valE; 
        else
        reg_mem[w_rB] = 0;
     end 

  4'b0101 : //Mem to Reg move
      reg_mem[w_rA] = m_valM;

  4'b0011 : //Imm to reg move
  begin
      reg_mem[w_rB] = w_valE;
     // $display("\ninside immreg w_rb=%d",w_rB);
  end


  4'b0110 : //OPq
      reg_mem[w_rB] = w_valE;

   4'b1000 : // Call
      reg_mem[4] = m_valE;

   4'b1001 : //Return
      reg_mem[4] = m_valE;

   4'b1010: //Push
      reg_mem[4] = m_valE;

   4'b1011://Pop
    begin
        reg_mem[4] = m_valE;
        reg_mem[w_rA] = m_valM;
    end
  endcase
 // $display("\nw_rB=%d , w_valE = %d",w_rB,w_valE);
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
    E_icode   <=  d_icode;     
    e_ifun    <=  d_ifun;    
    e_rA      <=  d_rA;  
    e_rB      <=  d_rB;  
    e_valC    <=  d_valC;    
    e_valP    <=  d_valP;    
    e_valA    <=  d_valA;    
    e_valB    <=  d_valB;  
    E_stat    <=  D_stat;
    e_dstM    <=  d_dstM;
end

always@(*)
begin
   if(d_icode == 2 && d_ifun == 0)
   d_srcA = d_rA;
   else if(d_icode == 4 || d_icode == 6 || d_icode == 11)
   d_srcA = d_rA;
   else if(d_icode == 12 || d_icode == 9)
   d_srcA = 4;  
//$display("\nsrc=%d",srcA);
   if(d_icode == 4 || d_icode == 6 || d_icode == 5)
   d_srcB = d_rB;
   else if(d_icode == 12 || d_icode == 11 || d_icode == 8 || d_icode == 9)
   d_srcB = 4;
end
endmodule

