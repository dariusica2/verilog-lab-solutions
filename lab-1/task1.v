module task1(
    output c,
    input a,
    input b
    );
    
    wire nota;
    wire notb;
    wire t1;
    wire t2;
    
    // Descriere la nivel structural
    
    not(nota, a);
    not(notb, b);
    
    or(t1, nota, b);
    or(t2, a, notb);
    
    and(c, t1, t2);
    
endmodule
