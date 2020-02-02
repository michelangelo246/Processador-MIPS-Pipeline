library verilog;
use verilog.vl_types.all;
entity MIPS is
    port(
        clk             : in     vl_logic;
        PC_4            : out    vl_logic_vector(31 downto 0);
        instrucao       : out    vl_logic_vector(31 downto 0);
        resultadoULA    : out    vl_logic_vector(31 downto 0);
        MemOut          : out    vl_logic_vector(31 downto 0);
        reg1Out         : out    vl_logic_vector(31 downto 0);
        reg2Out         : out    vl_logic_vector(31 downto 0)
    );
end MIPS;
