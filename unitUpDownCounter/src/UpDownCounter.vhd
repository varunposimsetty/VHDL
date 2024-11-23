library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity UpDownCounter is 
    generic (
        Limit : integer := 100
    );
    port (
        i_clk_100MHz : in std_ulogic;
        i_async_rst  : in std_ulogic;
        trigger      : in std_ulogic;
        Y            : out integer 
    );
end entity UpDownCounter;

architecture RTL of UpDownCounter is 
signal count : integer := 0;
signal direction : std_ulogic := '0';
    begin 
    proc_update: process(i_clk_100MHz,i_async_rst) 
    begin 
    if (i_async_rst = '0') then 
        count <= 0;
    elsif (rising_edge(i_clk_100MHz)) then
        if (trigger = '1') then 
            if ((count < 100) and (direction = '0'))  then 
                count <= count + 1;
            elsif ((count = 100) and (direction = '0')) then 
                count <= count - 1;
                direction <= '1';
            elsif ((count < 100) and (direction = '1')) then 
                count <= count - 1;
            elsif ((count = 0) and (direction = '1')) then 
                count <= count + 1;
                direction <= '0';
            end if;
        end if;
    end if;
    end process;
Y <= count; 
end architecture RTL;


        