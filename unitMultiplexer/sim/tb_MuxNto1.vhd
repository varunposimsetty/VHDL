library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb is 
end entity tb;

architecture bhv of tb is
    signal a   : std_ulogic_vector(3 downto 0) := "0000";
    signal select_line : std_ulogic_vector(1 downto 0) := "00";
    signal y_o  : std_ulogic;  
    begin
    DUT: entity work.MuxNto1(RTL)
    port map(
        input_a => a,
        sel => select_line,
        y  => y_o 
    );
    proc_tb: process is 
        begin 
        wait for 100 ns;
        a <= "0001";
        wait for 100 ns;
        select_line <= "01";
        wait for 100 ns;
        a <= "0010";
        wait for 100 ns;
        a <= "0100";
        wait for 100 ns;
        select_line <= "10";
        wait for 100 ns;
        a <= "1001";
        wait for 100 ns;
        select_line <= "01";
        a <= "0101";
        wait for 100 ns;
        a <= "1111";
        wait for 100 ns;
        wait;
    end process proc_tb;
end architecture bhv;

    
