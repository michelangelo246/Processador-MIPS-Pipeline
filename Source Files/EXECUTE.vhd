---
---	EXECUTE - OAC
---	Autor: Michelangelo da Rocha Machado - 14/0156089
---

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity EXECUTE is
	generic (WSIZE : natural := 32);
	port
	(
		--- entradas ---
		PC_4				:	in std_logic_vector(31 downto 0);			--- ID/EX
		reg1				:	in std_logic_vector(31 downto 0);			--- ID/EX
		reg2				:	in std_logic_vector(31 downto 0);			--- ID/EX
		Immediate		:	in std_logic_vector(31 downto 0);			--- ID/EX
		rt					:	in std_logic_vector(4 downto 0);				--- ID/EX
		rd					:	in std_logic_vector(4 downto 0);				--- ID/EX
		
		--- entradas controle ---
		OrigALUA			:	in std_logic;										--- ID/EX
		OrigALUB			:	in std_logic;										--- ID/EX
		OpALU				:	in std_logic_vector(2 downto 0) := "010";	--- ID/EX
		RegDST			:	in std_logic_vector(1 downto 0);				--- ID/EX
		
		--- saidas ---
		BranchAddr		:	out std_logic_vector(31 downto 0);			--- EX/MEM
		ALUzero			:	out std_logic;										--- EX/MEM
		ALUresult		:	out std_logic_vector(31 downto 0);			--- EX/MEM
		rdOut				:	out std_logic_vector(4 downto 0)				--- EX/MEM
		
	);
end EXECUTE;

architecture behavior of EXECUTE is
	
	component ULA
	Port
		(
			ctrl_opcode : in std_logic_vector(3 downto 0);
			A				: in std_logic_vector(WSIZE-1 downto 0);
			B 				: in std_logic_vector(WSIZE-1 downto 0);
			Z 				: out std_logic_vector(WSIZE-1 downto 0);
			zero			: out std_logic;
			ovfl 			: out std_logic
		);
	end component;
	
	component ControleULA
	Port
		(
			OpALU		:	in std_logic_vector(2 downto 0);
			funct		:	in std_logic_vector(5 downto 0);
			ALUctrl	:	out std_logic_vector(3 downto 0)
		);
	end component;
	
	--- wire_<mod1>_to_<mod2>
	signal wire_ControleULA_to_ULA	:	std_logic_vector(3 downto 0);
	signal wire_MUXA_to_ULA				:	std_logic_vector(31 downto 0);
	signal wire_MUXB_to_ULA				:	std_logic_vector(31 downto 0);
	signal wire_MUX_to_rdOut			:	std_logic_vector(4 downto 0);
	
begin
	--- endereco do desvio ---
	BranchAddr <= PC_4 + (Immediate(29 downto 0)&"00");
	
	--- mux OrigALUA ---
	with OrigALUA select
		wire_MUXA_to_ULA <= reg1 						when '0',
				"00000000000000000000000000010000"	when  '1';
	
	--- mux OrigALUB ---
	with OrigALUB select
		wire_MUXB_to_ULA <= reg2 		when '0',
								Immediate	when  '1';
	
	--- mux RegDST ---
	with RegDST select
		wire_MUX_to_rdOut <= rt 		when "00",
									rd 		when "01",
									"11111"	when others; --- $ra
	
	rdOut <= wire_MUX_to_rdOut;
	
	ULA_inst1: ULA
	port map
	(
		ctrl_opcode => wire_ControleULA_to_ULA,
		A				=> wire_MUXA_to_ULA,
		B 				=> wire_MUXB_to_ULA,
		Z 				=> ALUresult,
		zero			=> ALUzero
	);
	
	ControleULA_inst1: ControleULA
	port map
	(
		OpALU			=> OpALU,
		funct			=> Immediate(5 downto 0),
		ALUctrl		=> wire_ControleULA_to_ULA
	);
	
end behavior;