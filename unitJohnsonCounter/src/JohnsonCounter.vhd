library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity JohnsonCounter is 
    generic(
        count : integer := 4 -- # of FF's in the system
    );
    port (
        i_clk_100MHz : in std_ulogic;
        i_async_rst  : in std_ulogic;
        i_enable     : in std_ulogic;
        i_load       : in std_ulogic_vector(count-1 downto 0);
        Q            : out std_ulogic_vector(count-1 downto 0)
    );
end entity JohnsonCounter;

architecture RTL of JohnsonCounter is 
    signal state : std_ulogic_vector(count-1 downto 0) := (others => '0');

    begin 
    proc_shift : process(i_clk_100MHz,i_async_rst) 
    begin 
        if(i_async_rst = '0') then
            state <= (others => '0');
        elsif(rising_edge(i_clk_100MHz)) then 
            if (i_load /= state) then
                state <= i_load;
            end if;
            if (i_enable = '0') then 
                state <= (not state(0)) & state(count-1 downto 1);
            elsif (i_enable = '1') then 
                state <= state(count-2 downto 0) & (not state(count-1));
            end if; 
        end if;
    end process proc_shift;
    Q <= state;
end architecture RTL;
