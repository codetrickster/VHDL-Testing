ENTITY exemplo3 IS
  PORT(
  a, b, c: in bit;
  s: out bit
  );
end exemplo3;
architecture arq_exemplo3 of exemplo3 is
begin 
  s <= not(a and b) or not(not(c));
end arq_exemplo3;