library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ClockDivider is 
    generic (
        FACTOR : integer := 16 -- the factor by which we want to divide the clock
    );
    port (
        i_clk_100MHz : in  std_ulogic;
        i_nrst_async : in  std_ulogic;
        i_enable     : in std_ulogic;
        divided_clk  : out std_ulogic
    );
end entity ClockDivider;

architecture RTL of ClockDivider is 
signal count : integer := 0;
    begin 
        process (i_clk_100MHz,i_nrst_async)
        begin
        if (i_nrst_async = '0') then
            divided_clk <= '0';
            count <= 0;
        elsif(rising_edge(i_clk_100MHz)) then
            if (i_enable = '1') then
                if (count = FACTOR-1) then
                    divided_clk <= '1';
                    count <= 0;
                else 
                    divided_clk <= '0';
                    count <= count + 1;
                end if;
            end if;
        end if;
        end process;
end architecture RTL;