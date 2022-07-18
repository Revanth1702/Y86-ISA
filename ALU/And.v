module And(A,B,OUT);

    input signed [63:0]A,B;
    output signed [63:0] OUT;
 

    genvar i;

    generate for(i=0;i<64;i=i+1)
        begin
              //SUM = a^b^Cin
            and G1(OUT[i],A[i],B[i]);            
              // CARRY = ab + bc + ac
        end
    endgenerate
    
    
endmodule
