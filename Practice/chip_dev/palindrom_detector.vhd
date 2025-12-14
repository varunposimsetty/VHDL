library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity palindrom_detector is 
    generic(
        DATA_WIDTH : integer := 32
    );
    port(
        data_in  : in std_ulogic_vector(DATA_WIDTH-1 downto 0);
        data_out : out std_ulogic
    );
end entity palindrom_detector;

architecture RTL of palindrom_detector is 
begin 
    process(data_in) is 
        variable check : std_ulogic := '0';
    begin 
        check_loop : for i in DATA_WIDTH-1 downto DATA_WIDTH/2 loop
            if(data_in(i) /= data_in(DATA_WIDTH-1-i)) then 
                check := '1';
                exit check_loop;
            end if;
        end loop;
        data_out <= not check;
    end process;
end architecture RTL;
