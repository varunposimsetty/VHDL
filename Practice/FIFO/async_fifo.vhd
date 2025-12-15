library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity async_fifo is 
    generic(
        DATA_WIDTH : integer := 8,
        FIFO_DEPTH : integer := 16
    );
    port(
        -- WRITE 
        i_wr_clk    : in std_ulogic;
        i_wr_nrst   : in std_ulogic;
        i_wr_en     : in std_ulogic;
        i_wr_data   : in std_ulogic_vector(DATA_WIDTH-1 downto 0);
        o_full      : out std_ulogic;
        -- READ 
        i_rd_clk    : in std_ulogic;
        i_rd_nrst   : in std_ulogic;
        i_rd_en     : in std_ulogic;
        o_rd_data   : out std_ulogic_vector(DATA_WIDTH-1 downto 0);
        o_empty     : out std_ulogic
    );
end entity async_fifo;

architecture RTL of async_fifo is 
    function log2(x:real) return real is 
    begin 
        return log(x)/log(2.0);
    end function;

    function bin2gray(bin : unsigned) return unsigned is 
        variable gray : unsigned(bin'range);
        begin   
            gray := bin xor ('0' & bin(bin'high downto bin'low+1));
        return gray;
    end function;

    constant ADDR_WIDTH : integer := integer(ceil(log2(real(FIFO_DEPTH))));
    type t_ram is array(0 to FIFO_DEPTH-1) of std_ulogic_vector(DATA_WIDTH-1 downto 0);
    signal mem_ram : t_ram := (others => (others => '0'));
    signal wr_ptr : unsigned(ADDR_WIDTH-1 downto 0) := (others => '0');
    signal rd_ptr : unsigned(ADDR_WIDTH-1 downto 0) := (others => '0');
    signal wr_ptr_gray : unsigned(ADDR_WIDTH-1 downto 0) := (others => '0');
    signal rd_ptr_gray : unsigned(ADDR_WIDTH-1 downto 0) := (others => '0');
    signal wr_ptr_sync_meta : unsigned(ADDR_WIDTH-1 downto 0) := (others => '0');
    signal rd_ptr_sync_meta : unsigned(ADDR_WIDTH-1 downto 0) := (others => '0');
    signal wr_ptr_sync_to_rd : unsigned(ADDR_WIDTH-1 downto 0) := (others => '0');
    signal rd_ptr_sync_to_wr : unsigned(ADDR_WIDTH-1 downto 0) := (others => '0');


begin 
    -- Write Process
    proc_write : process(i_wr_clk,i_wr_nrst) is 
        begin 
            if(i_wr_nrst = '0') then 
                wr_ptr <= (others => '0');
            elsif(rising_edge(i_wr_clk)) then 
                rd_ptr_sync_meta <= rd_ptr_gray;
                rd_ptr_sync_to_wr <= rd_ptr_sync_meta;
                if(i_wr_en = '1' and o_full = '0') then 
                    mem_ram(to_integer(wr_ptr)) <= i_wr_data;
                    wr_ptr <= wr_ptr + 1;
                    wr_ptr_gray <= bin2gray(wr_ptr);
                end if;
            end if;
    end process proc_write;

    -- Read Process 
    proc_read : process(i_rd_clk,i_rd_nrst) is 
        begin 
        if(i_rd_nrst = '0') then 
            rd_ptr <= (others => '0');
        elsif(rising_edge(i_rd_clk)) then 
            wr_ptr_sync_meta <= wr_ptr_gray;
            wr_ptr_sync_to_rd <= wr_ptr_sync_meta;
            o_rd_data <= mem_ram(to_integer(rd_ptr));
            if (i_rd_en = '1' and o_empty = '0') then 
                rd_ptr <= rd_ptr + 1;
                rd_ptr_gray <= bin2gray(rd_ptr);
            end if;
        end if;
    end process;

    o_full <= '1' when (bin2gray(wr_ptr + 1) = rd_ptr_sync_to_wr) else '0';
    o_empty <= '1' when (bin2gray(rd_ptr) = wr_ptr_sync_to_rd);
end architecture RTL;