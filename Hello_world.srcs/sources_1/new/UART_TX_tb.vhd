

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UART_TX_tb is
--  Port ( );
end UART_TX_tb;

architecture Behavioral of UART_TX_tb is
    signal clock                  : std_logic := '0';
    signal uart_rxd_out           : std_logic;
    signal received_byte          : std_logic_vector (7 downto 0) := (others => '0');
    constant clock_cycles_per_bit : integer := 10416;
    signal data_ready             : std_logic := '0';
    signal data_valid             : std_logic:='0';
    
    ----- UART data signal
    constant baud_frequency : integer   := 960; -- 96000Hz between bits, 10 total = start_bit + data_byte+ stop_bit
    constant baud_period    : time      := 1000 ms / baud_frequency;
    signal baud_rate        : std_logic := '0';
    constant bit_period     : time      := 104 us;
                   
begin


inst_UART_TX : entity work.UART_TX(rtl)
--generic map(clock_cycles_per_bit => clock_cycles_per_bit)
port map(clock         => clock,        
         data_valid    => data_valid,  
         received_byte => received_byte,
         uart_rxd_out  => uart_rxd_out);
    
  
baud_rate <= not baud_rate after baud_period / 2; 
    
process is begin    
    wait for 5 ns;    
    clock <= not clock;
end process;

process is 
begin
wait until rising_edge(baud_rate);
        data_valid <= '1';
        received_byte <= "00001001"; -- example data byte
wait until rising_edge(baud_rate);

        data_valid <= '0';
        wait for 1000000 ns;
        
wait until rising_edge(baud_rate);
        data_valid <= '1';
        received_byte <= "10101010";
wait until rising_edge(baud_rate);
        data_valid <= '0';
        wait for 2500 us;

end process;




end architecture;
