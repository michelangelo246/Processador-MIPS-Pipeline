library verilog;
use verilog.vl_types.all;
entity EXECUTE_vlg_sample_tst is
    port(
        Immediate       : in     vl_logic_vector(31 downto 0);
        OpALU           : in     vl_logic_vector(1 downto 0);
        OrigALU         : in     vl_logic;
        PC_4            : in     vl_logic_vector(31 downto 0);
        rd              : in     vl_logic_vector(4 downto 0);
        reg1            : in     vl_logic_vector(31 downto 0);
        reg2            : in     vl_logic_vector(31 downto 0);
        RegDST          : in     vl_logic;
        rt              : in     vl_logic_vector(4 downto 0);
        sampler_tx      : out    vl_logic
    );
end EXECUTE_vlg_sample_tst;
