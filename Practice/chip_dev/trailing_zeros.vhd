library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity trailing_zeros is 
    generic(
        DATA_WIDTH : integer := 16
    );
    port (
        data_in  : in std_ulogic_vector(DATA_WIDTH-1 downto 0);
        data_out : out std_ulogic_vector(DATA_WIDTH-1 downto 0)
    );
end entity trailing_zeros;

architecture RTL of trailing_zeros is 
begin 
    process(data_in) is 
        constant all_zeros : unsigned(DATA_WIDTH-1 downto 0) := (others => '0');
        variable count : unsigned(DATA_WIDTH-1 downto 0) := (others => '0');
    begin 
        count := (others => '0');
        zeros_loop: for i in 0 to DATA_WIDTH-1 loop 
            if(data_in(i) = '0') then 
                count := count + 1;
            elsif(data_in(i) = '1') then 
                exit zeros_loop;
            end if;
        end loop;
        data_out <= std_ulogic_vector(count);
    end process;
end architecture RTL;