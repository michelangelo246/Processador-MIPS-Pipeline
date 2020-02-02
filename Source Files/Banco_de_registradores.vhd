---
---	Banco de registradores MIPS - OAC
---	Autor: Michelangelo da Rocha Machado - 14/0156089
---

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Breg is
	generic (WSIZE : natural := 32);
	port 
	(
		clk, wren 					: in std_logic;
		raddr1, raddr2, wraddr 	: in std_logic_vector(4 downto 0);
		wrdata 						: in std_logic_vector(31 downto 0);
		r1, r2 						: out std_logic_vector(31 downto 0)
	);
end Breg;

architecture behave of Breg is
subtype t_palavra is std_logic_vector(WSIZE-1 downto 0);
type t_array_palavra is array(0 to WSIZE-1) of t_palavra;
signal registrador : t_array_palavra;

begin
	-- leitura 1 --
	process(clk, registrador,raddr1)
	begin 
		if raddr1 = "00000" then
			r1 <= (others => '0');
		else
			r1 <= registrador(to_integer(unsigned(raddr1)));
		end if;
	end process;
	
	
	-- leitura 2 --
	process(clk, registrador,raddr2)
	begin 
		if raddr2 = "00000" then
			r2 <= (others => '0');
		else
			r2 <= registrador(to_integer(unsigned(raddr2)));
		end if;
	end process;
	
	
	-- escrita --
	process(clk) 
	begin
		if rising_edge(clk) then
			if wren = '1' then
					registrador(to_integer(unsigned(wraddr))) <= wrdata;
			end if;
		end if;
	end process;
	
end behave;
