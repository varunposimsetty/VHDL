library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_adder is 
    port(
        a_in  : in std_ulogic;
        b_in  : in std_ulogic;
        c_in  : in std_ulogic;
        sum   : out std_ulogic;
        carry : out std_ulogic
    );
end entity full_adder;

architecture RTL of full_adder is 
begin 
    -- sum <= a_in xor b_in xor c_in;
    --carry <= (a_in and b_in) or (b_in and c_in) or (c_in and a_in);
    proc_sum : process(a_in,b_in,c_in) is 
        variable buffer : std_ulogic_vector(1 downto 0) := "00";
    begin 
        buffer := unsigned(a_in) + unsigned(b_in) + unsigned(c_in);
        sum <= std_ulogic(buffer(0));
        carry <= std_ulogic(buffer(1));
    end process proc_sum;
end architecture RTL;