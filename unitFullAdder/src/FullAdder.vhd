library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity FullAdder is 
    port (
        input_a    : in std_ulogic;
        input_b    : in std_ulogic;
        carry_in   : in std_ulogic;
        output_sum : out std_ulogic;
        carry_out  : out std_ulogic
    );
end entity FullAdder;

architecture RTL of FullAdder is 
begin 
    output_sum <= (input_a) xor (input_b) xor (carry_in);
    carry_out  <= (input_a and input_b) or (input_b and carry_in) or (carry_in and input_a);
end architecture RTL;