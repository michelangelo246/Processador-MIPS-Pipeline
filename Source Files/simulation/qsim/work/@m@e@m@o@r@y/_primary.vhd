library verilog;
use verilog.vl_types.all;
entity MEMORY is
    port(
        Branch          : in     vl_logic;
        EscreveMem      : in     vl_logic;
        wraddr          : in     vl_logic_vector(7 downto 0);
        wrdata          : in     vl_logic_vector(31 downto 0);
        ALUzero         : in     vl_logic;
        clk             : in     vl_logic;
        rdata           : out    vl_logic_vector(31 downto 0);
        OrigPC          : out    vl_logic
    );
end MEMORY;
