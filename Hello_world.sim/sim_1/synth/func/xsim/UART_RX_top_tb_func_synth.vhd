-- Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2021.2 (win64) Build 3367213 Tue Oct 19 02:48:09 MDT 2021
-- Date        : Wed Dec  1 13:58:57 2021
-- Host        : SRS1693 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -mode funcsim -nolib -force -file
--               C:/Users/acraddick/Hello_world/Hello_world.sim/sim_1/synth/func/xsim/UART_RX_top_tb_func_synth.vhd
-- Design      : Test
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7s25csga324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Test is
  port (
    clock : in STD_LOGIC;
    uart_txd_in : in STD_LOGIC;
    LED_ff : out STD_LOGIC_VECTOR ( 2 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of Test : entity is true;
end Test;

architecture STRUCTURE of Test is
begin
\LED_ff_OBUF[0]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => LED_ff(0)
    );
\LED_ff_OBUF[1]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => LED_ff(1)
    );
\LED_ff_OBUF[2]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => LED_ff(2)
    );
end STRUCTURE;
