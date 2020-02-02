---
---	EX_MEM MIPS - OAC
---	Autor: Michelangelo da Rocha Machado - 14/0156089
---

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

Entity EX_MEM is
	generic (WSIZE : natural := 32);
	
   Port
	(
		--- entradas ---
		clk					:	in std_logic;
		BranchAddr			:	in std_logic_vector(31 downto 0);	--- EXECUTE
		ALUzero				:	in std_logic;								--- EXECUTE
		ALUresultado		:	in std_logic_vector(31 downto 0);	--- EXECUTE
		reg2					:	in std_logic_vector(31 downto 0);	--- ID/EX
		rdOut					:	in std_logic_vector(4 downto 0);		--- EXECUTE
		LinkAddr				:	in std_logic_vector(31 downto 0);	--- ID/EX
		
		--- entradas controle ---
		Branch				:	in std_logic;								--- ID/EX
		BranchNot			:	in std_logic;								--- ID/EX
		EscreveMem			:	in std_logic;								--- ID/EX
		EscreveReg			:	in std_logic;								--- ID/EX
		MemparaReg			:	in std_logic_vector(1 downto 0);		--- ID/EX
		
		--- saidas controle ---
		Branch_MEM			:	out std_logic;								--- MEMORY
		BranchNot_MEM		:	out std_logic;								--- MEMORY
		EscreveMem_MEM		:	out std_logic;								--- MEMORY
		EscreveReg_WB		:	out std_logic;								--- MEM/WB
		MemparaReg_WB		:	out std_logic_vector(1 downto 0);	--- MEM/WB
		
		--- saidas ---
		BranchAddr_out		:	out std_logic_vector(31 downto 0);	--- FETCH
		ALUzero_out			:	out std_logic;								--- MEMORY
		ALUresultado_out	:	out std_logic_vector(31 downto 0);	--- MEMORY
		reg2_out				:	out std_logic_vector(31 downto 0);	--- MEM/WB
		rdOut_out			:	out std_logic_vector(4 downto 0);	--- MEM/WB
		LinkAddr_out		:	out std_logic_vector(31 downto 0)		--- MEM/WB
		
	);
end EX_MEM;

architecture behavior of EX_MEM is
	
begin
	
	process(clk)
		begin
			IF rising_edge(clk) THEN
			
            BranchAddr_out		<= BranchAddr;
				ALUzero_out			<= ALUzero;
				ALUresultado_out	<= ALUresultado;
				reg2_out				<= reg2;
				rdOut_out			<= rdOut;
				LinkAddr_out		<= LinkAddr;
				                  
				Branch_MEM			<= Branch;
				BranchNot_MEM		<= BranchNot;
				EscreveMem_MEM		<= EscreveMem;
				EscreveReg_WB		<= EscreveReg;
				MemparaReg_WB		<= MemparaReg;
				
			end if;              
	end process;
	
	
end behavior;