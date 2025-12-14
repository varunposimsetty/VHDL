library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity alu is 
    generic(
        DATA_WIDTH : integer := 32
    );
    port(
        a_in      : in std_ulogic_vector(DATA_WIDTH-1 downto 0);
        b_in      : in std_ulogic_vector(DATA_WIDTH-1 downto 0);
        a_plus_b  : out std_ulogic_vector(DATA_WIDTH-1 downto 0);
        a_minus_b : out std_ulogic_vector(DATA_WIDTH-1 downto 0);
        not_a     : out std_ulogic_vector(DATA_WIDTH-1 downto 0);
        a_and_b   : out std_ulogic_vector(DATA_WIDTH-1 downto 0);
        a_or_b    : out std_ulogic_vector(DATA_WIDTH-1 downto 0);
        a_xor_b   : out std_ulogic_vector(DATA_WIDTH-1 downto 0)
    );
end entity alu;

architecture RTL of alu is 
begin 
    a_plus_b <= to_std_ulogic_vector((unsigned(a_in) + unsigned(b_in)),DATA_WIDTH);
    a_minus_b <= to_std_ulogic_vector((unsigned(a_in) - unsigned(b_in)),DATA_WIDTH);
    not_a <= not a_in;
    a_and_b <= a_in and b_in;
    a_or_b <= a_in or b_in;
    a_xor_b <= a_in xor b_in;
end architecture RTL;
