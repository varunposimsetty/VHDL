library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity bin2thermometer is 
    port(
        d_in  : in std_ulogic_vector(7 downto 0);
        d_out : out std_ulogic_vector(255 downto 0)
    );
end entity bin2thermometer;

architecture RTL of bin2thermometer is 
    function change(a:std_ulogic_vector) return std_ulogic_vector return 
        variable thermometer_value : std_ulogic_vector(255 downto 0) := (others => '1');
        variable position : integer;
    begin 
        position := to_integer(unsigned(a));
        thermometer_value(255 downto position) := (others => '0');
        thermometer_value(position downto 0) := (others => '1');
        return thermometer_value;
    end function change;
begin 
    d_out <= change(d_in);

end architecture RTL;
