---
---	Controle ULA MIPS - OAC
---	Autor: Michelangelo da Rocha Machado - 14/0156089
---

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity ControleULA is
	Port
	(
		--- entradas controle ---
		OpALU		:	in std_logic_vector(2 downto 0);
		
		--- entrada instrucao ---
		funct		:	in std_logic_vector(5 downto 0);
		
		--- saida controle da ula ---
		ALUctrl	:	out std_logic_vector(3 downto 0)
	);
end ControleULA;

architecture behavior of ControleULA is
	signal ALUctrl_out	: std_logic_vector(3 downto 0);
	
begin
	ALUctrl <= ALUctrl_out;
	
	process(OpALU,funct,ALUctrl_out)
	begin
		
		if(OpALU = "000") then ALUctrl_out <= "0010";end if;	--- add
		if(OpALU = "001") then ALUctrl_out <= "0100";end if;	--- sub
		if(OpALU = "011") then ALUctrl_out <= "0110";end if;	--- slt
		if(OpALU = "100") then ALUctrl_out <= "1010";end if;	--- sll
		if(OpALU = "010") then
			case funct is
				when "100000"	=> --- add
					ALUctrl_out <= "0010";
					
				when "100010"	=> --- sub
					ALUctrl_out <= "0100";
					
				when "100100"	=> --- and
					ALUctrl_out <= "0000";
					
				when "100101"	=> --- or
					ALUctrl_out <= "0001";
					
				when "100110"	=> --- xor
					ALUctrl_out <= "1001";
					
				when "101010"	=> --- slt
					ALUctrl_out <= "0110";
				
				when "100111"	=> --- nor
					ALUctrl_out <= "1000";
					
				when others =>
					ALUctrl_out <= "----";
			end case;
		end if;
	end process;
end behavior;