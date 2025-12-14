library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity programmable_sequence_detector is 
    generic(
        DATA_WIDTH : integer := 5
    );
    port(
        i_clk     : in std_ulogic;
        i_reset   : in std_ulogic;
        i_init    : in std_ulogic_vector(DATA_WIDTH-1 downto 0);
        i_data_in : in std_ulogic;
        o_seen    : out std_ulogic
    );
end entity programmable_sequence_detector;

architecture RTL of programmable_sequence_detector is 
    signal buffer : std_ulogic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
    signal check : std_ulogic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
begin 
    proc_check : process(i_clk) is 
    begin 
        if(rising_edge(i_clk)) then 
            if(i_reset = '0') then 
                buffer <= (others => '0');
                check <= i_init;
                o_seen <= '0';
            else 
                buffer <= buffer(DATA_WIDTH-2 downto 0) & i_data_in;
                if((buffer(DATA_WIDTH-2 downto 0) & i_data_in) = i_init) then 
                    o_seen <= '1';
                else 
                    o_seen <= '0';
                end if;
            end if;
        end if;
    end process proc_check;
end architecture RTL;