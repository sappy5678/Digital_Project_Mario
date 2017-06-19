module VGA_REAL_GAME_CLK(	
	inclk0,
	outclk);

	input inclk0;
	output reg[20:0] outclk;
		
	always@(posedge inclk0) begin
		outclk <= outclk + 1'b1;
	end
	
endmodule
