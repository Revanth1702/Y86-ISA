module pcupdate(clk,valP,valC,valM,cnd,icode,PC);
input clk,cnd;
input [3:0] icode;
input [63:0] valP,valC,valM;
output reg[63:0] PC;

always@(*)
begin
    if (icode == 4'b0111) //Jump
    begin
        if(cnd)
        PC = valC;
        else 
        PC = valP;
    end

    else if (icode == 4'b1000) //Call
    PC = valC;

    else if(icode == 4'b1001) //Return
    PC = valM;

    else // Rest all instructions
    PC = valP;

end
endmodule