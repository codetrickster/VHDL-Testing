ENTITY exemplo2 IS
  PORT(
  a, b, c: in bit;
  s: out bit
  );
end exemplo2;
architecture arq_exemplo2 of exemplo2 is
begin 
  s <= not(a and b) or not(c);
end arq_exemplo2;