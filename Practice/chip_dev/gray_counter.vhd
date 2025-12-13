library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gray_counter is 
    generic (
        DATA_WIDTH : integer := 4
    );
    port (
        i_clk   : in std_ulogic;
        i_nrst  : in std_ulogic;
        o_count : out std_ulogic_vector(DATA_WIDTH-1 downto 0)
    );
end entity gray_counter;

architecture RTL of gray_counter is 
    signal bin_count : unsigned(DATA_WIDTH-1 downto 0);
   
    function bin2gray(a:std_logic_vector) return std_ulogic_vector is 
        variable temp_gray : std_ulogic_vector(a'high downto 0);
    begin 
        temp_gray(a'high) := a(a'high);
        for i in a'high-1 downto 0 loop 
            temp_gray(i) := a(i) xor a(i+1);
        end loop;
        return temp_gray;
    end function;

begin 
    process(i_clk)
        if(rising_edge(i_clk)) then 
            if(i_nrst = '0') then 
                bin_count <= (others => '0');
            else 
                bin_count <= bin_count + 1;
            end if;
        end if;

    end process;
    o_count <= bin2gray(std_ulogic_vector(bin_count));
end architecture RTL;