library verilog;
use verilog.vl_types.all;
entity FETCH is
    port(
        clk             : in     vl_logic;
        OrigPC          : in     vl_logic;
        branch_addr     : in     vl_logic_vector(31 downto 0);
        PC_4            : out    vl_logic_vector(31 downto 0);
        Instrucao       : out    vl_logic_vector(31 downto 0)
    );
end FETCH;
