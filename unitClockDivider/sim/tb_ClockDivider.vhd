library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb is 
end entity tb;

architecture bhv of tb is 
    signal clk : std_ulogic := '0';
    signal rst : std_ulogic := '0';
    signal enable : std_ulogic := '0';
    signal divided_clk : std_ulogic := '0';

    begin 
    DUT: entity work.ClockDivider(RTL)
    port map(
        i_clk_100MHz => clk,
        i_nrst_async => rst,
        i_enable => enable,
        divided_clk => divided_clk
    );

    proc_clk_gen : process is 
        begin
        wait for 5 ns;
        clk <= not clk;
    end process proc_clk_gen;

    proc_tb : process is 
            begin 
            wait for 1000 ns;
            rst <= '1';
            wait for 200 ns;
            enable <= '1';
            wait for 6000 ns;
            enable <= '0';
            wait for 1000 ns;
            enable <= '1';
            wait for 2000 ns;
            rst <= '0';
            wait for 2500 ns;
            rst <= '1';
            wait for 1000 ns;
            wait;
    end process proc_tb;
end architecture bhv;