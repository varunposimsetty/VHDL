library IEEE;
use IEEE.std_logic_1164.all;

entity tb is
end entity tb;

architecture bhv of tb is 
    signal a     :  std_ulogic := '0';
    signal b     :  std_ulogic := '0';
    signal c_in  :  std_ulogic := '0';
    signal sum   :  std_ulogic ;
    signal c_out :  std_ulogic ;

begin 

    DUT : entity work.FullAdder(RTL)
    port map (
        input_a => a,
        input_b => b,
        carry_in => c_in,
        output_sum => sum,
        carry_out => c_out
    );


    proc_tb: process is 
        begin 
        wait for 100 ns; 
        a <= '1';
        wait for 100 ns;
        a <= '0';
        wait for 100 ns;
        b <= '1';
        wait for 100 ns;
        a <= '1';
        wait for 100 ns;
        b <= '1';
        wait;

    end process proc_tb;
end architecture bhv;
