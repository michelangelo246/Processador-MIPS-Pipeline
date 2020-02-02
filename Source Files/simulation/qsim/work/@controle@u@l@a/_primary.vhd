library verilog;
use verilog.vl_types.all;
entity ControleULA is
    port(
        OpALU           : in     vl_logic_vector(1 downto 0);
        funct           : in     vl_logic_vector(5 downto 0);
        ALUctrl         : out    vl_logic_vector(3 downto 0)
    );
end ControleULA;
