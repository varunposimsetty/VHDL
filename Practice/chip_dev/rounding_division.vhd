library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rounding_division is 
    generic(
        DIV_LOG2 : integer := 3;
        OUT_WIDTH : integer := 32;
        IN_WIDTH : integer := DIV_LOG2 + OUT_WIDTH
    );
    port (
        data_in  : in std_ulogic_vector(IN_WIDTH-1 downto 0);
        data_out : out std_ulogic_vector(OUT_WIDTH-1 downto 0) 
    );
end entity rounding_division;

architecture RTL of rounding_division is 
    constant all_zeros : std_ulogic_vector(OUT_WIDTH-1 downto 0) := (others => '0');
    signal intermediate : std_ulogic_vector(IN_WIDTH-1 downto 0):= (others => '0') ;
    signal sum_intermediate : std_ulogic_vector(IN_WIDTH downto 0) := (others => '0');
begin 
    process(all) then 
    begin 
        intermediate <= data_in srl DIV_LOG2;
        if(data_in(DIV_LOG2-1) = '1') then 
            sum_intermediate <= std_logic_vector(unsigned(intermediate) + 1);
            if(sum_intermediate(OUT_WIDTH-1 downto 0) = all_zero) then 
                data_out <= intermediate(OUT_WIDTH-1 downto 0);
            else 
                data_out <= sum_intermediate(OUT_WIDTH-1 downto 0);
            end if;
        else 
            data_out <= intermediate(OUT_WIDTH-1 downto 0);
        end if;
    end process;
end architecture RTL;