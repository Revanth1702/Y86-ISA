module Add(A,B,SUM,CARRY_OVERFLOW);

    input signed [63:0]A,B;
    output signed [63:0] SUM;
    
    wire [64:0]CARRY;
    wire [63:0]P,Q,R;
    output CARRY_OVERFLOW;
  
    assign CARRY[0] = 1'b0;

    genvar i;

    generate for(i=0;i<64;i=i+1)
        begin
            xor G1(SUM[i],A[i],B[i],CARRY[i]);     //SUM = a^b^Cin
            and G2(P[i],A[i],B[i]);            
            and G3(Q[i],B[i],CARRY[i]);
            and G4(R[i],A[i],CARRY[i]);
            or G5(CARRY[i+1],P[i],Q[i],R[i]);      // CARRY = ab + bc + ac
        end
    endgenerate
    
    xor g2(CARRY_OVERFLOW,CARRY[63],CARRY[64]);
    
endmodule
