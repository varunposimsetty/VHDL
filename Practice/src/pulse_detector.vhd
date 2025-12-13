library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pulse_detector is 
    generic (
        COUNT_WIDTH : integer := 4
    );
    port (
        clk       : in std_logic;
        rst       : in std_logic;
        in_sig    : in std_logic;
        pulse_cnt : out std_logic_vector(COUNT_WIDTH-1 downto 0)
    );
end entity pulse_detector;

architecture RTL of pulse_detector is
    constant limit : std_logic_vector(COUNT_WIDTH-1 downto 0) := (others => '1');
    signal count : unsigned(COUNT_WIDTH-1 downto 0) := (others => '0');
    signal prev : std_logic := '0';
begin 
    proc : process(clk) begin 
        if(rising_edge(clk)) then 
            if(rst = '1') then 
                prev <= '0';
                count <= (others => '0');
            else 
                if(prev = '0' and in_sig = '1') then 
                    if(count = unsigned(limit)) then 
                        count <= (others => '0');
                    else 
                        count <= count + 1;
                    end if;
                end if;
            end if;
        pulse_cnt <= std_logic_vector(count);
        prev <= in_sig;
        end if;
    end process;
end architecture RTL;