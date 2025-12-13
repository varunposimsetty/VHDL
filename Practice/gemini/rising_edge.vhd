library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rising_edge_detector is 
    port (
        i_clk  : in std_ulogic;
        i_nrst : in std_ulogic;
        i_sig  : in std_ulogic;
        o_sig  : out std_ulogic
    );
end entity rising_edge_detector;

architecture RTL of rising_edge_detector is 
    signal prev_sig : std_ulogic := '0';
begin 
    proc_rising_edge : process(i_clk) is 
    begin 
        if(rising_edge(i_clk)) then 
            if(i_nrst = '0') then 
                prev_sig <= '0';
                o_sig <= '0';
            else 
                prev_sig <= i_sig;
                if(prev_sig = '0' and i_sig = '1') then 
                    o_sig <= '1';
                else 
                    o_sig <= '0';
                end if;
            end if;
        end if;
    end process proc_rising_edge;
end architecture RTL; 
                