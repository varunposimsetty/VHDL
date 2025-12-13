library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cyclic_shifter is 
    generic(
        DATA_WIDTH : integer := 8
    );
    port (
        i_clk : in std_ulogic;
        i_nrst : in std_ulogic;
        i_data : in std_ulogic_vector(DATA_WIDTH-1 downto 0);
        i_direction : in std_ulogic; -- 0 right shift and 1 left shift 
        o_data : out std_ulogic_vector(DATA_WIDTH-1 downto 0)
    );
end entity cyclic_shifter;

architecture RTL of cyclic_shifter is 
    signal buffer : std_ulogic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
begin 
    process(i_clk) 
    begin 
    if(rising_edge(i_clk)) then 
        if(i_nrst = '0') then 
            o_data <= (others => '0');
        else 
            buffer <= i_data;
            if(i_direction = '0') then 
                o_data <= buffer(0) & buffer(DATA_WIDTH-2 downto 0);
            else 
                o_data <= buffer(DATA_WIDTH-2 downto 0) & buffer(DATA_WIDTH-1);
            end if;
        end if;
    end if;
end process;


end architecture RTL;