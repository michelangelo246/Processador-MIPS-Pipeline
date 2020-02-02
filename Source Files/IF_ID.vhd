---
---	IF_ID MIPS - OAC
---	Autor: Michelangelo da Rocha Machado - 14/0156089
---

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

Entity IF_ID is
	generic (WSIZE : natural := 32);
	
   Port
	(
		--- entradas ---
		clk				:	in std_logic;								
		PC_4				:	in std_logic_vector(31 downto 0);	--- FETCH
		Instrucao		:	in std_logic_vector(31 downto 0);	--- FETCH
		
		--- saidas ---
		PC_4_out			:	out std_logic_vector(31 downto 0);	--- DECODE
		Instrucao_out	:	out std_logic_vector(31 downto 0)	--- DECODE
		
	);
end IF_ID;

architecture behavior of IF_ID is
	
begin
	
	process(clk)
		begin
			IF rising_edge(clk) THEN
            PC_4_out 		<= PC_4;
				Instrucao_out	<= Instrucao;
			end if;
	end process;
	
	
end behavior;