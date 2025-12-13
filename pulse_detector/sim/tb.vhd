library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_pulse_detector is end;
architecture sim of tb_pulse_detector is
  constant CLK_T : time := 10 ns;

  signal clk, rst, in_sig : std_ulogic := '0';
  signal pulse_cnt        : std_ulogic_vector(3 downto 0);

  -- helper
  procedure tick(n : natural := 1) is
  begin
    for i in 1 to n loop
      wait for CLK_T/2; clk <= not clk;
      wait for CLK_T/2; clk <= not clk;
    end loop;
  end procedure;

begin
  -- DUT
  dut: entity work.pulse_detector
    generic map(count_width => 4)
    port map(
      clk => clk, rst => rst, in_sig => in_sig, pulse_cnt => pulse_cnt
    );

  -- Stimulus
  process
    variable cnt_u : unsigned(3 downto 0);
  begin
    -- reset
    rst <= '1'; tick(2);
    rst <= '0'; tick(1);

    -- 16 rising edges to force wrap
    for k in 0 to 15 loop
      -- create a rising edge on in_sig aligned to clk
      in_sig <= '0'; tick(1);
      in_sig <= '1'; tick(1);   -- rising edge here
      in_sig <= '1'; tick(1);
      in_sig <= '0'; tick(1);
    end loop;

    -- check wrapped to 0
    cnt_u := unsigned(pulse_cnt);
    assert cnt_u = 0
      report "Counter did not wrap to 0 after 16 edges!"
      severity failure;

    report "TB PASS" severity note;
    wait;
  end process;

end architecture;
