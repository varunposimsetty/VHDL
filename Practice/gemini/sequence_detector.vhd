library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sequence_detector is 
    generic(
        WIDTH : integer := 4
    );
    port (
        i_clk    : in std_ulogic;
        i_nrst   : in std_ulogic;
        i_signal : in std_ulogic;
        o_match  : out std_ulogic;
    );
end  entity sequence_detector;

architecture RTL of sequence_detector is 
    signal buffer : std_ulogic_vector(WIDTH-1 downto 0) := (others => '0');
begin 
    proc_sequence_detector : process(i_clk) then 
    begin 
        if(rising_edge(i_clk)) then 
            if(i_nrst = '0') then 
                buffer <= (others => '0');
                o_match <= '0';
            else 
                buffer <= buffer(WIDTH-2 downto 0) & i_signal;
                if(buffer = "1101") then 
                    o_match <= '1';
                else 
                    o_match <= '0';
                end if;
            end if;
        end if;
    end process proc_sequence_detector;
end architecture RTL;
