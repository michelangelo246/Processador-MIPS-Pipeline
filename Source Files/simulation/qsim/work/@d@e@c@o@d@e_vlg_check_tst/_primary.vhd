library verilog;
use verilog.vl_types.all;
entity DECODE_vlg_check_tst is
    port(
        Branch_M        : in     vl_logic;
        EscreveMem_M    : in     vl_logic;
        EscreveReg_W    : in     vl_logic;
        Immediate       : in     vl_logic_vector(31 downto 0);
        MemparaReg_W    : in     vl_logic;
        OpAlu0_E        : in     vl_logic;
        OpAlu1_E        : in     vl_logic;
        OrigAlu_E       : in     vl_logic;
        rd              : in     vl_logic_vector(4 downto 0);
        reg1            : in     vl_logic_vector(31 downto 0);
        reg2            : in     vl_logic_vector(31 downto 0);
        RegDst_E        : in     vl_logic;
        rt              : in     vl_logic_vector(4 downto 0);
        sampler_rx      : in     vl_logic
    );
end DECODE_vlg_check_tst;
