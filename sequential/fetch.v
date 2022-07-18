module fetch(clk,PC,icode,ifun,rA,rB,valP,valC,hlt,inst_valid,mem_error);
  input clk;
  input [63:0] PC;
  output reg [3:0] icode, ifun;
  output reg [3:0] rA, rB;
  output reg [63:0] valC, valP;
  reg [0:7] inst_mem[0:512];
  reg [0:79] inst;
  output reg hlt,inst_valid,mem_error;

initial begin

  

//   inst_mem[0]=8'b00000000; //3 0

//  irmovq $0x385, %rbx

  inst_mem[1]=8'b00110000; //3 0
  inst_mem[2]=8'b00100100; //2 4       
  inst_mem[3]=8'b00000000;           
  inst_mem[4]=8'b00000000;           
  inst_mem[5]=8'b00000000;           
  inst_mem[6]=8'b00000000;           
  inst_mem[7]=8'b00000000;           
  inst_mem[8]=8'b00000000;          
  inst_mem[9]=8'b00000001; 
  inst_mem[10]=8'b10000001;//imm = 385

 // rrmovq 
  inst_mem[11]=8'b00100000; //2 fn
  inst_mem[12]=8'b01000010; //rA rB

//   inst_mem[13]=8'b01100000; // 1 0
//   inst_mem[14]=8'b00010010; // 1 2
//   inst_mem[15]=8'b01100001; // 1 0
//   inst_mem[16]=8'b00100001; // 2 1


  

    //Addq regm addq
    inst_mem[19] = 8'b01100000;  // 6 0
    inst_mem[20] = 8'b00110010;  // 3 2
    inst_mem[21] = 8'b01100000;  // 6 0
    inst_mem[22] = 8'b01100111;  // 6 7
    inst_mem[23] = 8'b00100000;  // 2 0
    inst_mem[24] = 8'b01100111;  // 6 7

    
//   //cmovxx
//     inst_mem[37]=8'b00100000; //2 fn
//     inst_mem[38]=8'b00000100; //rA rB

//     inst_mem[39]=8'b00010000; // 1 0
//     inst_mem[40]=8'b00010000; // 1 0
//     inst_mem[41]=8'b00010000; // 1 0
//     inst_mem[42]=8'b00010000; // 1 0
//     inst_mem[43]=8'b00010000; // 1 0
//     inst_mem[44]=8'b00010000; // 1 0

//   //halt
//     inst_mem[45]=8'b00000000; // 0 0
  end

always @(posedge clk)
begin
    inst ={inst_mem[PC], inst_mem[PC+1], inst_mem[PC+2], inst_mem[PC+3], inst_mem[PC+4], 
             inst_mem[PC+5], inst_mem[PC+6], inst_mem[PC+7], inst_mem[PC+8], inst_mem[PC+9]};

    icode = inst[0:3];
    ifun = inst[4:7];
    mem_error=0;
    if(PC>512)
    mem_error = 1;

    inst_valid= 1;

    case(icode)

        4'b0000 : //HALT
        begin 
            valP = PC + 64'd1;
            hlt = 1;       
        end

        4'b0001 : valP = PC + 64'd1; // NOP

        4'b0010 : // Reg to Reg move or Cond.move
        begin
            rA = inst[8:11];
            rB = inst[12:15];
            valP = PC + 64'd2;
        end

        4'b0011 : // Imm to Reg move
        begin
            rA = inst[8:11];
            rB = inst[12:15];
            valC = inst[16:79];
            valP = PC + 64'd10;
        end
  
        4'b0100 : // Reg to Mem move
        begin
            rA = inst[8:11];
            rB = inst[12:15];
            valC = inst[16:79];
            valP = PC + 64'd10;
        end

        4'b0101 : //Mem to Reg move
        begin
            rA = inst[8:11];
            rB = inst[12:15];
            valC = inst[16:79];
            valP = PC + 64'd10;
        end

        4'b0110 : //OPq
        begin
            rA = inst[8:11];
            rB = inst[12:15];
            valP = PC + 64'd2;
        end

        4'b0111 : //Jump
        begin 
            valC = inst[8:71];
            valP = PC + 64'd9;
        end

        4'b1000 : // Call
        begin
            valC = inst[8:71];
            valP = PC + 64'd9; 
        end

        4'b1001 : //Return
        begin
            valP = PC + 64'd1;
        end

        4'b1010: //Push
        begin
            rA = inst[8:11];
            rB = inst[12:15];
            valP = PC + 64'd2; 
            end

        4'b1011://Pop
        begin
            rA = inst[8:11];
            rB = inst[12:15];
            valP = PC + 64'd2; 
        end

        default : inst_valid=0;
  endcase
end 
endmodule

