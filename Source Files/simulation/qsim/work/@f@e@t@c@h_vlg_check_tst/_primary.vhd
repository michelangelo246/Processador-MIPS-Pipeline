library verilog;
use verilog.vl_types.all;
entity FETCH_vlg_check_tst is
    port(
        Instrucao       : in     vl_logic_vector(31 downto 0);
        PC_4            : in     vl_logic_vector(31 downto 0);
        sampler_rx      : in     vl_logic
    );
end FETCH_vlg_check_tst;
