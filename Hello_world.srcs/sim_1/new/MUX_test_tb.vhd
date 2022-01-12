

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity MUX_test_tb is
end MUX_test_tb;




architecture Behavioral of MUX_test_tb is

signal Sel       : unsigned (3 downto 0) := "0001";
signal Output    : unsigned (3 downto 0);

begin

inst_MUX : entity work.MUX_test(rtl) port map(
                Sel      => Sel,
                Output   => Output);  


process is
begin

        wait for 10 ns;
        Sel <= shift_left(Sel,1);

     
     wait for 40 ns;
     Sel <= "1111";
end process;




end Behavioral;
