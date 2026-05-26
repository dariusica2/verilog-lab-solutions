module task3(
    output out,
    input i1,
    input i2,
    input s1,
    input s2
    );
    
    wire nor_res;
    nor(nor_res, i1, i2);
    
    wire nand_res;
    nand(nand_res, i1, i2);
    
    wire or_res;
    or(or_res, i1, i2);
    
    wire xnor_res;
    task1 t1 (
        xnor_res,
        i1,
        i2
    );
    
    task2 t2 (
        out,
        i1,
        i2,
        nor_res,
        nand_res,
        or_res,
        xnor_res
    );
    
endmodule
