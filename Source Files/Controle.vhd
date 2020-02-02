---
---	Controle MIPS - OAC
---	Autor: Michelangelo da Rocha Machado - 14/0156089
---

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Controle is
	port
	(
		Instrucao	:	in std_logic_vector(31 downto 0);
		
		OpALU				:	out std_logic_vector(2 downto 0);
		OrigAluA			:	out std_logic := '0';
		OrigAluB			:	out std_logic := '0';
		RegDst			:	out std_logic_vector(1 downto 0) := "01";
		Branch			:	out std_logic := '0';
		BranchNot		:	out std_logic := '0';
		EscreveMem		:	out std_logic := '0';
		EscreveReg		:	out std_logic := '0';
		MemparaReg		:	out std_logic_vector(1 downto 0) := "01";
		Jump				:	out std_logic := '0';
		JumpR				:	out std_logic := '0'
	);
end Controle;

architecture behavior of Controle is
	signal opcode	: std_logic_vector(5 downto 0);
	signal funct	: std_logic_vector(5 downto 0);
	
begin
	opcode <= Instrucao(31 downto 26);
	funct <= Instrucao(5 downto 0);
	
	process(opcode,funct)
	begin
		case opcode is
			when "000000"	=> --- R-Type
							if funct = "001000" then --- Jump Register
								OpALU			<= "---";	
								RegDst		<= "00";
								OrigAluA		<= '0';
								OrigAluB		<= '0';
								Branch		<= '0';
								BranchNot	<= '0';
								EscreveMem	<= '0';
								EscreveReg	<= '0';
								MemparaReg	<= "01";
								Jump			<= '1';
								JumpR			<= '1';
							else 
								if funct = "001001" then --- Jump Register and Link
									OpALU			<= "---";	
									RegDst		<= "10";
									OrigAluA		<= '0';
									OrigAluB		<= '0';
									Branch		<= '0';
									BranchNot	<= '0';
									EscreveMem	<= '0';
									EscreveReg	<= '0';
									MemparaReg	<= "10";
									Jump			<= '1';
									JumpR			<= '1';
								else
									OpALU			<= "010";
									RegDst		<= "01";
									OrigAluA		<= '0';
									OrigAluB		<= '0';
									Branch		<= '0';
									BranchNot	<= '0';
									EscreveMem	<= '0';
									EscreveReg	<= '1';
									MemparaReg	<= "01";
									Jump			<= '0';
									JumpR			<= '0';
								end if;
							end if;
			when "100011"	=> --- LW
							OpALU			<= "000";
							RegDst		<= "00";
							OrigAluA		<= '0';
							OrigAluB		<= '1';
							Branch		<= '0';
							BranchNot	<= '0';
							EscreveMem	<= '0';
							EscreveReg	<= '1';
							MemparaReg	<= "00";
							Jump			<= '0';
							JumpR			<= '0';
			when "101011"	=> --- SW
							OpALU			<= "000";
							RegDst		<= "00";
							OrigAluA		<= '0';
							OrigAluB		<= '1';
							Branch		<= '0';
							BranchNot	<= '0';
							EscreveMem	<= '1';
							EscreveReg	<= '0';
							MemparaReg	<= "00";
							Jump			<= '0';
							JumpR			<= '0';
			when "000100"	=> --- BEQ 
							OpALU			<= "001";
							RegDst		<= "00";
							OrigAluA		<= '0';
							OrigAluB		<= '0';
							Branch		<= '1';
							BranchNot	<= '1';
							EscreveMem	<= '0';
							EscreveReg	<= '0';
							MemparaReg	<= "00";
							Jump			<= '0';
							JumpR			<= '0';
			when "000101"	=> --- BNE 
							OpALU			<= "001";
							RegDst		<= "00";
							OrigAluA		<= '0';
							OrigAluB		<= '0';
							Branch		<= '0';
							BranchNot	<= '1';
							EscreveMem	<= '0';
							EscreveReg	<= '0';
							MemparaReg	<= "00";
							Jump			<= '0';
							JumpR			<= '0';
			when "001000"	=> --- ADDi
							OpALU			<= "000";
							RegDst		<= "00";
							OrigAluA		<= '0';
							OrigAluB		<= '1';
							Branch		<= '0';
							BranchNot	<= '0';
							EscreveMem	<= '0';
							EscreveReg	<= '1';
							MemparaReg	<= "01";
							Jump			<= '0';
							JumpR			<= '0';
			when "001010"	=> --- SLTi 
							OpALU			<= "011";
							RegDst		<= "00";
							OrigAluA		<= '0';
							OrigAluB		<= '1';
							Branch		<= '0';
							BranchNot	<= '0';
							EscreveMem	<= '0';
							EscreveReg	<= '1';
							MemparaReg	<= "01";
							Jump			<= '0';
							JumpR			<= '0';
			when "001111"	=> --- LUI 
							OpALU			<= "100";
							RegDst		<= "00";
							OrigAluA		<= '1';
							OrigAluB		<= '1';
							Branch		<= '0';
							BranchNot	<= '0';
							EscreveMem	<= '0';
							EscreveReg	<= '1';
							MemparaReg	<= "01";
							Jump			<= '0';
							JumpR			<= '0';
			when "000010"	=> --- Jump
							OpALU			<= "---";
							RegDst		<= "00";
							OrigAluA		<= '0';
							OrigAluB		<= '0';
							Branch		<= '0';
							BranchNot	<= '0';
							EscreveMem	<= '0';
							EscreveReg	<= '0';
							MemparaReg	<= "01";
							Jump			<= '1';
							JumpR			<= '0';
			when "000011"	=> --- Jump and Link
							OpALU			<= "---";	
							RegDst		<= "10";		
							OrigAluA		<= '0';		
							OrigAluB		<= '0';		
							Branch		<= '0';		
							BranchNot	<= '0';		
							EscreveMem	<= '0';		
							EscreveReg	<= '0';		
							MemparaReg	<= "10";		
							Jump			<= '1';		
							JumpR			<= '0';			
			when others =>
							OpALU			<= "---";	--- Operacao a realizar na ALU											
							RegDst		<= "00";    --- Registrador a ser escrito é rt, rs ou $ra?						
							OrigAluA		<= '0';     --- Entrada A da alu <= reg1 ou 16 para realizar shift do LUI?	
							OrigAluB		<= '0';     --- Entrada B da alu <= reg2 ou Imediato								
							Branch		<= '0';     --- É um BEQ?																	
							BranchNot	<= '0';     --- É um BNE?																	
							EscreveMem	<= '0';     --- Escreve na memória?														
							EscreveReg	<= '0';     --- Escreve no banco de registradores?									
							MemparaReg	<= "00";    --- Saida da memória, saida da ULA ou PC+4?							
							Jump			<= '0';     --- É jump?																		
							JumpR			<= '0';     --- ...Jump Register?														
		end case;					
	end process;
	
end behavior;