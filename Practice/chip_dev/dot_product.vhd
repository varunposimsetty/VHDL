library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity dot_product is 
    port(
        i_clk  : in std_ulogic;
        i_nrst : in std_ulogic;
        i_din  : in std_ulogic_vector(7 downto 0);
        o_dout : out std_ulogic_vector(17 downto 0);
        o_run  : out std_ulogic
    );
end entity dot_product;

architecture RTL of dot_product is 
    type t_vector_array is array(0 to 5) of std_ulogic_vector(7 downto 0);
    signal vector : t_vector_array := (others => (others => '0'));
    
    function dot(a:t_vector_array) return std_ulogic_vector is 
        variable product : unsigned(17 downto 0) := (others => '0');
        begin 
            product := (others => '0');
            for i in 0 to 2 loop
                product := product + resize(unsigned(a(i)),18)*resize(unsigned(a(i+3)),18);
            end loop;
        return std_ulogic_vector(product);
    end function;


begin 
    process(i_clk) is 
        variable count : integer range 0 to 5 := 0;
        begin 
            if(rising_edge(i_clk)) then 
                if(i_nrst = '0') then 
                    vector <= (others => (others => '0'));
                    count := 0;
                else 
                    if(count = 5) then 
                        vector(count) <= i_din;
                        o_dout <= dot(vector);
                        o_run <= '1';
                        count := 0;
                    else 
                        vector(count) <= i_din;
                        o_run <= '0';
                        count := count + 1;
                    end if;
                end if;
            end if;
    end process;
end architecture RTL;