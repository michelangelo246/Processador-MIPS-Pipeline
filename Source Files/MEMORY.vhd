---
---	MEMORY - OAC
---	Autor: Michelangelo da Rocha Machado - 14/0156089
---

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity MEMORY is
	generic (WSIZE : natural := 32);
	port
	(
		--- entradas ---
		clk			:	in std_logic;
		wraddr		:	in std_logic_vector(31 downto 0);	--- EX/MEM
		wrdata		:	in std_logic_vector(31 downto 0);	--- EX/MEM
		ALUzero		:	in std_logic;								--- EX/MEM
		
		--- entradas controle ---
		Branch		:	in std_logic;								--- EX/MEM
		BranchNot	:	in std_logic;								--- EX/MEM
		EscreveMem	:	in std_logic;								--- EX/MEM
		
		--- saidas ---
		rdata			:	out std_logic_vector(31 downto 0);	--- MEM/WB
		OrigPC		:	out std_logic := '0'						--- FETCH
		
	);
end MEMORY;

architecture behavior of MEMORY is
	
	component MemD
		port
		(
			address	: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			clock		: IN STD_LOGIC  := '1';
			data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			wren		: IN STD_LOGIC ;
			q			: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	end component;
	
	signal wire_Branch		:	std_logic;
	signal wire_BranchNot	:	std_logic;
	
begin
	
	wire_Branch 	<= Branch and ALUzero;
	wire_BranchNot <= BranchNot and (not(ALUzero));
	
	OrigPC <= wire_Branch or wire_BranchNot;
	
	MemD_inst1: MemD
	port map
	(
		address	=>	wraddr(9 downto 2),
		clock		=>	not(clk),
		data		=>	wrdata,
		wren		=>	EscreveMem,
		q			=>	rdata
	);
	
	
end behavior;