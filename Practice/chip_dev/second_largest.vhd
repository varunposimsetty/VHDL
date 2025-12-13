library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity second_largest is 
    generic(
        DATA_WIDTH : integer := 32
    );
    port (
        i_clk  : in std_ulogic;
        i_nrst : in std_ulogic;
        d_in   : in unsigned(DATA_WIDTH-1 downto 0);
        d_out  : out unsigned(DATA_WIDTH-1 downto 0)
    );
end entity second_largest;

architecture RTL of second_largest is 
    type t_state is (ZERO,ONE);
    signal sys_state : t_state := ZERO;
    signal largest : unsigned(DATA_WIDTH-1 downto 0) := (others => '0');
    signal second_largest : unsigned(DATA_WIDTH-1 downto 0) := (others => '0');
begin 
    process(i_clk) is 
    begin 
        if(rising_edge(i_clk)) then 
            if(i_nrst = '0') then 
                d_out <= (others => '0');
                sys_state <= ZERO;
                largest <= (others => '0');
                second_largest <= (others => '0');
            else 
                if(sys_state = ZERO) then 
                    largest <= d_in;
                    d_out <= (others => '0');
                    sys_state <= ONE;
                elsif(sys_state = ONE) then 
                    if(d_in > largest) then 
                        largest <= d_in;
                        second_largest <= largest;
                    elsif(d_in < largest and d_in > second_largest) then 
                        second_largest <= d_in;
                    end if;
                    d_out <= second_largest;
                end if;
            end if;
        end if;
    end process;
end architecture RTL;