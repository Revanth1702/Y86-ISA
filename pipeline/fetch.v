module fetch(clk,PC,m_icode,m_ifun,m_cnd,m_valA,w_icode,w_valM,
             f_stat,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP,f_dstM,
             pc_pred,D_stat,d_icode,d_ifun,d_rA,d_rB,d_valC,d_valP,d_dstM,d_srcA,d_srcB,d_bubble,
             e_icode,e_dstM);
  input clk,m_cnd;
  input [63:0] PC;
  input [3:0] e_icode,e_dstM,d_srcA,d_srcB;
  input [3:0] m_icode,w_icode,m_ifun;
  input [63:0] m_valA,w_valM;
  input d_bubble;
  output reg[2:0] f_stat,D_stat;
  output reg [3:0] f_icode, f_ifun;
  output reg [3:0] f_rA, f_rB,f_dstM;
  output reg [63:0] f_valC, f_valP;
  output reg [3:0] d_icode, d_ifun;
  output reg [3:0] d_rA, d_rB,d_dstM;
  output reg [63:0] d_valC, d_valP;
  reg [0:7] inst_mem[0:512];
  reg [0:79] inst;
  reg hlt,inst_invalid,mem_error;
  output reg [63:0] pc_pred;

initial begin

  

//   inst_mem[0]=8'b00000000; //3 0

//  irmovq $0x385, %f_rbx

//Checking data forwarding
    inst_mem[1]=8'b00100000; //2 0  // icode = 2
    inst_mem[2]=8'b00100100; //2 4  //rrmove   
    inst_mem[3]=8'b01100000; //6 0  // icode = 6       
    inst_mem[4]=8'b00100100; //2 4          
    inst_mem[5]=8'b00110000; // 3 0 // icode = 3
    inst_mem[6]=8'b00010011; // 1 3
    inst_mem[7]=8'b00000000; // 0
    inst_mem[8]=8'b00000000; // 0
    inst_mem[9]=8'b00000000; // 0
    inst_mem[10]=8'b00000000; // 0
    inst_mem[11]=8'b00000000; // 0
    inst_mem[12]=8'b00000000; // 0
    inst_mem[13]=8'b00000000; // 0
    inst_mem[14]=8'b00000101; // 5 0
    inst_mem[15]=8'b00100000; //2 0  // icode = 2
    inst_mem[16]=8'b00100100; //2 4  //rrmove   
    inst_mem[17]=8'b01100000; //6 0  // icode = 6       
    inst_mem[18]=8'b00100100; //2 4          

//  // rrmovq 
//   inst_mem[11]=8'b00100000; //2 fn
//   inst_mem[12]=8'b01000010; //f_rA f_rB

