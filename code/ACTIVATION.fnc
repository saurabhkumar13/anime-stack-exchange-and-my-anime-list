CREATE OR REPLACE FUNCTION activation_func(a float) 
   RETURN float DETERMINISTIC IS
BEGIN 
  RETURN 2/(1+EXP(-2*a)) - 1;
END;
CREATE OR REPLACE FUNCTION activation_der(activated_val float) 
   RETURN float DETERMINISTIC IS
BEGIN 
  RETURN (1-activated_val*activated_val);
END;
CREATE OR REPLACE FUNCTION activation_reg_softplus_func(a float) 
   RETURN float DETERMINISTIC IS
BEGIN 
  RETURN ln(1+EXP(a));
END;
CREATE OR REPLACE FUNCTION activation_reg_softplus_der(activated_val float) 
   RETURN float DETERMINISTIC IS
BEGIN 
  RETURN 1-EXP(-activated_val);
END;
//