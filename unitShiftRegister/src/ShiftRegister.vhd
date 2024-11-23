library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ShiftRegister is 
    generic (
        count : integer := 4 -- number of FF's 
    );
    port(
        i_clk_100MHz : in std_ulogic;
        i_async_rst  : in std_ulogic;
        i_enable     : in std_ulogic; -- when high it shift one bit to the right per clock cylce if low it holds the current value
        i_data       : in std_ulogic;
        i_load       : in std_ulogic_vector(count-1 downto 0);
        i_load_en    : in std_ulogic;
        o_data       : out std_ulogic_vector(count-1 downto 0);
        o_bit        : out std_ulogic
    );
end entity ShiftRegister;

architecture RTL of ShiftRegister is 
    signal state : std_ulogic_vector(count-1 downto 0) := (others => '0');
    signal data_bit : std_ulogic := '0';
    begin
    proc_shift: process(i_clk_100MHz,i_async_rst)
        begin 
        if (i_async_rst = '0') then
            state <= (others => '0');
        elsif (rising_edge(i_clk_100MHz)) then 
            if (i_load_en = '1') then 
                state <= i_load;
            end if;
            if(i_enable = '1') then
                data_bit <= state(0);
                state <= i_data & state(count-1 downto 1);
            else
                data_bit <= state(0);
                state <= state;
            end if;
        end if;
    end process;
    o_data <= state;
    o_bit <= data_bit;
end architecture RTL;
            
