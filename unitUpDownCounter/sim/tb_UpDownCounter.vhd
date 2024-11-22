library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb is 
end entity tb;

architecture bhv of tb is
    signal clk  : std_ulogic := '0';
    signal rst  : std_ulogic := '0';
    signal trigger : std_ulogic := '0';
    signal y  : integer;  
    begin
    DUT: entity work.UpDownCounter(RTL)
    port map(
        i_clk_100MHz => clk,
        i_async_rst  => rst,
        trigger      => trigger,
        Y            => y
    );
    proc_clk_gen : process is 
        begin
        wait for 5 ns;
        clk <= not clk;
    end process proc_clk_gen;

    proc_tb: process is 
        begin 
        wait for 100 ns;
        rst <= '1';
        wait for 100 ns;
        trigger <= '1';
        wait for 2000 ns;
        trigger <= '0';
        wait for 100 ns;
        trigger <= '1';
        wait for 3000 ns;
        rst <= '0';
        wait for 200 ns;
        rst <= '1';
       wait for 100 ns;
        wait;
    end process proc_tb;
end architecture bhv;
