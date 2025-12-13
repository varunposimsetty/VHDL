library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fabinocci_generator is 
    generic(
        DATA_WIDTH : integer := 32
    );
    port(
        i_clk    : in std_ulogic;
        i_nrst   : in std_ulogic;
        data_out : out std_ulogic_vector(DATA_WIDTH-1 downto 0)
    );
end entity fabinocci_generator;

architecture RTL of fabinocci_generator is 
    signal prev : unsigned(DATA_WIDTH-1 downto 0) := x"00000001";
    signal current : unsigned(DATA_WIDTH-1 downto 0) := x"00000001";
    signal next_value : unsigned(DATA_WIDTH-1 downto 0) := x"00000001";
begin 
    process(i_clk) is 
    begin 
        if(rising_edge(i_clk)) then 
            if(i_nrst = '0') then 
                data_out <= (others => '0');
                prev <= x"00000001";
                current <= x"00000001";
            else 
                prev <= current;
                current <= next_value;
            end if;
        end if;
    end process;
    next_value <= prev + current;
    data_out <= std_ulogic_vector(next_value);
end architecture RTL;


