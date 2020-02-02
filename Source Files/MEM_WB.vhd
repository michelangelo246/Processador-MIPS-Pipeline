---
---	MEM_WB MIPS - OAC
---	Autor: Michelangelo da Rocha Machado - 14/0156089
---

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

Entity MEM_WB is
	generic (WSIZE : natural := 32);
	
   Port
	(
		--- entradas ---
		clk					:	in std_logic;
		rdata					:	in std_logic_vector(31 downto 0);	--- MEMORY
		ALUresult			:	in std_logic_vector(31 downto 0);	--- EX/MEM
		rdOut					:	in std_logic_vector(4 downto 0);		--- EX/MEM
		LinkAddr				:	in std_logic_vector(31 downto 0);	--- EX/MEM
		
		--- entradas controle ---
		EscreveReg			:	in std_logic := '0';						--- EX/MEM
		MemparaReg			:	in std_logic_vector(1 downto 0);		--- EX/MEM
		
		--- saidas controle ---
		EscreveReg_WB		:	out std_logic;								--- DECODE
		MemparaReg_WB		:	out std_logic_vector(1 downto 0);	--- WRITEBACK
		
		--- saidas ---
		rdata_out			: out std_logic_vector(31 downto 0);	--- WRITEBACK
		ALUresult_out		: out std_logic_vector(31 downto 0);	--- WRITEBACK
		rdOut_out			: out std_logic_vector(4 downto 0);		--- DECODE
		LinkAddr_out		:	out std_logic_vector(31 downto 0)	--- ID/EX
		
	);
end MEM_WB;

architecture behavior of MEM_WB is
	
begin
	
	process(clk)
		begin
			IF rising_edge(clk) THEN
			
            EscreveReg_WB		<= EscreveReg;
				MemparaReg_WB		<= MemparaReg;
				                  
				rdata_out			<= rdata;
				ALUresult_out		<= ALUresult;
				rdOut_out			<= rdOut;
						
			end if;              
	end process;
	
	
end behavior;