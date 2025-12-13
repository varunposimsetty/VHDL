library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity prority_encoder is 
    generic (
        LEN : integer := 2
    );
    port (
        i_in  : in std_ulogic_vector(2**LEN-1 downto 0);
        o_out : out std_ulogic_vector(LEN-1 downto 0);
        o_valid : out std_ulogic
    );
end entity prority_encoder;

architecture RTL of prority_encoder is
    function check(a: std_ulogic_vector) return integer
        variable position : integer := 0;
    begin 
        for i in a'high downto a'low loop
            if(a(i) = '1') then 
                position := i;
                exit;
            end if; 
        end loop;
        return position;
    end function;
    signal all_zero : std_ulogic_vector(2**LEN-1 downto 0) := (others => '0');
begin
    o_out <= std_ulogic_vector(to_unsigned(check(i_in),LEN));
    o_valid <= '0' when i_in = all_zero else '1';
end architecture RTL;