library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

entity mtoNdecoder is 
    generic(
        m : integer := 3;
        N : integer := 8
    );
    port(
        a : in std_ulogic_vector(m-1 downto 0);
        Y : out std_ulogic_vector(N-1 downto 0)
    );
end entity mtoNdecoder;

architecture RTL of mtoNdecoder is 
   signal k : integer := 0;
   signal p : std_ulogic_vector(N-1 downto 0) := (others => '0');
   begin 
    process(a)
    begin 
        k <= to_integer(unsigned(a));
        for i in 0 to N-1 loop
            if (i = k) then 
                p(i) <= '1';
            else 
                p(i) <= '0';
            end if;
        end loop;
    end process;
    y <= p;
end architecture RTL;