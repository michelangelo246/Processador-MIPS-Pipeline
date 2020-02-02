library verilog;
use verilog.vl_types.all;
entity EXECUTE_vlg_check_tst is
    port(
        ALUresult       : in     vl_logic_vector(31 downto 0);
        ALUzero         : in     vl_logic;
        BranchAddr      : in     vl_logic_vector(31 downto 0);
        rdOut           : in     vl_logic_vector(4 downto 0);
        sampler_rx      : in     vl_logic
    );
end EXECUTE_vlg_check_tst;
