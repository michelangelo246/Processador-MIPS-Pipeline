---
---	WRITEBACK - OAC
---	Autor: Michelangelo da Rocha Machado - 14/0156089
---

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity WRITEBACK is
	generic (WSIZE : natural := 32);
	port
	(
		--- entradas ---
		SaidaMem		:	in std_logic_vector(31 downto 0);	--- MEM/WB
		SaidaALU		:	in std_logic_vector(31 downto 0);	--- MEM/WB
		LinkAddr		:	in std_logic_vector(31 downto 0);	--- MEM/WB
		
		--- entradas controle ---
		MemparaReg	:	in std_logic_vector(1 downto 0);		--- MEM/WB
		
		--- saidas ---
		wrdata		:	out std_logic_vector(31 downto 0)	--- DECODE
		
	);
end WRITEBACK;

architecture behavior of WRITEBACK is
	
begin
	
	with MemparaReg select
		wrdata <= SaidaMem when "00",
					 SaidaALU when "01",
					 LinkAddr when others;
	
end behavior;