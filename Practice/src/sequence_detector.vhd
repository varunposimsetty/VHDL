library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sequence_detector is 
    generic (
        SEQUENCE_LENGTH := 4
    );
    port (
        i_clk         : in std_ulogic;
        i_nrst_async  : in std_ulogic;
        i_data        : in std_ulogic;
        o_data_vector : out std_ulogic_vector(SEQUENCE_LENGTH-1 downto 0);
        o_ready       : out std_ulogic
    );
end entity sequence_detector;

architecture RTL of sequence_detector is 
    signal detect : std_ulogic_vector(SEQUENCE_LENGTH-1 downto 0) := "0010";
    signal buffer : std_ulogic_vector(SEQUENCE_LENGTH-1 downto 0) := (others => '0');
begin 
    proc_data : process(i_clk,i_nrst_async) is 
        begin 
            if(i_nrst_async = '0') then 
                buffer <= (others => '0');
            else 
                buffer <= buffer(SEQUENCE_LENGTH-2 downto 0) & i_data;
                if(buffer == detect) then 
                    o_data_vector <= buffer;
                    o_ready <= '1';
                else 
                    o_ready <= '0';
                end if;
            end if;
    end process proc_data;
end architecture RTL;