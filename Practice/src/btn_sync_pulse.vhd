library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity btn_sync_pulse is 
port (
    clk         : in  std_logic;
    rst         : in  std_logic;  -- synchronous, active-high
    i_btn_async : in  std_logic;  -- asynchronous push-button input
    o_pulse     : out std_logic   -- 1-cycle pulse per rising edge (sync to clk)
  );
end entity btn_sync_pulse;

architecture RTL of btn_sync_pulse is 
  
begin 
  proc : process(clk,i_btn_async) 
    begin 
      if(i_btn_async = '1') then 
        o_pulse <= '0';
      else (rising_edge(clk))
        if(rst = '1') then 
          o_pulse <= '0';
        else 
          o_pulse <= clk;
        end if;
      end if;
    end process;
end architecture RTL;