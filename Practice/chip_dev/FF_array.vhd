library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FF_Array is 
    port(
        d_in    : in std_ulogic_vector(7 downto 0);
        addr    : in std_ulogic_vector(2 downto 0);
        wr      : in std_ulogic;
        rd      : in std_ulogic;
        clk     : in std_ulogic;
        reset_n : in std_ulogic;
        d_out   : out std_ulogic_vector(7 downto 0);
        err     : out std_ulogic
    );
end entity FF_Array;

architecture RTL of FF_Array is 
    function check_addr(a:std_ulogic_vector) return std_ulogic is 
        variable 
        begin 


    end function;

    type mem_array is array(0 to 7) of std_ulogic_vector(7 downto 0);
    signal memory : mem_array := (others => (others => '0'));

begin 
    process(clk) is 
    begin 
        if(rising_edge(clk)) then 
            if(reset_n = '0') then 
                memory <= (others => (others => '0'));
                d_out <= '0';
                err <= '0';
            else 




end architecture RTL;