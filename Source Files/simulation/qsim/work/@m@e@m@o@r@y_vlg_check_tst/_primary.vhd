library verilog;
use verilog.vl_types.all;
entity MEMORY_vlg_check_tst is
    port(
        OrigPC          : in     vl_logic;
        rdata           : in     vl_logic_vector(31 downto 0);
        sampler_rx      : in     vl_logic
    );
end MEMORY_vlg_check_tst;
