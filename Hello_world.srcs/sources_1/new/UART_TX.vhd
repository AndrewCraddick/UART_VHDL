

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UART_TX is
  Port (clock         : in std_logic;
        data_valid    : in std_logic;
        received_byte : in std_logic_vector (7 downto 0);
        uart_rxd_out  : out std_logic:='1');
end entity;

architecture rtl of UART_TX is
    


    signal data_ready    : std_logic := '0';
    signal transmit_byte : std_logic_vector (9 downto 0); -- frame is 10 bits with data byte between start and stop bit 
    signal counter       : integer := 0;
    signal byte_index    : integer range 0 to 11 := 0;
    constant clock_cycles_per_bit : integer := 10416;

begin

    transmit_byte(8 downto 1) <= received_byte;
    transmit_byte(0) <= '0';
    transmit_byte(9) <= '1';

    
process(clock) is

begin

    if rising_edge(clock) then
    
        if (data_valid = '1') then
            data_ready <= '1';
        elsif (byte_index = 10) then
            data_ready <= '0';
        end if;
           

        if(data_ready = '1') then
            
            
            if(byte_index < 10) then
                uart_rxd_out <= transmit_byte(byte_index);
                
                if(counter > clock_cycles_per_bit - 1) then
                    counter <= 0;
                    byte_index <= byte_index + 1;
                else
                    counter <= counter + 1;
                end if;
                
            else
                byte_index <= 0;
                counter <= 0;
            end if;
            
        else 
            uart_rxd_out <= '1';
            byte_index <= 0;
            counter <= 0;
        end if;
                
    end if;    
    
end process;
    
end architecture;




