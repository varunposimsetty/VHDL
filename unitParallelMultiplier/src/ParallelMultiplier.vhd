library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ParallelMultiplier is 
    generic (
        count := 4; -- number of bits in multiplicand and multiplier 
    );
    port (
        a       : in std_ulogic_vector(count-1 downto 0);
        b       : in std_ulogic_vector(count-1 downto 0);
        product : out std_ulogic_vector (2*count -1 downto 0)
    );
end entity ParallelMultiplier;

architecture RTL of ParallelMultiplier is 
signal bit_product : std_ulogic_vector(2*count-1 downto 0) := (others => '0');
signal partial_sum  : std_l
    generate_a for i in 0 to count-1 generate 
        generate_b for j in 0 to count-1 generate 
            
            