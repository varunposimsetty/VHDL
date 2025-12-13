library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity rising_edge_dectector is 
    port (
        i_clk  : in std_ulogic;
        i_nrst : in std_ulogic;
        i_din  : in std_ulogic;
        o_dout : out std_ulogic
    );
end entity rising_edge_dectector;

architecture RTL of rising_edge_dectector is 
    signal prev : std_ulogic := '0';
begin 
    process(i_clk) is 
    begin 
        if(rising_edge(i_clk)) then 
            if(i_nrst = '0') then 
                o_dout <= '0';
            else 
                prev <= i_din;
                if(prev = '0' and i_din = '1') then 
                    o_dout <= '1';
                else 
                    o_dout <= '0';
                end if;
            end if;
        end if;
    end process;
end architecture RTL;
