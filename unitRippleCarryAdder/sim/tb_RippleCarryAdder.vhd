library IEEE;
use IEEE.std_logic_1164.all;

entity tb is 
end entity;

architecture bhv of tb is 
    signal a : std_ulogic_vector(3 downto 0) := "0000";
    signal b : std_ulogic_vector(3 downto 0) := "0000";
    signal c_in : std_ulogic := '0';
    signal sum : std_ulogic_vector(3 downto 0);
    signal c_out : std_ulogic;

begin
    DUT: entity work.RippleCarryAdder(RTL)
    port map (
        a_input_dataword    => a,
        b_input_dataword    => b,
        input_carry         => c_in,
        sum_output_dataword => sum,
        output_carry        => c_out
    );

    proc_tb: process is 
        begin
        wait for 100 ns;
        a <= "0001";
        wait for 100 ns;
        b <= "0010";
        wait for 100 ns;
        a <= "1010";
        wait for 100 ns;
        c_in <= '1';
        wait for 100 ns;
        a <= "1111";
        wait for 100 ns;
        b <= "1111";
        wait for 100 ns;
        c_in <= '0';
        wait for 100 ns;
        b <= "1010";
        wait for 100 ns;
        a <= "1100";
        wait;
    end process proc_tb;
end architecture bhv;
