library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

entity MuxNto1 is 
    generic (
        N : integer := 4
    );
    port (
        input_a : in std_ulogic_vector(N-1 downto 0);
        sel     : in std_ulogic_vector(integer(ceil(log2(real(N))))-1 downto 0);
        y       : out std_ulogic 
    );
end entity MuxNto1;

architecture RTL of MuxNto1 is 
    begin
    y <= input_a(to_integer(unsigned(sel)));
end architecture;
