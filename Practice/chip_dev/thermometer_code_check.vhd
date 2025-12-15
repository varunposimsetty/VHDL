library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity is_thermoeter_code is 
    generic(
        DATA_WIDTH : integer := 8
    );
    port(
        codeIn : in std_ulogic_vector(DATA_WIDTH-1 downto 0);
        isThermometer : out std_ulogic
    );
end entity is_thermoeter_code;

architecture RTL of is_thermometer_code is 
    function check(a:std_ulogic_vector) return std_ulogic is    
        variable isit : std_ulogic := '0';
        variable compare : std_ulogic_vector(DATA_WIDTH-1 downto 0) := (others => '1');
        begin 
            compare := (others => '1');
            for i in a'high to a'low loop 
                if(a(i) = '1') then 
                    isit := '1' when a(i downto a'low) = compare(i downto 0) else '0';
                    exit;
                else 
                    isit := '0';
                end if; 
            end loop;
        return isit;
    end function;
begin 
    isThermometer <= check(codeIn);
end architecture RTL;