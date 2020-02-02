library verilog;
use verilog.vl_types.all;
entity DECODE is
    port(
        clk             : in     vl_logic;
        Instrucao       : in     vl_logic_vector(31 downto 0);
        wraddr          : in     vl_logic_vector(4 downto 0);
        wrdata          : in     vl_logic_vector(31 downto 0);
        EscreveReg      : in     vl_logic;
        OpAlu0_E        : out    vl_logic;
        OpAlu1_E        : out    vl_logic;
        OrigAlu_E       : out    vl_logic;
        RegDst_E        : out    vl_logic;
        Branch_M        : out    vl_logic;
        EscreveMem_M    : out    vl_logic;
        EscreveReg_W    : out    vl_logic;
        MemparaReg_W    : out    vl_logic;
        Immediate       : out    vl_logic_vector(31 downto 0);
        rt              : out    vl_logic_vector(4 downto 0);
        rd              : out    vl_logic_vector(4 downto 0);
        reg1            : out    vl_logic_vector(31 downto 0);
        reg2            : out    vl_logic_vector(31 downto 0)
    );
end DECODE;
