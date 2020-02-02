---
---	ULA MIPS - OAC
---	Autor: Michelangelo da Rocha Machado - 14/0156089
---

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity ULA is
	generic (WSIZE : natural := 32);
	port
	(
		ctrl_opcode : in std_logic_vector(3 downto 0);
		A				: in std_logic_vector(WSIZE-1 downto 0);
		B 				: in std_logic_vector(WSIZE-1 downto 0);
		Z 				: out std_logic_vector(WSIZE-1 downto 0);
		zero			: out std_logic;
		ovfl 			: out std_logic
	);
end ULA;

architecture behavior of ULA is

	signal A_aux, B_aux, C_aux, D_aux	: std_logic_vector(WSIZE downto 0);
	signal aux_OUT 						: std_logic_vector(WSIZE-1 downto 0);
	
begin

	Z 		<= aux_OUT;
	A_aux 	<= A(WSIZE-1) & A; --- extendendo sinal
	B_aux 	<= B(WSIZE-1) & B; --- extendendo sinal
	C_aux 	<= A_aux + B_aux;
	D_aux 	<= A_aux - B_aux;
	
	process(aux_OUT) 
	begin
		if aux_OUT = X"00000000" then
			zero <= '1';
		else
			zero <= '0';
		end if;
	end process;
	
	process(A,A_aux,B,B_aux,C_aux,D_aux,ctrl_opcode,aux_OUT)
	begin
		--- deteccao de overflow BEGIN
		if(ctrl_opcode = "0010") then
			if((A_aux>0 and B_aux>0 and C_aux(WSIZE-1 downto 0) < 0)
			 or(A_aux<0 and B_aux<0 and C_aux(WSIZE-1 downto 0) > 0)
			 or(A_aux(31)=B_aux(31) and C_aux(31)/=A_aux(31))
			 or(A_aux(32) /= A_aux(31)))then
				ovfl <= '1';
			else
				ovfl <= '0';
			end if;
		else 
			if(ctrl_opcode = "0100") then
				if((A_aux<0 and B_aux>0 and D_aux(WSIZE-1 downto 0) > 0)
				or(A_aux>0 and B_aux<0 and D_aux(WSIZE-1 downto 0) < 0))then
					ovfl <= '1';
				else
					ovfl <= '0';
				end if;
			else
				ovfl <= '0';
			end if;
		end if;
		--- deteccao de overflow END
		
		case ctrl_opcode is
			when "0000" => aux_OUT <= A AND B;
			when "0001" => aux_OUT <= A OR B;
			when "0010" => aux_OUT <= A + B;
			when "0011" => aux_OUT <= A + B; -- nao aciona overflow
			when "0100" => aux_OUT <= A - B;
			when "0101" => aux_OUT <= A - B; -- nao aciona overflow
			when "0110" => if (to_integer(signed(A)) < to_integer(signed(B))) then aux_OUT <= X"00000001"; else aux_OUT <= X"00000000"; end if;
			when "0111" => aux_OUT <= A NAND B;
			when "1000" => aux_OUT <= A NOR B;
			when "1001" => aux_OUT <= A XOR B;
			when "1010" => aux_OUT <= std_logic_vector(shift_left(signed(B), To_integer(signed(A))));
			when "1011" => aux_OUT <= std_logic_vector(shift_right(unsigned(B), To_integer(signed(A))));			
			when "1100" => aux_OUT <= std_logic_vector(shift_right(signed(B), To_integer(signed(A))));
			when others => aux_OUT <= X"00000000";
		end case;
	end process;
end behavior;