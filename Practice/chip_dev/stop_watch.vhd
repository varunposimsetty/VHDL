library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stop_watch is 
    generic(
        MAX : integer := 99;
        DATA_WIDTH : integer := 16
    );
    port(
        i_clk   : in std_ulogic;
        i_reset : in std_ulogic;
        i_start : in std_ulogic;
        i_stop  : in std_ulogic;
        o_count : out std_ulogic_vector(DATA_WIDTH-1 downto 0)
    );
end entity stop_watch;

architecture RTL of stop_watch is 
    type t_state is (IDLE,START,COUNTING,STOP);
    signal current_state : t_state := IDLE;
    signal count : unsigned(DATA_WIDTH-1 downto 0) := (others => '0');
begin 
    process(i_clk) is 
    begin 
        if(rising_edge(i_clk)) then 
            if(i_reset = '0') then 
                count <= (others => '0');
                current_state <= IDLE;
            elsif(current_state = IDLE and start = '1') then 
                current_state <= COUNTING;
            elsif(current_state = COUNTING) then 
                if(i_stop = '1') then 
                    current_state <= STOP;
                else 
                    if(count = MAX) then 
                        count <= (others => '0');
                    else 
                        count <= count + 1;
                    end if;
                end if;
            elsif(current_state = STOP) then 
                if(i_start = '1') then 
                    current_state <= COUNTING;
                end if;
            end if;
        end if;
    end process;
    o_count <= std_ulogic_vector(count);
end architecture RTL;