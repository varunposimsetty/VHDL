library ieee;
use ieee.std_logic_1164.all;
use ieee.std_numeric.all;

entity rv_rate_limiter is 
    generic (
        G_CAPACITY : integer := 8;
        G_REFILL : integer := 16
    );
    port (
        clock : in std_ulogic;
        reset : in std_ulogic;
        i_valid : in std_ulogic;
        o_ready : out std_ulogic;
        i_data : in std_ulogic_vector(31 downto 0);
        o_valid : out std_ulogic;
        i_ready : in std_ulogic;
        o_data : out std_ulogic_vector(31 downto 0)
    );
end entity rv_rate_limiter;

architecture RTL of rv_rate_limiter is 

begin 
    process(clock) begin 
        if(rising_edge(clock)) then 
            if(reset = '1') then 

            else 

            end if;
        end  if;
    end process;
end architecture RTL;
