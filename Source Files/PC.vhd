---
---	PC MIPS - OAC
---	Autor: Michelangelo da Rocha Machado - 14/0156089
---

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

Entity PC is
	generic (WSIZE : natural := 32);
	
   Port
	(		
		d   : in std_logic_vector(WSIZE-1 downto 0);
		clk : in std_logic;
		q   : out std_logic_vector(WSIZE-1 downto 0)
	);
End;

Architecture behave of PC is

begin
	process(clk)
		begin
			IF rising_edge(clk) THEN
            q <= d;
			end if;
	end process;
end;