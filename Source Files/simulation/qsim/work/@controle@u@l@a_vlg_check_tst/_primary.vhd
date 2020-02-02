library verilog;
use verilog.vl_types.all;
entity ControleULA_vlg_check_tst is
    port(
        ALUctrl         : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end ControleULA_vlg_check_tst;
