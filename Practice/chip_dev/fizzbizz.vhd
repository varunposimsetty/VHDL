library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fizzbizz is 
    generic(
        fizz : integer := 3;
        bizz : integer := 5;
        MAX_CYCLES : integer := 100
    );
    port(
        i_clk      : in std_ulogic;
        i_resetn   : in std_ulogic;
        o_fizz     : out std_ulogic;
        o_buzz     : out std_ulogic;
        o_fizzbizz : out std_ulogic
    );
end entity fizzbizz;

architecture RTL of fizzbizz is 
    signal count : integer range 0 to MAX_CYCLES-1 := 0;
begin 
    proc_check : process(i_clk) is 
    begin 
        if(rising_edge(i_clk))then 
            if(i_resetn = '0') then 
                count <= 0;
                o_fizz <= '0';
                o_buzz <= '0';
                o_fizzbizz <= '0';
            else 
                if(count = MAX_CYCLES-1) then 
                    count <= 0;
                else 
                    count <= count + 1;
                end if;
                o_fizz <= '1' when (count mod fizz = 0) else '0';
                o_buzz <= '1' when (count mod buzz = 0) else '0';
                o_fizzbizz <= '1' when ((count mod fizz = 0) and (count mod buzz = 0)) else '0';
            end if;
        end if;
    end process proc_check;
end architecture RTL;