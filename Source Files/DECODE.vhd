---
---	DECODE MIPS - OAC
---	Autor: Michelangelo da Rocha Machado - 14/0156089
---

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DECODE is
	generic (WSIZE : natural := 32);
	port
	(
		--- entradas ---
		clk				:	in std_logic;
		Instrucao		:	in std_logic_vector(31 downto 0);	--- IF/ID
		wraddr			:	in std_logic_vector(4 downto 0);		--- MEM/WB
		wrdata			:	in std_logic_vector(31 downto 0);	--- WB
		EscreveReg		:	in std_logic := '0';						--- MEM/WB
		PC_4				:	in std_logic_vector(3 downto 0);		--- IF/ID
		
		--- saidas do controle ---
		OpALU_EX			:	out std_logic_vector(2 downto 0);	--- ID/EX
		OrigAluA_EX		:	out std_logic;								--- ID/EX
		OrigAluB_EX		:	out std_logic;								--- ID/EX
		RegDst_EX		:	out std_logic_vector(1 downto 0);	--- ID/EX
		Branch_MEM		:	out std_logic;								--- ID/EX
		BranchNot_MEM	:	out std_logic;								--- ID/EX
		EscreveMem_MEM	:	out std_logic;								--- ID/EX
		EscreveReg_WB	:	out std_logic;								--- ID/EX
		MemparaReg_WB	:	out std_logic_vector(1 downto 0);	--- ID/EX
		jump_F			:	out std_logic;								--- FETCH
		jumpR_F			:	out std_logic;								--- FETCH
		
		--- saidas ---
		Immediate		:	out std_logic_vector(31 downto 0);	--- ID/EX
		rt					:	out std_logic_vector(4 downto 0);	--- ID/EX
		rd					:	out std_logic_vector(4 downto 0);	--- ID/EX
		reg1				:	out std_logic_vector(31 downto 0);	--- ID/EX
		reg2				:	out std_logic_vector(31 downto 0);	--- ID/EX
		JumpAddr			:	out std_logic_vector(31 downto 0)	--- FETCH
	);
end DECODE;

architecture behavior of DECODE is

	component Breg
		port
		(
			clk, wren 					: in std_logic;
			raddr1, raddr2, wraddr 	: in std_logic_vector(4 downto 0);
			wrdata 						: in std_logic_vector(31 downto 0);
			r1, r2 						: out std_logic_vector(31 downto 0)
		);
	end component;
	
	component Controle
		port
		(
			Instrucao		:	in std_logic_vector(31 downto 0);
			OpALU				:	out std_logic_vector(2 downto 0);
			OrigAluA			:	out std_logic;
			OrigAluB			:	out std_logic;
			RegDst			:	out std_logic_vector(1 downto 0);
			Branch			:	out std_logic;
			BranchNot		:	out std_logic;
			EscreveMem		:	out std_logic;
			EscreveReg		:	out std_logic;
			MemparaReg		:	out std_logic_vector(1 downto 0);
			Jump				:	out std_logic;
			JumpR				:	out std_logic
		);
	end component;
	
begin
	
	Breg_inst1: Breg
	port map
	(
		clk		=> clk,
		wren 		=> EscreveReg,
		raddr1	=> Instrucao(25 downto 21),
		raddr2	=> Instrucao(20 downto 16),
		wraddr 	=> wraddr,
		wrdata 	=> wrdata,
		r1			=> reg1,
		r2 		=> reg2
	);
	
	Controle_inst1: Controle
	port map
	(
		Instrucao	=> Instrucao,
		OpALU			=> OpALU_EX,
		OrigAluA		=> OrigAluA_EX,
		OrigAluB		=> OrigAluB_EX,
		RegDst		=> RegDst_EX,
		Branch		=> Branch_MEM,
		BranchNot	=> BranchNot_MEM,
		EscreveMem	=> EscreveMem_MEM,
		EscreveReg	=> EscreveReg_WB,
		MemparaReg	=> MemparaReg_WB,
		Jump			=> jump_F,
		jumpR			=> jumpR_F
	);
	
	Immediate	<= std_logic_vector(resize(signed(Instrucao(15 downto 0)), 32));
	rt				<= Instrucao(20 downto 16);
	rd				<= Instrucao(15 downto 11);
	
	JumpAddr		<= (PC_4)&Instrucao(25 downto 0)&"00";
	
end behavior;





