

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UART_RX_top_tb is
--  Port ( );
end UART_RX_top_tb;

architecture Behavioral of UART_RX_top_tb is
    signal clock                  : std_logic := '0';
    signal uart_txd_in            : std_logic := '1';
--    signal received_byte          : std_logic_vector (7 downto 0) := (others => '0');
--    constant clock_cycles_per_bit : integer := 10416;
--    signal data_valid             : std_logic := '0';
    signal LED_ff   : std_logic_vector (2 downto 0);
    
    ----- UART data signal
    constant baud_frequency : integer   := 960; -- 96000Hz between bits, 10 total = start_bit + data_byte+ stop_bit
    constant baud_period    : time      := 1000 ms / baud_frequency;
    signal baud_rate        : std_logic := '0';
    constant bit_period     : time      := 104 us;
    
    procedure UART_WRITE_BYTE (
               data_sample  : in  std_logic_vector(7 downto 0);
        signal data_in      : out std_logic) is
    begin
 
    -- Send Start Bit
    data_in <= '0';
    wait for bit_period;
 
    -- Send Data Byte (data_sample)
    for i in 0 to 7 loop
      data_in <= data_sample(i);
      wait for bit_period;
    end loop; 
 
    -- Send Stop Bit
    data_in <= '1';
    wait for bit_period;
    end UART_WRITE_BYTE;
    
    
                   
begin

    baud_rate <= not baud_rate after baud_period / 2; -- this baud rate is probably wrong and causing simulation issues. 
    
    inst_Test : entity work.Test(rtl)
    --generic map(clock_cycles_per_bit => clock_cycles_per_bit)
    port map(
        clock         => clock,        
        uart_txd_in   => uart_txd_in,  
        LED_ff    => LED_ff);
        
    process is begin    
        wait for 5 ns;    
        clock <= not clock;
    end process;
    
    process is 
    begin
        wait until rising_edge(baud_rate); -- possibly an incorrect line, the reading should be done when this finishes but it's not, correct this
                UART_WRITE_BYTE(x"ff",uart_txd_in);
               
        --        wait for 1000000 ns;
        --        wait;
        wait until rising_edge(baud_rate);
            UART_WRITE_BYTE(x"dd",uart_txd_in);
        wait until rising_edge(baud_rate);
            UART_WRITE_BYTE(x"62",uart_txd_in);
    
    
    end process;




end architecture;
