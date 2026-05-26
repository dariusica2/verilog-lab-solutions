module task0(
    output c,
    output d,
    input a,
    input b
    );
    
    xor(c, a, b);
    xnor(d, a, b);
    
endmodule
