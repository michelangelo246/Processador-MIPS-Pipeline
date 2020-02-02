library verilog;
use verilog.vl_types.all;
entity MEMORY_vlg_sample_tst is
    port(
        ALUzero         : in     vl_logic;
        Branch          : in     vl_logic;
        clk             : in     vl_logic;
        EscreveMem      : in     vl_logic;
        wraddr          : in     vl_logic_vector(7 downto 0);
        wrdata          : in     vl_logic_vector(31 downto 0);
        sampler_tx      : out    vl_logic
    );
end MEMORY_vlg_sample_tst;
