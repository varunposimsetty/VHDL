library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity bit_reverser is 
    generic (
        DATA_WIDTH : integer := 32
    );
    port(
        data_in : in std_ulogic_vector(DATA_WIDTH-1 downto 0);
        data_out : out std_ulogic_vector(DATA_WIDTH-1 downto 0)
    );
end entity bit_reverser;

architecture RTL of bit_reverser is 
begin 
    process(data_in) is 
    begin 
        for i in DATA_WIDTH-1 downto 0 loop 
            data_out(i) <= data_in(DATA_WIDTH-1-i);
        end loop;
    end process;
end architecture RTL;
