library verilog;
use verilog.vl_types.all;
entity DECODE_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        EscreveReg      : in     vl_logic;
        Instrucao       : in     vl_logic_vector(31 downto 0);
        wraddr          : in     vl_logic_vector(4 downto 0);
        wrdata          : in     vl_logic_vector(31 downto 0);
        sampler_tx      : out    vl_logic
    );
end DECODE_vlg_sample_tst;
