

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;


--library UNISIM;
--use UNISIM.VComponents.all;

entity byte_to_LED is
  Port (clock         : in std_logic;
        received_byte : in std_logic_vector (7 downto 0);
        data_valid    : in std_logic;
        LED_ff        : out std_logic_vector (2 downto 0));
end entity;


architecture rtl of byte_to_LED is

    signal active_LED : std_logic_vector (2 downto 0) := (others => '0');
begin


process (data_valid, received_byte) is
begin
    if data_valid = '1' then
        case received_byte is
            when x"61" =>
                active_LED <= "001"; 
            when x"62" =>
                active_LED <= "010";
            when x"63" =>
                active_LED <= "100";
            when others =>
                active_LED <= (others => '0');
        end case;
     else
        active_LED <= (others => '0');
    end if;
       
end process;

process(clock) is
begin
    if rising_edge(clock) then
        if data_valid = '1' then
            LED_ff <= active_LED;
--      else
--          LED_ff <= "000";
        end if;
    end if;
end process;



end architecture;
