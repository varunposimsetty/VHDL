library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all ;

entity RippleCarryAdder is 
    generic (
        count : integer := 4
    );
    port (
        a_input_dataword    : in std_ulogic_vector(count-1 downto 0);
        b_input_dataword    : in std_ulogic_vector(count-1 downto 0);
        input_carry         : in std_ulogic;
        sum_output_dataword : out std_ulogic_vector(count-1 downto 0);
        output_carry        : out std_ulogic 
    );
end entity RippleCarryAdder;

architecture RTL of RippleCarryAdder is 
    signal carry : std_ulogic_vector(count downto 0);
    begin 
    carry(0) <= input_carry;
    
    generate_adders: for i in 0 to count-1 generate
        fa_inst : entity  work.FullAdder(RTL)
        port map (
            input_a => a_input_dataword(i) ,
            input_b => b_input_dataword(i),
            carry_in => carry(i),
            output_sum => sum_output_dataword(i),
            carry_out => carry(i+1)
        );
    end generate generate_adders;
    output_carry <= carry(count);
end architecture RTL;

