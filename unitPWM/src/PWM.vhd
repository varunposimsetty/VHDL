library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PWM is 
    port (
        i_clk_100MHz         : in std_ulogic;
        i_nrst_async         : in std_ulogic;
        i_duty_cycle         : in unsigned(7 downto 0);
        i_time_period        : in unsigned(7 downto 0);
        i_enable             : in std_ulogic;
        o_pwm                : out std_ulogic
    );
end entity PWM;

architecture RTL of PWM is 
signal count : unsigned(7 downto 0) := (others => '0');
signal pwm_sig   : std_ulogic := '0';

begin 
    proc_pwm : process(i_clk_100MHz,i_nrst_async)
        begin 
        if (i_nrst_async = '0') then
            count <= (others => '0'); 
            pwm_sig   <= '0';  
        elsif(rising_edge(i_clk_100MHz)) then 
            if (i_enable = '0') then
                pwm_sig <= '0';
                count <= (others => '0');
            elsif (i_enable = '1') then 
                if (count = i_time_period-1) then
                    pwm_sig <= '0';
                    count <= (others => '0'); 
                elsif (count <= i_duty_cycle-1) then 
                    pwm_sig <= '1';
                    count <= count + 1;
                else
                    pwm_sig <= '0';
                    count <= count + 1;
                end if;
            end if;
        end if;
    end process;
   o_pwm <= pwm_sig;
end architecture RTL;
