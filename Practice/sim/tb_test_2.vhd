library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_shift_reg is
end entity tb_shift_reg;

architecture sim of tb_shift_reg is
  constant CLK_T : time := 10 ns;

  signal clk     : std_logic := '0';
  signal data_in : std_logic_vector(7 downto 0) := (others => '0');
  signal data4   : std_logic_vector(7 downto 0);

  -- internal observation of all 16 values (through VHDL access)
  signal data_debug : std_logic_vector(7 downto 0) := (others => '0');

  -- helper functions to print bytes in hex
  function to_hexchar(nibble : std_logic_vector(3 downto 0)) return character is
    variable val : integer := to_integer(unsigned(nibble));
  begin
    if val < 10 then
      return character'val(character'pos('0') + val);
    else
      return character'val(character'pos('A') + (val - 10));
    end if;
  end function;

  function to_hexbyte(vec : std_logic_vector(7 downto 0)) return string is
    variable s : string(1 to 2);
  begin
    s(1) := to_hexchar(vec(7 downto 4));
    s(2) := to_hexchar(vec(3 downto 0));
    return s;
  end function;

begin

  --------------------------------------------------------------------
  -- Clock generation
  --------------------------------------------------------------------
  clk <= not clk after CLK_T/2;

  --------------------------------------------------------------------
  -- DUT
  --------------------------------------------------------------------
  dut: entity work.shift_reg
    port map (
      clk     => clk,
      data_in => data_in,
      data4   => data4
    );

  --------------------------------------------------------------------
  -- Stimulus + live printing
  --------------------------------------------------------------------
  stim: process
    variable cycle : integer := 0;
  begin
    -- Input sequence for the first 4 cycles
    for i in 1 to 8 loop
      case i is
        when 1 => data_in <= x"AA";
        when 2 => data_in <= x"55";
        when 3 => data_in <= x"FF";
        when 4 => data_in <= x"01";
        when others => null;
      end case;

      wait until rising_edge(clk);
      cycle := cycle + 1;
      report "Cycle " & integer'image(cycle) &
             ": data_in=0x" & to_hexbyte(data_in) &
             " data4=0x" & to_hexbyte(data4);
    end loop;

    wait for CLK_T;
    report "Simulation complete after 8 cycles. Final data4 = 0x" &
           to_hexbyte(data4)
      severity note;
    wait;
  end process;
end architecture sim;
