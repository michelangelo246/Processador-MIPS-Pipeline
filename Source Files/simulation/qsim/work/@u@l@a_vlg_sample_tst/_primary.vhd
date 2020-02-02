library verilog;
use verilog.vl_types.all;
entity ULA_vlg_sample_tst is
    port(
        A               : in     vl_logic_vector(31 downto 0);
        B               : in     vl_logic_vector(31 downto 0);
        ctrl_opcode     : in     vl_logic_vector(3 downto 0);
        sampler_tx      : out    vl_logic
    );
end ULA_vlg_sample_tst;
