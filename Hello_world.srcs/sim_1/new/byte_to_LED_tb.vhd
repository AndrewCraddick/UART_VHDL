

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity byte_to_LED_tb is
--  Port ( );
end entity;

architecture Behavioral of byte_to_LED_tb is

    signal clock         : std_logic := '0';
    signal received_byte : std_logic_vector (7 downto 0);
    signal data_valid    : std_logic := '0';
    signal LED_ff    : std_logic_vector (2 downto 0);


           
begin

inst_Test : entity work.byte_to_LED(rtl)
port map(
        clock         => clock,                               
        received_byte => received_byte, 
        data_valid    => data_valid,    
        LED_ff    => LED_ff);   

process is
begin
wait for 10 ns;
    received_byte <= x"61";
    
wait for 10 ns;
    data_valid <= '1';
    
wait for 10 ns;
    data_valid <= '0';
    
wait for 10 ns;
    received_byte <= x"50";
    
wait for 10 ns;
    data_valid <= '1';

wait for 10 ns;
    data_valid <= '0';
    
wait for 10 ns;
    received_byte <= x"62";
wait for 10 ns;
    data_valid <= '1';
wait for 10 ns;
    data_valid <= '0';    
wait;


end process;

process is 
begin
    wait for 5 ns;
    clock <= not clock;
end process;

end architecture;
