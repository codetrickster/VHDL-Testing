ENTITY exemplo1 IS
  PORT(
  a: in bit;
  s: out bit
  );
end exemplo1;
architecture arq_exemplo1 of exemplo1 is
begin 
  s <= a;
end arq_exemplo1;