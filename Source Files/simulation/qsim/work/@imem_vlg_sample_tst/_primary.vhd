library verilog;
use verilog.vl_types.all;
entity Imem_vlg_sample_tst is
    port(
        address         : in     vl_logic_vector(7 downto 0);
        clock           : in     vl_logic;
        data            : in     vl_logic_vector(31 downto 0);
        wren            : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end Imem_vlg_sample_tst;
