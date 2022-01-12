library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Test is
    
    Port (clock         : in std_logic;
          uart_txd_in   : in std_logic;
          uart_rxd_out  : out std_logic;
          LED_ff        : out std_logic_vector (2 downto 0));
end entity;


architecture rtl of Test is

     
     
--    constant clock_cycles_per_bit : integer := 10416;
    signal   received_byte : std_logic_vector (7 downto 0);
    signal   data_valid    : std_logic;
 
     
     
begin
        
inst_UART_RX : entity work.UART_RX(rtl)
--generic map(clock_cycles_per_bit => clock_cycles_per_bit)
port map(
        clock         => clock,        
        uart_txd_in   => uart_txd_in,  
        received_byte => received_byte,
        data_valid    => data_valid);
        
inst_byte_to_LED : entity work.byte_to_LED(rtl)
port map(
        clock         => clock,                               
        received_byte => received_byte, 
        data_valid    => data_valid,    
        LED_ff        => LED_ff);
        
        inst_UART_TX : entity work.UART_TX(rtl)
--generic map(clock_cycles_per_bit => clock_cycles_per_bit)
port map(clock         => clock,        
         data_valid    => data_valid,  
         received_byte => received_byte,
         uart_rxd_out  => uart_rxd_out);
       

end architecture;