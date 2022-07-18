`include "Add.v"
`include "sub.v"
`include "Xor.v"
`include "And.v"

module alu(control,a,b,end_result,carry_overflow);

input [1:0]control;
input signed [63:0]a,b;
output reg signed [63:0] end_result;
output reg carry_overflow;

// to store the final result of each operation!!!
wire signed [63:0]add_result,sub_result,xor_result,and_result; //

// calling each function for every input a,b
Xor s3(a,b,xor_result);
And s4(a,b,and_result);
Sub s2(a,b,sub_result,carry_overflow_sub);
Add s1(a,b,add_result,carry_overflow_add);///

always @(*) begin
    case(control)
    2'b00:begin
        end_result = add_result;
        carry_overflow = carry_overflow_add; 
    end
    2'b01:begin
        end_result = sub_result;
        carry_overflow = carry_overflow_sub;
    end
    2'b10:begin
        end_result = and_result;
        carry_overflow = 0;
    end
    2'b11:begin
        end_result = xor_result;
        carry_overflow = 0;
    end
    endcase
end
endmodule
