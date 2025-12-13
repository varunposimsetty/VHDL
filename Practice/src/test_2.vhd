library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_reg is
  port (
    clk     : in  std_logic;
    data_in : in  std_logic_vector(7 downto 0);
    data4   : out std_logic_vector(7 downto 0)  -- expose data(4) for observation
  );
end entity shift_reg;

architecture rtl of shift_reg is
  -- array of 16 bytes: data(0) .. data(15)
  type data_array_t is array (0 to 15) of std_logic_vector(7 downto 0);
  signal data : data_array_t := (others => (others => '0'));
begin

  process(clk)
  begin
    if rising_edge(clk) then
      -- equivalent to: data[0] <= dataIn;
      data(0) <= data_in;

      -- for (int j = 1; j < 16; j++) data[j] <= data[j-1];
      for j in 1 to 15 loop
        data(j) <= data(j-1);
      end loop;
    end if;
  end process;

  -- expose data(4)
  data4 <= data(4);

end architecture rtl;
