library verilog;
use verilog.vl_types.all;
entity EXECUTE is
    port(
        PC_4            : in     vl_logic_vector(31 downto 0);
        reg1            : in     vl_logic_vector(31 downto 0);
        reg2            : in     vl_logic_vector(31 downto 0);
        Immediate       : in     vl_logic_vector(31 downto 0);
        rt              : in     vl_logic_vector(4 downto 0);
        rd              : in     vl_logic_vector(4 downto 0);
        OrigALU         : in     vl_logic;
        OpALU           : in     vl_logic_vector(1 downto 0);
        RegDST          : in     vl_logic;
        BranchAddr      : out    vl_logic_vector(31 downto 0);
        ALUzero         : out    vl_logic;
        ALUresult       : out    vl_logic_vector(31 downto 0);
        rdOut           : out    vl_logic_vector(4 downto 0)
    );
end EXECUTE;
