library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity parallel_in_serial_out is 
    generic(
        DATA_WIDTH : integer := 16
    );
    port (
        i_clk    : in std_ulogic;
        i_nrst   : in std_ulogic;
        i_data   : in std_ulogic_vector(DATA_WIDTH-1 downto 0);
        i_din_en : in std_ulogic;
        o_dout   : out std_ulogic
    );
end entity parallel_in_serial_out;

architecture RTL of parallel_in_serial_out is 
    signal buffer : std_ulogic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
begin 
    process(i_clk) then 
        if(rising_edge(i_clk)) then 
            if(i_nrst = '0') then 
                o_dout <= '0';
            else 
                if(i_din_en = '1') then 
                    buffer <= i_data;
                else 
                    buffer <= '0' & buffer(DATA_WIDTH-1 downto 1);
                    o_dout <= buffer(0);
                end if;
            end if;
        end if;
    end process;
end architecture RTL;