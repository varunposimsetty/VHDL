library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_pulse_detector is
end entity;

architecture sim of tb_pulse_detector is
  constant CLK_T : time := 10 ns;

  signal clk       : std_logic := '0';
  signal rst       : std_logic := '0';
  signal in_sig    : std_logic := '0';
  signal pulse_cnt : std_logic_vector(3 downto 0);
begin
  ---------------------------------------------------------------------------
  -- Clock generation
  ---------------------------------------------------------------------------
  clk <= not clk after CLK_T / 2;

  ---------------------------------------------------------------------------
  -- DUT instantiation
  ---------------------------------------------------------------------------
  dut: entity work.pulse_detector
    generic map (
      COUNT_WIDTH => 4
    )
    port map (
      clk       => clk,
      rst       => rst,
      in_sig    => in_sig,
      pulse_cnt => pulse_cnt
    );

  ---------------------------------------------------------------------------
  -- Stimulus process
  ---------------------------------------------------------------------------
  stim: process
  begin
    -- Apply reset
    rst <= '1';
    wait for 3 * CLK_T;
    rst <= '0';
    wait for 1 * CLK_T;

    -- Generate 18 rising edges on in_sig
    for i in 0 to 17 loop
      in_sig <= '0';
      wait for CLK_T;

      in_sig <= '1';   -- rising edge
      wait for CLK_T;

      in_sig <= '1';   -- hold high
      wait for CLK_T;

      in_sig <= '0';   -- back low
      wait for CLK_T;
    end loop;

    -- wait a few extra cycles
    wait for 4 * CLK_T;

    -- Now check result: 18 mod 16 = 2
    assert unsigned(pulse_cnt) = to_unsigned(2, 4)
      report "ERROR: pulse_cnt /= 2 after 18 rising edges"
      severity failure;

    report "TB PASS: pulse_cnt = 2 (18 mod 16) as expected" severity note;
    wait;
  end process;

end architecture;
