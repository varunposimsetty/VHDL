library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity divied_even_clock is 
    port (
        i_clk : in std_ulogic;
        i_resetn : in std_ulogic;
        o_div2 : out std_ulogic;
        o_div4 : out std_ulogic;
        o_div6 : out std_ulogic
    );
end entity divied_even_clock;

architecture RTL of divied_even_clock is 
    signal count_2 : integer range 0 to 1 := 0;
    signal count_4 : integer range 0 to 3 := 0;
    signal count_6 : integer range 0 to 5 := 0;
begin 
    proc_clock : process(i_clk) is 
    begin 
        if(rising_edge(i_clk)) then 
            if(i_resetn = '0') then 
                count_2 <= 0;
                count_4 <= 0;
                count_6 <= 0;
                o_div2 <= '0';
                o_div4 <= '0';
                o_div6 <= '0';
            else 
                case(count_2) is 
                    when 0 => 
                        count_2 <= count_2 + 1;
                        o_div2 <= '1';
                    when 1 => 
                        count_2 <= 0;
                        o_div2 <= '0';
                    when others => 
                        null;
                end case;

                case(count_4) is 
                    when 0 to 2 => 
                        count_4 <= count_4 + 1;
                        if(count_4 < 2) then 
                            o_div4 <= '1';
                        else 
                            o_div4 <= '0';
                        end if;
                    when 3 => 
                        count_4 <= 0;
                        o_div4 <= '0';
                    when others => 
                        null;
                end case;

                case(count_6) is 
                    when 0 to 4 => 
                        count_6 <= count_6 + 1;
                        if(count_6 < 3) then 
                            o_div6 <= '1';
                        else 
                            o_div6 <= '0';
                        end if;
                    when 5 => 
                        count_6 <= 0;
                        o_div6 <= '0';
                    when others => 
                        null;
                end case;
            end if;
        end if;
    end process proc_clock;
end architecture RTL;