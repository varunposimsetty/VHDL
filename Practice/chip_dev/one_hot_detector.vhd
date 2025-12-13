library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity one_hot is 
    generic(
        DATA_WIDTH : integer := 32
    );
    port(
        d_in  : in std_ulogic_vector(DATA_WIDTH-1 downto 0);
        d_out : out std_ulogic 
    );
end entity one_hot;

architecture RTL of one_hot is 
begin 
    process(d_in) is 
        variable count : integer range 0 to 31 := 0;
    begin 
        for i in DATA_WIDTH-1 downto 0 loop 
            if(d_in(i) = '1') then 
                count := count + 1;
            end if;
        end loop;
        d_out <= '1' when count = 1 else '0';
    end process;
end architecture RTL;