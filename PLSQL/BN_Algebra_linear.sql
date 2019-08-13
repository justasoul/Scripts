
-- http://oracledmt.blogspot.pt/2007/04/way-cool-linear-algebra-in-oracle.html


/*


-> xDiasBoston yDiasNovaYork  = 7
-> 300 * xDiasBoston + 675 * yDiasNovaYork = 2850

sob o formato de matrix: 

A: | 1, 1          |   X: | xDiasBoston    |  B: | 7 
   | 300, 675      |      | yDiasNovaYork  |     | 2850 

ou 

A: | 1, 1          |   X: | xDiasBoston, yDiasNovaYork    |  B: | 7 
   | 300, 675      |      |                               |     | 2850 


*/

declare
  matrixA utl_nla_array_dbl :=  utl_nla_array_dbl (
                                    1,300
                                  , 1, 675 
                                );

  matrixB utl_nla_array_dbl :=  utl_nla_array_dbl (
                                    7, 2850
                                );

  ipiv utl_nla_array_int := utl_nla_array_int(0, 0);

  res INTEGER;
begin

  UTL_NLA.LAPACK_GESV (
    n      => 2,    -- A number of rows and columns
    nrhs   => 1,    -- B number of columns
    a      => matrixA,    -- matrix A
    lda    => 2,    -- max(1, n)
    ipiv   => ipiv, -- pivot indices (set to zeros)
    b      => matrixB,    -- matrix B
    ldb    => 2,    -- ldb >= max(1,n)
    info   => res, -- operation status (0=sucess)
    pack   => 'C'   -- how the matrices are stored 
                    -- (C=column-wise)
  );

  if res = 0 then  -- success
    FOR i IN 1..matrixB.count LOOP
      dbms_output.put_line('x' || i ||'= ' ||  to_char(matrixB (i), '99.99') );
    END LOOP;     
  end if; 

end; 