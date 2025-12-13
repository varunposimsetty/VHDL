library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gray2bin is 
    generic(
        DATA_WIDTH : integer := 16
    );
    port(
        data_in  : in std_ulogic_vector(DATA_WIDTH-1 downto 0);
        data_out : out std_ulogic_vector(DATA_WIDTH-1 downto 0)
    );
end entity gray2bin;

architecture RTL of gray2bin is 
begin 
    process(all) is 
    begin 
        data_out(DATA_WIDTH-1) <= data_in(DATA_WIDTH-1);
        for i in DATA_WIDTH-2 downto 0 loop
            data_out(i) <= data_out(i+1) xor data_in(i);
        end loop;
    end process;
end architecture RTL;