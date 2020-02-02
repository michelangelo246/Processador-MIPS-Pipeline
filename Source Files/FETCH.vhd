---
---	FETCH MIPS - OAC
---	Autor: Michelangelo da Rocha Machado - 14/0156089
---

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FETCH is
	generic (WSIZE : natural := 32);
	port
	(
		--- entradas ---
		clk			:	in std_logic;
		OrigPC		:	in std_logic := '0';						--- MEMORY
		branch_addr	:	in std_logic_vector (31 downto 0);	--- MEMORY
		jump			:	in std_logic;								--- DECODE
		jumpR			:	in std_logic;								--- DECODE
		jump_addr	:	in std_logic_vector (31 downto 0);	--- DECODE
		jumpR_addr	:	in std_logic_vector (31 downto 0);	--- DECODE
		
		--- saidas ---
		PC_4			:	out std_logic_vector (31 downto 0);	--- IF/ID
		Instrucao	:	out std_logic_vector (31 downto 0)	--- IF/ID
	);
end FETCH;

architecture behavior of FETCH is
	
	component PC
		port
		(
			d   : in std_logic_vector(WSIZE-1 downto 0);
			clk : in std_logic;
			q   : out std_logic_vector(WSIZE-1 downto 0)
		);
	end component;
	
	component MemI
		port
		(
			address	: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			clock		: IN STD_LOGIC  := '1';
			data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			wren		: IN STD_LOGIC ;
			q			: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	end component;
	
	--- wire_<mod1>_to_<mod2>
	signal wire_PC_to_MemI				: std_logic_vector(31 downto 0);
	signal wire_Mux_to_PC				: std_logic_vector(31 downto 0);
	signal wire_Mux_beq_PC_4_to_PC	: std_logic_vector(31 downto 0);
	signal wire_Mux_jump_jumpR_to_PC	: std_logic_vector(31 downto 0);
	
begin
	
	PC_inst1: PC
	port map
	(
		d   =>	wire_Mux_to_PC,
		clk =>	(clk),
		q   =>	wire_PC_to_MemI
	);
	
	MemI_inst1: MemI
	port map
	(
		address	=>	wire_PC_to_MemI(9 downto 2),
		clock		=>	not(clk),
		data		=>	x"00000000",
		wren		=>	'0',
		q			=>	Instrucao
	);
	
	PC_4 <= std_logic_vector(unsigned(wire_PC_to_MemI) + 4);
	
	--- mux beq ou PC_4 ---
	with OrigPC select
		wire_Mux_beq_PC_4_to_PC <=  std_logic_vector(unsigned(wire_PC_to_MemI) + 4) when '0',
								 branch_addr															 when '1';
								 
	--- mux jump ou jumpR ---
	with jumpR select
		wire_Mux_jump_jumpR_to_PC <= 	jump_addr		when '0',
												jumpR_addr 		when '1';
								 
	--- (jump ou jumpR) ou (mux beq ou PC_4) ---
	with jump select
		wire_Mux_to_PC <=  wire_Mux_beq_PC_4_to_PC	when '0',
								 wire_Mux_jump_jumpR_to_PC	when '1';
	
end behavior;