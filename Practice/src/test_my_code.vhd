-- The following module you see before you receives a clock and
-- has a synchronous reset. The reset is active high.
--
-- Extend the module you have been given to drive the output signals
-- as described in the challenge description. You may add or remove
-- code but please do NOT modify the module ports. The testbench
-- provided will tell you when you have correctly done this.
--
-- We are looking for the test to pass first and foremost.
--
-- You have the ability to view or download the waveform produced
-- by the design. You can also synthesize the design. Be aware
-- this can take a few minutes to run.


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    port (
        clk             : in std_logic;
        reset           : in std_logic;

        in_valid        : in std_logic;
        in_data         : in std_logic_vector(31 downto 0);
        in_busy         : in std_logic;

        out_valid       : out std_logic;
        out_payload     : out std_logic_vector(1199 downto 0);
        out_position    : out std_logic_vector(7 downto 0);
        out_last        : out std_logic;
        out_ready       : out std_logic
    );
end;

architecture behavioral of top is
    type tx_state is (IDLE,RECEIVE,COPY);
    signal current_state : tx_state := IDLE;
    signal copy_count,transmit_count : unsigned(7 downto 0) := (others => '0');
    signal receive_count : unsigned(15 downto 0) := (others => '0');
    signal data_buffer : std_logic_vector(1199 downto 0) := (others => '0');
    signal num_payload_words : unsigned(15 downto 0) := (others => '0');
    signal pay_load_length : unsigned(15 downto 0) := (others => '0');
begin
    proc : process(clk) begin 
        if(rising_edge(clk)) then 
            if(reset = '1') then
                current_state <= IDLE;
                copy_count <= (others => '0');
                transmit_count <= (others => '0');
                receive_count <= (others => '0');
                data_buffer <= (others => '0');
                pay_load_length <= (others => '0');
                out_ready <= '1';
                out_valid <= '0';
                out_last <= '0';  
                out_position <= (others => '0');
                out_payload <= (others => '0');

            else 
                if (current_state = RECEIVE and in_valid = '1') then
                    if ((receive_count + 1) = num_payload_words) then
                        end_rx_flag <= '1';
                    else
                        end_rx_flag <= '0';
                    end if;
                elsif current_state = IDLE then
                    end_rx_flag <= '0';
                end if;
                case current_state is 
                    when IDLE =>   
                        out_ready <= '1';
                        out_valid <= '0';
                        out_last <= '0';
                        if(in_valid = '1') then
                            copy_count <= unsigned(in_data(7 downto 0));
                            pay_load_length <= unsigned(in_data(23 downto 8));
                            if (unsigned(in_data(23 downto 8)) = 0) then 
                                receive_count <= (others => '0');
                                current_state <= IDLE;
                            else 
                                receive_count <= to_unsigned(1,16);
                                data_buffer(7 downto 0) <= in_data(31 downto 24);
                                current_state <= RECEIVE;
                          end if;
                        end if;
                    when RECEIVE => 
                          out_ready <= '1';
                          out_valid <= '0';
                           if(in_valid = '1') then
                               data_buffer(to_integer(receive_count)*32 + 31 downto to_integer(receive_count)*32) <= in_data;
                               receive_count <= receive_count + 1;
                           end if;
                           if (end_rx_flag = '1') then
                            if (copy_count = 0) then
                                current_state <= IDLE;
                            else
                                transmit_count <= (others => '0');
                                current_state <= COPY;
                            end if;
                        end if;
                        end if;
                   when COPY => 
                           out_ready <= '0';
                           out_payload <= data_buffer;
                           out_position <= std_logic_vector(transmit_count);
                           out_valid <= '1';
                           if(transmit_count = copy_count - 1) then 
                               out_last <= '1';
                           else 
                               out_last <= '0';
                           end if;
                           if(in_busy = '0') then 
                               if(transmit_count = copy_count -1) then 
                                   transmit_count <= (others => '0');
                                   current_state <= IDLE;
                               else 
                                   transmit_count <= transmit_count + 1;
                              end if;
                          end if;
                  when others => 
                              current_state <= IDLE;
                  end case;    
            end if;
        end if;
     end process proc;

end architecture behavioral;
