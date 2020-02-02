library verilog;
use verilog.vl_types.all;
entity FETCH_vlg_sample_tst is
    port(
        branch_addr     : in     vl_logic_vector(31 downto 0);
        clk             : in     vl_logic;
        OrigPC          : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end FETCH_vlg_sample_tst;
