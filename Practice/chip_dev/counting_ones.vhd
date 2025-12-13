library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity counting_ones is 
    generic(
        DATA_WIDTH : integer := 16
    );
    port(
        din  : in std_ulogic_vector(DATA_WIDTH-1 downto 0);
        dout : out std_ulogic_vector(3 downto 0)
    );
end entity counting_ones;

architecture RTL of counting_ones is 
begin 
    process(din) is 
    begin 
        variable count : unsigned(3 downto 0) := (others => '0');
        for i in DATA_WIDTH-1 downto 0 loop 
            if(din(i) = '1') then 
                count := count + 1;
            end if;
        end loop;
        dout <= std_ulogic_vector(count);
    end process;
end architecture RTL;