library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb is 
end entity tb;

architecture bhv of tb is
    signal clk  : std_ulogic := '0';
    signal rst  : std_ulogic := '0';
    signal enable : std_ulogic := '0';
    signal load   : std_ulogic_vector(3 downto 0) := (others => '0');
    signal Q : std_ulogic_vector(3 downto 0);  
    begin
    DUT: entity work.JohnsonCounter(RTL)
    port map(
        i_clk_100MHz => clk,
        i_async_rst  => rst,
        i_enable     => enable,
        i_load       => load,
        Q            => Q
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
        enable <= '0';
        wait for 2000 ns;
        enable <= '1';
        wait for 2000 ns;
        load <= "0001";
        wait for 2000 ns;
        enable <= '0';
        wait for 3000 ns;
        rst <= '0';
        wait for 200 ns;
        rst <= '1';
       wait for 100 ns;
        wait;
    end process proc_tb;
end architecture bhv;