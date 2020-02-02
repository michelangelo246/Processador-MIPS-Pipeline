
---	MIPS - OAC
---	Autor: Michelangelo da Rocha Machado - 14/0156089
---

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MIPS is
	generic (WSIZE : natural := 32);
	port
	(
		clk				:	in std_logic;
		
		PC_4				:	out std_logic_vector(31 downto 0);
		instrucao		:	out std_logic_vector(31 downto 0);
		resultadoULA	:	out std_logic_vector(31 downto 0);
		MemOut			:	out std_logic_vector(31 downto 0);
		reg1Out			:	out std_logic_vector(31 downto 0);
		reg2Out			:	out std_logic_vector(31 downto 0)
	);
end MIPS;

architecture behavior of MIPS is
	
	component FETCH
		port
		(
			--- entradas ---
			clk			:	in std_logic;
			OrigPC		:	in std_logic;								--- MEMORY
			branch_addr	:	in std_logic_vector (31 downto 0);	--- MEMORY
			jump			:	in std_logic;								--- DECODE
			jumpR			:	in std_logic;								--- DECODE
			jump_addr	:	in std_logic_vector (31 downto 0);	--- DECODE
			jumpR_addr	:	in std_logic_vector (31 downto 0);	--- DECODE
			
			--- saidas ---
			PC_4			:	out std_logic_vector (31 downto 0);	--- IF/ID
			Instrucao	:	out std_logic_vector (31 downto 0)	--- IF/ID
		);
	end component;
	
	component IF_ID
		port
		(
			--- entradas ---
		clk				:	in std_logic;								
		PC_4				:	in std_logic_vector(31 downto 0);	--- FETCH
		Instrucao		:	in std_logic_vector(31 downto 0);	--- FETCH
		
		--- saidas ---
		PC_4_out			:	out std_logic_vector(31 downto 0);	--- DECODE
		Instrucao_out	:	out std_logic_vector(31 downto 0)	--- DECODE
		);
	end component;
	
	component DECODE
		port
		(
			--- entradas ---
			clk				:	in std_logic;
			Instrucao		:	in std_logic_vector(31 downto 0);	--- IF/ID
			wraddr			:	in std_logic_vector(4 downto 0);		--- MEM/WB
			wrdata			:	in std_logic_vector(31 downto 0);	--- WB
			EscreveReg		:	in std_logic := '0';						--- MEM/WB
			PC_4				:	in std_logic_vector(3 downto 0);	--- IF/ID
			
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
	end component;
	
	component ID_EX
		port
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
	end component;
	
	component EXECUTE
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
	end component;
	
	component EX_MEM
		port
		(
			--- entradas ---
			clk					:	in std_logic;
			BranchAddr			:	in std_logic_vector(31 downto 0);	--- EXECUTE
			ALUzero				:	in std_logic;								--- EXECUTE
			ALUresultado		:	in std_logic_vector(31 downto 0);	--- EXECUTE
			reg2					:	in std_logic_vector(31 downto 0);	--- ID/EX
			rdOut					:	in std_logic_vector(4 downto 0);		--- EXECUTE
			
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
			rdOut_out			:	out std_logic_vector(4 downto 0)		--- MEM/WB
		);
	end component;
	
	component MEMORY
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
	end component;
	
	component MEM_WB
		port
		(
			--- entradas ---
			clk					:	in std_logic;
			rdata					:	in std_logic_vector(31 downto 0);	--- MEMORY
			ALUresult			:	in std_logic_vector(31 downto 0);	--- EX/MEM
			rdOut					:	in std_logic_vector(4 downto 0);		--- EX/MEM
			
			--- entradas controle ---
			EscreveReg			:	in std_logic;								--- EX/MEM
			MemparaReg			:	in std_logic_vector(1 downto 0);		--- EX/MEM
			
			--- saidas controle ---
			EscreveReg_WB		:	out std_logic;								--- DECODE
			MemparaReg_WB		:	out std_logic_vector(1 downto 0);	--- WRITEBACK
			
			--- saidas ---
			rdata_out			: out std_logic_vector(31 downto 0);	--- WRITEBACK
			ALUresult_out		: out std_logic_vector(31 downto 0);	--- WRITEBACK
			rdOut_out			: out std_logic_vector(4 downto 0)		--- DECODE
		);
	end component;
	
	component WRITEBACK
		port
		(
			--- entradas ---
			SaidaMem		:	in std_logic_vector(31 downto 0);	--- MEM/WB
			SaidaALU		:	in std_logic_vector(31 downto 0);	--- MEM/WB
			
			--- entradas controle ---
			MemparaReg	:	in std_logic_vector(1 downto 0);		--- MEM/WB
			
			--- saidas ---
			wrdata		:	out std_logic_vector(31 downto 0)	--- DECODE
		);
	end component;
	
	
	signal wire_FETCH_IFID_PC_4							:std_logic_vector (31 downto 0);
	signal wire_FETCH_IFID_Instrucao						:std_logic_vector (31 downto 0);
	
	signal wire_IFID_IDEX_DECODE_PC_4					:std_logic_vector(31 downto 0);
	signal wire_IFID_DECODE_instrucao					:std_logic_vector(31 downto 0);

	signal wire_DECODE_IDEX_OpALU							:std_logic_vector(2 downto 0);
	signal wire_DECODE_IDEX_OrigAluA						:std_logic;	
	signal wire_DECODE_IDEX_OrigAluB						:std_logic;	
	signal wire_DECODE_IDEX_RegDst						:std_logic_vector(1 downto 0);
	signal wire_DECODE_IDEX_Branch						:std_logic;
	signal wire_DECODE_IDEX_BranchNot					:std_logic;
	signal wire_DECODE_IDEX_EscreveMem					:std_logic;
	signal wire_DECODE_IDEX_EscreveReg					:std_logic;
	signal wire_DECODE_IDEX_MemparaReg					:std_logic_vector(1 downto 0);
	signal wire_DECODE_IDEX_Immediate					:std_logic_vector(31 downto 0);
	signal wire_DECODE_IDEX_rt								:std_logic_vector(4 downto 0);
	signal wire_DECODE_IDEX_rd								:std_logic_vector(4 downto 0);
	signal wire_DECODE_IDEX_FETCH_reg1					:std_logic_vector(31 downto 0);
	signal wire_DECODE_IDEX_reg2							:std_logic_vector(31 downto 0);
	signal wire_DECODE_FETCH_Jump							:std_logic;
	signal wire_DECODE_FETCH_JumpAddr					:std_logic_vector(31 downto 0);
	signal wire_DECODE_FETCH_JumpR						:std_logic;

	signal wire_IDEX_EXECUTE_OpALU						:std_logic_vector(2 downto 0);
	signal wire_IDEX_EXECUTE_OrigAluA					:std_logic;
	signal wire_IDEX_EXECUTE_OrigAluB					:std_logic;
	signal wire_IDEX_EXECUTE_RegDst						:std_logic_vector(1 downto 0);
	signal wire_IDEX_EXMEM_Branch							:std_logic;
	signal wire_IDEX_EXMEM_BranchNot						:std_logic;
	signal wire_IDEX_EXMEM_EscreveMem					:std_logic;
	signal wire_IDEX_EXMEM_EscreveReg					:std_logic;
	signal wire_IDEX_EXMEM_MemparaReg					:std_logic_vector(1 downto 0);
	signal wire_IDEX_EXECUTE_PC_4							:std_logic_vector(31 downto 0);
	signal wire_IDEX_EXECUTE_reg1							:std_logic_vector(31 downto 0);
	signal wire_IDEX_EXECUTE_EXMEM_reg2					:std_logic_vector(31 downto 0);
	signal wire_IDEX_EXECUTE_Immediate					:std_logic_vector(31 downto 0);
	signal wire_IDEX_EXECUTE_rt							:std_logic_vector(4 downto 0);
	signal wire_IDEX_EXECUTE_rd							:std_logic_vector(4 downto 0);
	
	signal wire_EXECUTE_EXMEM_BranchAddr				:std_logic_vector(31 downto 0);
	signal wire_EXECUTE_EXMEM_ALUzero					:std_logic;
	signal wire_EXECUTE_EXMEM_ALUresult					:std_logic_vector(31 downto 0);
	signal wire_EXECUTE_EXMEM_rdOut						:std_logic_vector(4 downto 0);

	signal wire_EXMEM_FETCH_BranchAddr					:std_logic_vector(31 downto 0);
	signal wire_EXMEM_MEMORY_Branch						:std_logic;
	signal wire_EXMEM_MEMORY_BranchNot					:std_logic;
	signal wire_EXMEM_MEMORY_EscreveMem					:std_logic;
	signal wire_EXMEM_MEMORY_ALUzero						:std_logic;
	signal wire_EXMEM_MEMORY_MEMWB_ALUresultado		:std_logic_vector(31 downto 0);
	signal wire_EXMEM_MEMWB_EscreveReg					:std_logic;
	signal wire_EXMEM_MEMWB_MemparaReg					:std_logic_vector(1 downto 0);
	signal wire_EXMEM_MEMWB_MEMORY_reg2					:std_logic_vector(31 downto 0);
	signal wire_EXMEM_MEMWB_rdOut							:std_logic_vector(4 downto 0);
		
	signal wire_MEMORY_MEMWB_rdata						:std_logic_vector(31 downto 0);
	signal wire_MEMORY_FETCH_OrigPC						:std_logic;
		
	signal wire_MEMWB_DECODE_rdOut						:std_logic_vector(4 downto 0);
	signal wire_MEMWB_DECODE_EscreveReg_WB				:std_logic;
	signal wire_MEMWB_WRITEBACK_MemparaReg_WB			:std_logic_vector(1 downto 0);
	signal wire_MEMWB_WRITEBACK_rdata					:std_logic_vector(31 downto 0);
	signal wire_MEMWB_WRITEBACK_ALUresult				:std_logic_vector(31 downto 0);
		
	signal wire_WRITEBACK_DECODE_wrdata					:std_logic_vector(31 downto 0);
	
begin
	
	instrucao <= wire_FETCH_IFID_Instrucao;
	resultadoULA <= wire_EXECUTE_EXMEM_ALUresult;
	PC_4 <= wire_FETCH_IFID_PC_4;
	MemOut <= wire_MEMORY_MEMWB_rdata;
	reg1Out <= wire_DECODE_IDEX_FETCH_reg1;
	reg2Out <= wire_DECODE_IDEX_reg2;
	
	
	FETCH_inst1: FETCH
	port map
	(
		--- entradas ---
		clk			=> 	clk,
		OrigPC		=> 	wire_MEMORY_FETCH_OrigPC,		--- MEMORY
		branch_addr	=> 	wire_EXMEM_FETCH_BranchAddr,	--- EX/MEM
		jump			=>		wire_DECODE_FETCH_Jump,			--- DECODE
		jumpR			=>		wire_DECODE_FETCH_JumpR,		--- DECODE
		jump_addr	=>		wire_DECODE_FETCH_JumpAddr,	--- DECODE
		jumpR_addr	=>		wire_DECODE_IDEX_FETCH_reg1,	--- DECODE
		
		--- saidas ---
		PC_4			=> 	wire_FETCH_IFID_PC_4,			--- IF/ID
		Instrucao	=> 	wire_FETCH_IFID_Instrucao		--- IF/ID
	);
	
	IF_ID_inst1: IF_ID
	port map
	(
		--- entradas ---
		clk				=> 	clk,
		PC_4				=> 	wire_FETCH_IFID_PC_4,		--- FETCH
		Instrucao		=> 	wire_FETCH_IFID_Instrucao,	--- FETCH
		
		--- saidas ---
		PC_4_out			=> 	wire_IFID_IDEX_DECODE_PC_4,--- DECODE
		Instrucao_out	=> 	wire_IFID_DECODE_instrucao	--- DECODE
	);
	
	DECODE_inst1: DECODE
	port map
	(
		--- entradas ---
		clk				=> 	clk,
		Instrucao		=> 	wire_IFID_DECODE_instrucao,					--- IF/ID
		wrdata			=> 	wire_WRITEBACK_DECODE_wrdata,					--- WB
		wraddr			=> 	wire_MEMWB_DECODE_rdOut	,						--- MEM/WB
		EscreveReg		=> 	wire_MEMWB_DECODE_EscreveReg_WB,				--- MEM/WB
		PC_4				=>		wire_IFID_IDEX_DECODE_PC_4(31 downto 28),	--- IF/ID
		
		--- saidas do controle ---
		OpALU_EX			=> 	wire_DECODE_IDEX_OpALU,			--- ID/EX
		OrigAluA_EX		=> 	wire_DECODE_IDEX_OrigAluA,		--- ID/EX
		OrigAluB_EX		=> 	wire_DECODE_IDEX_OrigAluB,		--- ID/EX
		RegDst_EX		=> 	wire_DECODE_IDEX_RegDst,		--- ID/EX
		Branch_MEM		=> 	wire_DECODE_IDEX_Branch,		--- ID/EX
		BranchNot_MEM	=>		wire_DECODE_IDEX_BranchNot,	--- ID/EX
		EscreveMem_MEM	=> 	wire_DECODE_IDEX_EscreveMem,	--- ID/EX
		EscreveReg_WB	=> 	wire_DECODE_IDEX_EscreveReg,	--- ID/EX
		MemparaReg_WB	=> 	wire_DECODE_IDEX_MemparaReg,	--- ID/EX
		jump_F			=>		wire_DECODE_FETCH_Jump,			--- FETCH
		jumpR_F			=>		wire_DECODE_FETCH_JumpR,		--- FETCH
		
		--- saidas ---
		Immediate		=> 	wire_DECODE_IDEX_Immediate,	--- ID/EX
		rt					=> 	wire_DECODE_IDEX_rt,				--- ID/EX
		rd					=> 	wire_DECODE_IDEX_rd,				--- ID/EX
		reg1				=> 	wire_DECODE_IDEX_FETCH_reg1,	--- ID/EX
		reg2				=> 	wire_DECODE_IDEX_reg2,			--- ID/EX
		JumpAddr			=>		wire_DECODE_FETCH_JumpAddr		--- FETCH
	);
	
	ID_EX_inst1: ID_EX
	port map
	(
		--- entradas ---
		clk				=> 	clk,
		PC_4				=> 	wire_IFID_IDEX_DECODE_PC_4,	--- IF/ID
		reg1				=> 	wire_DECODE_IDEX_FETCH_reg1,	--- DECODE
		reg2				=> 	wire_DECODE_IDEX_reg2,			--- DECODE
		Immediate		=> 	wire_DECODE_IDEX_Immediate,	--- DECODE
		rt					=> 	wire_DECODE_IDEX_rt,				--- DECODE
		rd					=> 	wire_DECODE_IDEX_rd,				--- DECODE
		
		--- entradas controle ---
		OpALU				=> 	wire_DECODE_IDEX_OpALU,				--- DECODE
		OrigAluA			=> 	wire_DECODE_IDEX_OrigAluA,			--- DECODE
		OrigAluB			=> 	wire_DECODE_IDEX_OrigAluB,			--- DECODE
		RegDst			=> 	wire_DECODE_IDEX_RegDst,			--- DECODE
		Branch			=> 	wire_DECODE_IDEX_Branch,			--- DECODE
		BranchNot		=>		wire_DECODE_IDEX_BranchNot,		--- DECODE
		EscreveMem		=> 	wire_DECODE_IDEX_EscreveMem,		--- DECODE
		EscreveReg		=> 	wire_DECODE_IDEX_EscreveReg,		--- DECODE
		MemparaReg		=> 	wire_DECODE_IDEX_MemparaReg,		--- DECODE
		
		--- saidas controle ---
		OpALU_EX			=> 	wire_IDEX_EXECUTE_OpALU,		--- EXECUTE
		OrigAluA_EX		=> 	wire_IDEX_EXECUTE_OrigAluA,	--- EXECUTE
		OrigAluB_EX		=> 	wire_IDEX_EXECUTE_OrigAluB,	--- EXECUTE
		RegDst_EX		=> 	wire_IDEX_EXECUTE_RegDst,		--- EXECUTE
		Branch_MEM		=> 	wire_IDEX_EXMEM_Branch,			--- EX/MEM
		BranchNot_MEM	=>		wire_IDEX_EXMEM_BranchNot,		--- EX/MEM
		EscreveMem_MEM	=> 	wire_IDEX_EXMEM_EscreveMem,	--- EX/MEM
		EscreveReg_WB	=> 	wire_IDEX_EXMEM_EscreveReg,	--- EX/MEM
		MemparaReg_WB	=> 	wire_IDEX_EXMEM_MemparaReg,	--- EX/MEM
		
		--- saidas ---
		PC_4_out			=> 	wire_IDEX_EXECUTE_PC_4,			--- EXECUTE
		reg1_out			=> 	wire_IDEX_EXECUTE_reg1,			--- EXECUTE
		reg2_out			=> 	wire_IDEX_EXECUTE_EXMEM_reg2,	--- EXECUTE
		Immediate_out	=> 	wire_IDEX_EXECUTE_Immediate,	--- EXECUTE
		rt_out			=> 	wire_IDEX_EXECUTE_rt,			--- EXECUTE
		rd_out			=> 	wire_IDEX_EXECUTE_rd				--- EXECUTE
	);
	
	EXECUTE_inst1: EXECUTE
	port map
	(
		--- entradas ---
		PC_4				=> 	wire_IDEX_EXECUTE_PC_4,				--- ID/EX
		reg1				=> 	wire_IDEX_EXECUTE_reg1,				--- ID/EX
		reg2				=> 	wire_IDEX_EXECUTE_EXMEM_reg2,		--- ID/EX
		Immediate		=> 	wire_IDEX_EXECUTE_Immediate,		--- ID/EX
		rt					=> 	wire_IDEX_EXECUTE_rt,				--- ID/EX
		rd					=> 	wire_IDEX_EXECUTE_rd,				--- ID/EX
		
		--- entradas controle ---
		OrigALUA			=> 	wire_IDEX_EXECUTE_OrigAluA,		--- ID/EX
		OrigALUB			=> 	wire_IDEX_EXECUTE_OrigAluB,		--- ID/EX
		OpALU				=> 	wire_IDEX_EXECUTE_OpALU,			--- ID/EX
		RegDST			=> 	wire_IDEX_EXECUTE_RegDst,			--- ID/EX
		
		--- saidas ---
		BranchAddr		=> 	wire_EXECUTE_EXMEM_BranchAddr,	--- EX/MEM
		ALUzero			=> 	wire_EXECUTE_EXMEM_ALUzero,		--- EX/MEM
		ALUresult		=> 	wire_EXECUTE_EXMEM_ALUresult,		--- EX/MEM
		rdOut				=> 	wire_EXECUTE_EXMEM_rdOut			--- EX/MEM
	);
	
	EX_MEM_inst1: EX_MEM
	port map
	(
		--- entradas ---
		clk					=> 	clk,
		BranchAddr			=> 	wire_EXECUTE_EXMEM_BranchAddr,	--- EXECUTE
		ALUzero				=> 	wire_EXECUTE_EXMEM_ALUzero,		--- EXECUTE
		ALUresultado		=> 	wire_EXECUTE_EXMEM_ALUresult,		--- EXECUTE
		reg2					=> 	wire_IDEX_EXECUTE_EXMEM_reg2,		--- ID/EX
		rdOut					=> 	wire_EXECUTE_EXMEM_rdOut,			--- EXECUTE
		
		--- entradas controle ---
		Branch				=> 	wire_IDEX_EXMEM_Branch,				--- ID/EX
		BranchNot			=>		wire_IDEX_EXMEM_Branchnot,			--- ID/EX
		EscreveMem			=> 	wire_IDEX_EXMEM_EscreveMem,		--- ID/EX
		EscreveReg			=> 	wire_IDEX_EXMEM_EscreveReg,		--- ID/EX
		MemparaReg			=> 	wire_IDEX_EXMEM_MemparaReg,		--- ID/EX
		
		--- saidas controle ---
		Branch_MEM			=> 	wire_EXMEM_MEMORY_Branch,			--- MEMORY
		BranchNot_MEM		=>		wire_EXMEM_MEMORY_BranchNot,		--- MEMORY
		EscreveMem_MEM		=> 	wire_EXMEM_MEMORY_EscreveMem,		--- MEMORY
		EscreveReg_WB		=> 	wire_EXMEM_MEMWB_EscreveReg,		--- MEM/WB
		MemparaReg_WB		=> 	wire_EXMEM_MEMWB_MemparaReg,		--- MEM/WB
		
		--- saidas ---
		BranchAddr_out		=> 	wire_EXMEM_FETCH_BranchAddr,				--- FETCH
		ALUzero_out			=> 	wire_EXMEM_MEMORY_ALUzero,					--- MEMORY
		ALUresultado_out	=> 	wire_EXMEM_MEMORY_MEMWB_ALUresultado,	--- MEMORY
		reg2_out				=> 	wire_EXMEM_MEMWB_MEMORY_reg2,				--- MEM/WB
		rdOut_out			=> 	wire_EXMEM_MEMWB_rdOut						--- MEM/WB
	);
	
	MEMORY_inst1: MEMORY
	port map
	(
		--- entradas ---
		clk			=> 	clk,
		wraddr		=> 	wire_EXMEM_MEMORY_MEMWB_ALUresultado,	--- EX/MEM
		wrdata		=> 	wire_EXMEM_MEMWB_MEMORY_reg2,				--- EX/MEM
		ALUzero		=> 	wire_EXMEM_MEMORY_ALUzero,					--- EX/MEM
		
		--- entradas controle ---
		Branch		=> 	wire_EXMEM_MEMORY_Branch,					--- EX/MEM
		BranchNot	=>		wire_EXMEM_MEMORY_BranchNot,				--- EX/MEM
		EscreveMem	=> 	wire_EXMEM_MEMORY_EscreveMem,				--- EX/MEM
		
		--- saidas ---
		rdata			=> 	wire_MEMORY_MEMWB_rdata,					--- MEM/WB
		OrigPC		=> 	wire_MEMORY_FETCH_OrigPC					--- FETCH
	);
	
	MEM_WB_inst1: MEM_WB
	port map
	(
		--- entradas ---
		clk					=> 	clk,
		rdata					=> 	wire_MEMORY_MEMWB_rdata,					--- MEMORY
		ALUresult			=> 	wire_EXMEM_MEMORY_MEMWB_ALUresultado,	--- EX/MEM
		rdOut					=> 	wire_EXMEM_MEMWB_rdOut,						--- EX/MEM
		
		--- entradas controle ---
		EscreveReg			=> 	wire_EXMEM_MEMWB_EscreveReg,				--- EX/MEM
		MemparaReg			=> 	wire_EXMEM_MEMWB_MemparaReg,				--- EX/MEM
		
		--- saidas controle ---
		EscreveReg_WB		=> 	wire_MEMWB_DECODE_EscreveReg_WB,			--- DECODE
		MemparaReg_WB		=> 	wire_MEMWB_WRITEBACK_MemparaReg_WB,		--- WRITEBACK
		
		--- saidas ---
		rdata_out			=> 	wire_MEMWB_WRITEBACK_rdata,				--- WRITEBACK
		ALUresult_out		=> 	wire_MEMWB_WRITEBACK_ALUresult,			--- WRITEBACK
		rdOut_out			=> 	wire_MEMWB_DECODE_rdOut						--- DECODE
	);
	
	WRITEBACK_inst1: WRITEBACK
	port map
	(
		--- entradas ---
		SaidaMem		=> 	wire_MEMWB_WRITEBACK_rdata,				--- MEM/WB
		SaidaALU		=> 	wire_MEMWB_WRITEBACK_ALUresult,			--- MEM/WB
		
		--- entradas controle ---
		MemparaReg	=> 	wire_MEMWB_WRITEBACK_MemparaReg_WB,		--- MEM/WB
		
		--- saidas ---
		wrdata		=> 	wire_WRITEBACK_DECODE_wrdata				--- DECODE 
	);
	
	
	
end behavior;