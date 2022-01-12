`timescale 1ns / 1ps

module UART_RX_top(

input clock,
input uart_txd_in,
output [2:0] LED_ff 
);

//assign active_LED = LED;
wire data_valid;
wire [7:0] received_byte;

byte_to_LED byte_to_LED_inst(
.clock        (clock        ),
.received_byte(received_byte),
.data_valid   (data_valid   ),
.LED_ff       (LED_ff       )
);

UART_RX UART_RX_inst(
.clock        (clock        ),
.uart_txd_in  (uart_txd_in  ),
.received_byte(received_byte),
.data_valid   (data_valid   )
);



endmodule
