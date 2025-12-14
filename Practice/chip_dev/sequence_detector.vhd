library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity sequence_detector is 
    generic(
        DATA_WIDTH : integer := 4
    );
    port(
        i_clk  : in std_ulogic;
        i_nrst : in std_ulogic;
        i_data : in std_ulogic;
        o_data : out std_ulogic
    );
end entity sequence_detector;

architecture RTL of sequence_detector is 
    signal buffer : std_ulogic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
begin 
    process(i_clk) is 
    begin 
        if(rising_edge(i_clk)) then 
            if(i_nrst = '0') then 
                buffer <= (others => '0');
                o_data <= '0';
            else 
                buffer <= buffer(DATA_WIDTH-2 downto 0) & i_data;
                if(buffer(DATA_WIDTH-2 downto 0) & i_data = "1010") then 
                    o_data <= '1';
                else 
                    o_data <= '0';
                end if;
            end if;
        end if;
    end process;
end architecture RTL;