//   inst_mem[13]=8'b01100000; // 1 0
//   inst_mem[14]=8'b00010010; // 1 2
//   inst_mem[15]=8'b01100001; // 1 0
//   inst_mem[16]=8'b00100001; // 2 1


  

    //Addq regm addq
    // inst_mem[19] = 8'b01100000;  // 6 0
    // inst_mem[20] = 8'b00110010;  // 3 2
    // inst_mem[21] = 8'b01100000;  // 6 0
    // inst_mem[22] = 8'b01100111;  // 6 7
    // inst_mem[23] = 8'b00100000;  // 2 0
    // inst_mem[24] = 8'b01100111;  // 6 7


    //Imm to Reg--Imm to Reg--AddQ
    // inst_mem[39]=8'b00110000; // 3 0
    // inst_mem[40]=8'b00010011; // 1 3
    // inst_mem[41]=8'b00000000; // 0 
    // inst_mem[42]=8'b00000000; // 0
    // inst_mem[43]=8'b00000000; // 0
    // inst_mem[44]=8'b00000000; // 0
    // inst_mem[45]=8'b00000000; // 0
    // inst_mem[46]=8'b00000000; // 0
    // inst_mem[47]=8'b00000000; // 0
    // inst_mem[48]=8'b00000101; // 5
    // inst_mem[49]=8'b00110000; // 3 0
    // inst_mem[50]=8'b00000000; // 0
    // inst_mem[51]=8'b00000000; // 0 0
    // inst_mem[52]=8'b00000000; // 0
    // inst_mem[53]=8'b00000000; // 0
    // inst_mem[54]=8'b00000000; // 0
    // inst_mem[55]=8'b00000000; // 0
    // inst_mem[56]=8'b00000000; // 0
    // inst_mem[57]=8'b00000000; // 0
    // inst_mem[58]=8'b00000110; // 6
    // inst_mem[59]=8'b01100000; // 6 0
    // inst_mem[60]=8'b00110000; // 3 0

    //Imm to Reg--Imm to Reg--Reg to Reg
    // inst_mem[39]=8'b00110000; // 3 0
    // inst_mem[40]=8'b00010011; // 1 3
    // inst_mem[41]=8'b00000000; // 1 0
    // inst_mem[42]=8'b00000000; // 1 0
    // inst_mem[43]=8'b00000000; // 1 0
    // inst_mem[44]=8'b00000000; // 1 0
    // inst_mem[45]=8'b00000000; //2 fn
    // inst_mem[46]=8'b00000000; //f_rA f_rB
    // inst_mem[47]=8'b00000000; // 1 0
    // inst_mem[48]=8'b00000101; // 5 0
    // inst_mem[49]=8'b00110000; // 3 0
    // inst_mem[50]=8'b00000000; // 1 0
    // inst_mem[51]=8'b00000000; // 3 0
    // inst_mem[52]=8'b00000000; // 1 3
    // inst_mem[53]=8'b00000000; // 1 0
    // inst_mem[54]=8'b00000000; // 1 0
    // inst_mem[55]=8'b00000000; // 1 0
    // inst_mem[56]=8'b00000000; // 1 0
    // inst_mem[57]=8'b00000000; //2 fn
    // inst_mem[58]=8'b00000110; //6
    // inst_mem[59]=8'b00100000; // 2 0
    // inst_mem[60]=8'b00110000; // 3 0
    // inst_mem[61]=8'b00110000; // 3 0
    // inst_mem[62]=8'b00010000; // 1 0

    //For checking load use hazard
    inst_mem[39]=8'b00110000; // 3 0 imm to reg
    inst_mem[40]=8'b00010011; // 1 3
    inst_mem[41]=8'b00000000; // 0
    inst_mem[42]=8'b00000000; // 0
    inst_mem[43]=8'b00000000; // 0
    inst_mem[44]=8'b00000000; // 0
    inst_mem[45]=8'b00000000; // 0
    inst_mem[46]=8'b00000000; // 0
    inst_mem[47]=8'b00000000; // 0
    inst_mem[48]=8'b00000101; // 5
    inst_mem[49]=8'b01010000; // 5 0 mem to reg
    inst_mem[50]=8'b00110000; // 3 0
    inst_mem[51]=8'b00000000; // 0
    inst_mem[52]=8'b00000000; // 0
    inst_mem[53]=8'b00000000; // 0
    inst_mem[54]=8'b00000000; // 0
    inst_mem[55]=8'b00000000; // 0
    inst_mem[56]=8'b00000000; // 0
    inst_mem[57]=8'b00000000; // 0
    inst_mem[58]=8'b00000000; //0 displacement = 0, so M[0] which has 0 => r3 which has 5
    inst_mem[59]=8'b01100000; // 6 0
    inst_mem[60]=8'b00110001; // 3 1 here sum shud be 1 because r3 = 0

//   //halt
//     inst_mem[45]=8'b00000000; // 0 0
  end

