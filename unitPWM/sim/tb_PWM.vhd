library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb is 
end entity tb;

architecture bhv of tb is
    signal clk  : std_ulogic := '0';
    signal rst  : std_ulogic := '0';
    signal duty_cycle : unsigned(7 downto 0) := (others => '0');
    signal time_period : unsigned(7 downto 0) := (others => '0');
    signal enable : std_ulogic := '0';
    signal pwm_sig  : std_ulogic;
    
    begin
    DUT: entity work.PWM(RTL)
    port map(
        i_clk_100MHz => clk,
        i_nrst_async  => rst,
        i_duty_cycle => duty_cycle,
        i_time_period => time_period,
        i_enable  => enable ,
        o_pwm => pwm_sig
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
        wait for 1000 ns;
        duty_cycle <= x"0F";
        time_period <= x"2F";
        wait for 10 ns;
        enable <= '1';
        wait for 1000 ns;
        duty_cycle <= x"12";
        time_period <= x"24";
        wait for 2000 ns;
        duty_cycle <= x"65";
        time_period <= x"72";
        wait for 5000 ns;
        enable <= '0';
        wait for 1000 ns;
        rst <= '0';
        wait;
    end process proc_tb;
end architecture bhv;
