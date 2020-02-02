library verilog;
use verilog.vl_types.all;
entity MIPS_vlg_check_tst is
    port(
        instrucao       : in     vl_logic_vector(31 downto 0);
        MemOut          : in     vl_logic_vector(31 downto 0);
        PC_4            : in     vl_logic_vector(31 downto 0);
        reg1Out         : in     vl_logic_vector(31 downto 0);
        reg2Out         : in     vl_logic_vector(31 downto 0);
        resultadoULA    : in     vl_logic_vector(31 downto 0);
        sampler_rx      : in     vl_logic
    );
end MIPS_vlg_check_tst;
