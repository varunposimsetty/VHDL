library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pulse_detector is 
    GENERIC (
        count_width : integer := 4
    );
    port (
        clk       : in std_ulogic;
        rst       : in std_ulogic;
        in_sig    : in std_ulogic;
        pulse_cnt : out std_ulogic_vector(count_width-1 downto 0)

    );
end entity pulse_detector;

architecture RTL of pulse_detector is 
    signal previous : std_ulogic := '0';
    signal count : unsigned(count_width-1 downto 0) := (others => '0');
begin 
    process(clk) begin 
        if(rising_edge(clk)) then 
            if(rst = '1') then  
                previous <= '0';
                count <= (others => '0');
            else 
                if(previous = '0' and in_sig = '1') then 
                    if(count = (others => '1')) then 
                        count <= (others => '0');
                    else 
                        count <= count + 1;
                    end if;
                end if;
                previous <= in_sig;
            end if;
        end if;
    end process;
    pulse_cnt <= std_ulogic_vector(count);
end architecture RTL;