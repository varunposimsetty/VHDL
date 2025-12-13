library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity simple_router is 
    generic(
        DATA_WIDTH : integer := 32
    );
    port (
        data_in : in std_ulogic_vector(DATA_WIDTH-1 downto 0);
        data_en : in std_ulogic;
        i_addr  : in std_ulogic_vector(1 downto 0);
        dout_0  : out std_ulogic_vector(DATA_WIDTH-1 downto 0);
        dout_1  : out std_ulogic_vector(DATA_WIDTH-1 downto 0);
        dout_2  : out std_ulogic_vector(DATA_WIDTH-1 downto 0);
        dout_3  : out std_ulogic_vector(DATA_WIDTH-1 downto 0)

    );
end entity simple_router;

architecture RTL of simple_router is 
begin 
    dout_0 <= i_data when (data_en = '1' and i_addr = "00") else (others => '0');
    dout_1 <= i_data when (data_en = '1' and i_addr = "01") else (others => '0');
    dout_2 <= i_data when (data_en = '1' and i_addr = "10") else (others => '0');
    dout_3 <= i_data when (data_en = '1' and i_addr = "11") else (others => '0');
end architecture RTL;

