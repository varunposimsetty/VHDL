library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb is 
end entity tb;

architecture bhv of tb is
    signal clk  : std_ulogic := '0';
    signal rst  : std_ulogic := '0';
    signal enable : std_ulogic := '0';
    signal input_data : std_ulogic := '0';
    signal input_load : std_ulogic_vector(3 downto 0) := "0000";
    signal load_en : std_ulogic := '0';
    signal output_data : std_ulogic_vector(3 downto 0);
    signal output_bit : std_ulogic; 
    begin
    DUT: entity work.ShiftRegister(RTL)
    port map(
        i_clk_100MHz => clk,
        i_async_rst  => rst,
        i_enable     => enable,
        i_data       => input_data,
        i_load       => input_load,
        i_load_en    => load_en,
        o_data       =>  output_data,
        o_bit        => output_bit
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
        enable <= '1';
        wait for 100 ns;
        load_en <= '1';
        wait for 800 ns;
        input_load <= "1010";
        wait for 100 ns;
        load_en <= '0'; 
        wait for 2000 ns;
        enable <= '0';
        wait for 100 ns;
        load_en <= '1';
        wait for 100 ns;
        input_load <= "0101";
        wait for 100 ns;
        enable <= '1';
        wait for 2000 ns;
        rst <= '0';
        wait;
    end process proc_tb;

    proc_data : process is 
            begin 
            wait for 500 ns;
            input_data <= not input_data;
    end process proc_data;
end architecture bhv;
