library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity divisible_by_3 is 
    generic(
        BUFF_WIDTH : integer := 10
    );
    port(
        i_clk : in std_ulogic;
        i_nrst : in std_ulogic;
        i_data : in std_ulogic;
        o_data : out std_ulogic
    );
end entity divisible_by_3;

architecture RTL of divisible_by_3 is 
    signal buffer : std_ulogic_vector(BUFF_WIDTH-1 downto 0) := (others => '0');
    signal rem : integer range(0 to 2) := 0;

begin
    process(i_clk) is 
    begin 
        if(rising_edge(i_clk)) then 
            if(i_nrst = '0') then  
                buffer <= (others => '0');
                o_data <= '0';
                rem <= 0
            else 
                buffer <= buffer & i_data;
                if(rem = 0) then 
                    if(i_data = '1') then 
                        rem = 1
                    end if;
                elsif(rem = 1) then 
                    if(i_data = '1') then 
                        rem = 2;
                    end if;
                elsif(rem =2 ) then 
                    if(i_data = '1') then 
                        rem = 0;
                    end if;
                end if;
                o_data <= '1' when rem = 0 else 1;
            end if;
        end if;
    end process;
end architecture RTL;