always @(posedge clk)
begin
    inst = {inst_mem[PC], inst_mem[PC+1], inst_mem[PC+2], inst_mem[PC+3], inst_mem[PC+4], 
            inst_mem[PC+5], inst_mem[PC+6], inst_mem[PC+7], inst_mem[PC+8], inst_mem[PC+9]};

    f_icode = inst[0:3];
    f_ifun = inst[4:7];
    mem_error=0;
    if(PC>512)
    mem_error = 1;

    inst_invalid= 0;

    case(f_icode)

        4'b0000 : //HALT
        begin 
            f_valP = PC + 64'd1;
            hlt = 1;       
        end

        4'b0001 : f_valP = PC + 64'd1; // NOP

        4'b0010 : // Reg to Reg move or Cond.move
        begin
            f_rA = inst[8:11];
            f_rB = inst[12:15];
            f_valP = PC + 64'd2;
        end

        4'b0011 : // Imm to Reg move
        begin
            f_rA = inst[8:11];
            f_rB = inst[12:15];
            f_valC = inst[16:79];
            f_valP = PC + 64'd10;
        end
  
        4'b0100 : // Reg to Mem move
        begin
            f_rA = inst[8:11];
            f_rB = inst[12:15];
            f_valC = inst[16:79];
            f_valP = PC + 64'd10;
        end

        4'b0101 : //Mem to Reg move
        begin
            f_rA = inst[8:11];
            f_rB = inst[12:15];
            f_valC = inst[16:79];
            f_valP = PC + 64'd10;
        end

        4'b0110 : //OPq
        begin
            f_rA = inst[8:11];
            f_rB = inst[12:15];
            f_valP = PC + 64'd2;
        end

        4'b0111 : //Jump
        begin 
            f_valC = inst[8:71];
            f_valP = PC + 64'd9;
        end

        4'b1000 : // Call
        begin
            f_valC = inst[8:71];
            f_valP = PC + 64'd9; 
        end

        4'b1001 : //Return
        begin
            f_valP = PC + 64'd1;
        end

        4'b1010: //Push
        begin
            f_rA = inst[8:11];
            f_rB = inst[12:15];
            f_valP = PC + 64'd2; 
            end

        4'b1011://Pop
        begin
            f_rA = inst[8:11];
            f_rB = inst[12:15];
            f_valP = PC + 64'd2; 
        end

        default : inst_invalid=1;
  endcase
end 

// predict PC
always@(*)
    begin
        if(e_icode == 5 || e_icode ==12)
        begin
        //$display("\ninside if1");
        if(e_dstM == d_srcA || e_dstM == d_srcB)
        begin
        //$display("\ninside if2");
        pc_pred = PC;
        end 
        end
        if(e_icode == 9 || d_icode == 9 || m_icode ==9)
        begin
            pc_pred = PC;
        end
        else
        begin
        case(f_icode)

        4'b0000 : //HALT
        begin   
            pc_pred = f_valP;   
        end

        4'b0001 : pc_pred = f_valP;// NOP

        4'b0010 : // Reg to Reg move or Cond.move
        begin
            pc_pred = f_valP;
        end

        4'b0011 : // Imm to Reg move
        begin
            pc_pred = f_valP;
        end
  
        4'b0100 : // Reg to Mem move
        begin
            pc_pred = f_valP;
        end

        4'b0101 : //Mem to Reg move
        begin
            pc_pred = f_valP;
        end

        4'b0110 : //OPq
        begin
            pc_pred = f_valP;
        end

        4'b0111 : //Jump
        begin 
            pc_pred = f_valC;
        end

        4'b1000 : // Call
        begin
            pc_pred = f_valC; 
        end

        // 4'b1001 : //Return
        // begin
        //     f_valP = PC + 64'd1;
        // end

        4'b1010: //Push
        begin
            pc_pred = f_valP;
            end

        4'b1011://Pop
        begin
            pc_pred = f_valP; 
        end
  endcase
  if(m_icode == 7)
  begin
      if(m_ifun > 0 && m_cnd !=1)
      pc_pred = m_valA;
  end
  else if(w_icode == 9)
      pc_pred = w_valM;
         end
end

//Status codes
always@(*)
begin
    if(hlt == 1)
    f_stat = 2'b01;
    else if(mem_error==1)
    f_stat = 2'b10;
    else if(inst_invalid==1)
    f_stat = 2'b11;
    else f_stat = 2'b00;
end

always@(*)
begin
   if(f_icode == 5 || f_icode == 11)
   f_dstM = f_rA;
end

always@(negedge clk)
    begin
        if(d_bubble == 1)
        begin
            d_icode <= 1; //Adding Bubble to decode stage
        end
        else
        begin
            d_icode <= f_icode;
        end
        d_ifun  <= f_ifun;
        d_rA    <= f_rA;
        d_rB    <= f_rB;
        d_valC  <= f_valC;
        d_valP  <= f_valP;
        D_stat  <= f_stat;
    end
endmodule


