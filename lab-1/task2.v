module task2(
    output out,
    input i1,
    input i2,
    input i3,
    input i4,
    input s1,
    input s2
    );
    
    // Descriere la nivel flux de date
    // assign = atribuire continua
    
    assign out = (~s1 & ~s2 & i1) |
                 (~s1 & s2 & i2)  |
                 (s1 & ~s2 & i3)  |
                 (s1 & s2 & i4);
    
endmodule
