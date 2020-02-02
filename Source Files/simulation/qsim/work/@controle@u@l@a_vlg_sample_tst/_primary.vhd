library verilog;
use verilog.vl_types.all;
entity ControleULA_vlg_sample_tst is
    port(
        funct           : in     vl_logic_vector(5 downto 0);
        OpALU           : in     vl_logic_vector(1 downto 0);
        sampler_tx      : out    vl_logic
    );
end ControleULA_vlg_sample_tst;
