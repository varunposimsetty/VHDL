library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ripple_carry_adder is 
    generic(
        DATA_WIDTH : integer := 8
    );
    port(
        a : in std_ulogic_vector(DATA_WIDTH-1 downto 0);
        b : in std_ulogic_vector(DATA_WIDTH-1 downto 0);
        sum : out std_ulogic_vector(DATA_WIDTH downto 0);
        cout_int : out std_ulogic_vector(DATA_WIDTH-1 downto 0)
    );
end entity ripple_carry_adder;

architecture RTL of ripple_carry_adder is 
    signal c_in : std_ulogic_vector(DATA_WIDTH downto 0) := (others => '0');
    signal temp_sum : std_ulogic_vector(DATA_WIDTH-1 downto 0) := (others => '0')  
begin 
        c_in(0) <= '0'; 
        for i in 0 to DATA_WIDTH-1 generate
            FULL_ADDER : entity full_adder(RTL) 
                port map (
                    a_in => a(i),
                    b_in => b(i),
                    c_in => c_in(i),
                    sum => temp_sum(i),
                    carry => c_in(i+1)
            );
        end generate;
        cout_int <= c_in(DATA_WIDTH-1 downto 0);
        sum <= c_in(DATA_WIDTH) & temp_sum;
        end process;
end architecture RTL;