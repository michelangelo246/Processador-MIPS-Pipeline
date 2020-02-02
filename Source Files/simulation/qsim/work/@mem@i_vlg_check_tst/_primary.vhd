library verilog;
use verilog.vl_types.all;
entity MemI_vlg_check_tst is
    port(
        q               : in     vl_logic_vector(31 downto 0);
        sampler_rx      : in     vl_logic
    );
end MemI_vlg_check_tst;
