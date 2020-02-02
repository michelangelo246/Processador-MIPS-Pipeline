---
---	ID_EX MIPS - OAC
---	Autor: Michelangelo da Rocha Machado - 14/0156089
---

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

Entity ID_EX is
	generic (WSIZE : natural := 32);
	
   Port
	(
		--- entradas ---
		clk				:	in std_logic;
		PC_4				:	in std_logic_vector(31 downto 0);	--- IF/ID
		reg1				:	in std_logic_vector(31 downto 0);	--- DECODE
		reg2				:	in std_logic_vector(31 downto 0);	--- DECODE
		Immediate		:	in std_logic_vector(31 downto 0);	--- DECODE
		rt					:	in std_logic_vector(4 downto 0);		--- DECODE
		rd					:	in std_logic_vector(4 downto 0);		--- DECODE
		
		--- entradas controle ---
		OpALU				:	in std_logic_vector(2 downto 0);		--- DECODE
		OrigAluA			:	in std_logic;								--- DECODE
		OrigAluB			:	in std_logic;								--- DECODE
		RegDst			:	in std_logic_vector(1 downto 0);		--- DECODE
		Branch			:	in std_logic;								--- DECODE
		BranchNot		:	in std_logic;								--- DECODE
		EscreveMem		:	in std_logic;								--- DECODE
		EscreveReg		:	in std_logic;								--- DECODE
		MemparaReg		:	in std_logic_vector(1 downto 0);		--- DECODE
		
		--- saidas controle ---
		OpALU_EX			:	out std_logic_vector(2 downto 0);	--- EXECUTE
		OrigAluA_EX		:	out std_logic;								--- EXECUTE
		OrigAluB_EX		:	out std_logic;								--- EXECUTE
		RegDst_EX		:	out std_logic_vector(1 downto 0);	--- EXECUTE
		Branch_MEM		:	out std_logic := '0';					--- EX/MEM
		BranchNot_MEM	:	out std_logic := '0';					--- EX/MEM
		EscreveMem_MEM	:	out std_logic := '0';					--- EX/MEM
		EscreveReg_WB	:	out std_logic;								--- EX/MEM
		MemparaReg_WB	:	out std_logic_vector(1 downto 0);	--- EX/MEM
		
		--- saidas ---
		PC_4_out			:	out std_logic_vector(31 downto 0);	--- EXECUTE
		reg1_out			:	out std_logic_vector(31 downto 0);	--- EXECUTE
		reg2_out			:	out std_logic_vector(31 downto 0);	--- EXECUTE
		Immediate_out	:	out std_logic_vector(31 downto 0);	--- EXECUTE
		rt_out			:	out std_logic_vector(4 downto 0);	--- EXECUTE
		rd_out			:	out std_logic_vector(4 downto 0)		--- EXECUTE
	);
end ID_EX;

architecture behavior of ID_EX is
	
begin
	
	process(clk)
		begin
			IF rising_edge(clk) THEN
				PC_4_out			<= PC_4;
				reg1_out			<= reg1;
				reg2_out			<= reg2;
				Immediate_out	<= Immediate;
				rt_out			<= rt;
				rd_out			<= rd;
				                  
				OpALU_EX			<= OpALU;
				OrigAluA_EX		<= OrigAluA;
				OrigAluB_EX		<= OrigAluB;
				RegDst_EX		<= RegDst;
				Branch_MEM		<= Branch;
				BranchNot_MEM	<= BranchNot;
				EscreveMem_MEM	<= EscreveMem;
				EscreveReg_WB	<= EscreveReg;
				MemparaReg_WB	<= MemparaReg;
			end if;
	end process;
	
	
end behavior;