


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;



entity UART_RX is
--  generic(clock_cycles_per_bit : integer); -- clock speed / baud rate - 1, 10416 for 100Mhz/9600
  Port   (clock                : in std_logic;
          uart_txd_in          : in std_logic:='1';
          received_byte        : out std_logic_vector (7 downto 0) := (others => '0');
          data_valid           : out std_logic); -- output signal indicating status of UART line
end entity;



architecture rtl of UART_RX is

    constant clock_cycles_per_bit : integer := 10416;
    type state_type is (idle, verify_start_bit, reading_data, stop_bit);
    signal state : state_type := idle;
    signal UART_line : std_logic;
    signal data_bit : std_logic;
    signal counter : integer := 0;
    signal byte_index : integer range 0 to 8 := 0; -- find out what range means
    signal data_byte : std_logic_vector (7 downto 0) := (others => '0');
    signal data_status : std_logic := '0';

begin
    process(clock) is
    begin
        if rising_edge(clock) then
            UART_line <= uart_txd_in;
            data_bit <= UART_line;
        end if;
    end process;
        
    process(clock) is
    begin
        if rising_edge(clock) then        
            case state is
---------------------------------------------------------------------                
                when idle =>
                    data_status <= '0';         -- he cleared the counter and byte index here
                    byte_index <= 0;
                    counter <= 0;
                    if data_bit = '0' then
                        state <= verify_start_bit;
                    else
                        state <= idle;
                    end if;
----------------------------------------------------------------------                
                when verify_start_bit =>
                    if counter > clock_cycles_per_bit / 2 - 1 then
                        counter <= 0;               -- deviation right here
                        if data_bit = '0' then
                            state <= reading_data;  -- he cleared the counter here
                        else
                            state <= idle;
                        end if;
                    else
                        counter <= counter + 1;
                        state <= verify_start_bit;
                    end if;
----------------------------------------------------------------------                
                when reading_data =>
                    if byte_index < 8 then -- you may need to switch order of this
                        if counter > clock_cycles_per_bit - 1 then
                            data_byte(byte_index) <= data_bit;
                            state <= reading_data;
                            byte_index <= byte_index + 1;
                            counter <= 0;
                        else
                            counter <= counter + 1;
                            state <= reading_data;
                        end if;
                     else
                        state <= stop_bit;
                        byte_index <= 0;
                        counter <= 0;
                     end if;
                        
----------------------------------------------------------------------                                        
                when stop_bit =>
                    if counter > clock_cycles_per_bit - 1 then
                        state <= idle;
                        counter <= 0;
                        data_status <= '1';
                    else
                        counter <= counter + 1;
                        state <= stop_bit;
                    end if;
                when others =>
                    state <= idle;
            end case;
                
        end if;
    end process;
    
    received_byte <= data_byte;
    data_valid <= data_status;
end architecture;


