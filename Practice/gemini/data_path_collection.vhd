library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity packet_detector is 
    generic (
        DEPTH : integer := 3;
        DATA_WIDTH : integer := 8
    );
    port (
        i_clk          : in std_ulogic;
        i_nrst         : in std_ulogic;
        i_valid        : in std_ulogic;
        i_data         : in std_ulogic_vector(DATA_WIDTH-1 downto 0);
        o_header_found : out std_ulogic
    );
end entity packet_detector;

architecture RTL of packet_detector is 
    type t_mem is array(0 to DEPTH-1) of std_ulogic_vector(DATA_WIDTH-1 downto 0);
    signal packet_mem : t_mem := (others => (others => '0'));
begin 
    proc_header : process(i_clk) then 
    begin 
        if(rising_edge(i_clk)) then 
            if(i_nrst = '0') then 
                o_header_found <= '0';
                packet_mem <= (others => (others => '0'));
            else 
                if(i_valid = '1') then 
                    for i in 0 to DEPTH-1 loop 
                        if(i = DEPTH-1) then 
                            packet_mem(i) <= i_data;
                        else 
                            packet_mem(i) <= packet_mem(i+1);
                        end if;
                    end loop;
                    if(packet_mem(0) = x"AA" and packet_mem(1) = x"55" and packet_mem(2) = x"CC") then 
                        o_header_found <= '1';
                    else 
                        o_header_found <= '0';
                    end if;
                else 
                    packet_mem <= (others => (others => '0'));
                    o_header_found <= '0';
                end if;
            end if;
        end if;
    end process  proc_header;
end architecture RTL;