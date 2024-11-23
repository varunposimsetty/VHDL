library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb is 
end entity tb;

architecture bhv of tb is 
    signal a_in : std_ulogic_vector(2 downto 0) := "000";
    signal Y_out : std_ulogic_vector(7 downto 0);
    begin
    DUT: entity work.mtoNdecoder(RTL)
    port map (
        a => a_in,
        Y => Y_out
    );

    proc_tb: process is 
        begin
        wait for 100 ns;
        a_in <= "001";
        wait for 100 ns;
        a_in <= "010";
        wait for 100 ns;
        a_in <= "011";
        wait for 100 ns;
        a_in <= "100";
        wait for 100 ns;
        a_in <= "101";
        wait for 100 ns;
        a_in <= "110";
        wait for 100 ns;
        a_in <= "111";
        wait for 800 ns;
        wait;
    end process proc_tb;
end architecture bhv;