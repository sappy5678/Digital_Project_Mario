module Score_Display(score, display_ten, display_digit);

input[6:0] score;
output reg[6:0] display_ten, display_digit;

wire[3:0] ten, digit;

assign ten = score / 10,
	   digit = score % 10;

always@(ten) begin
	if(ten == 4'b0000) begin
		display_ten <= 7'b1000000;
	end
	
	else if(ten == 4'b0001) begin
		display_ten <= 7'b1111001;
	end
	
	else if(ten == 4'b0010) begin
		display_ten <= 7'b0100100;
	end
	
	else if(ten == 4'b0011) begin
		display_ten <= 7'b0110000;
	end
	
	else if(ten == 4'b0100) begin
		display_ten <= 7'b0011001;
	end
	
	else if(ten == 4'b0101) begin
		display_ten <= 7'b0010010;
	end
	
	else if(ten == 4'b0110) begin
		display_ten <= 7'b0000010;
	end
	
	else if(ten == 4'b0111) begin
		display_ten <= 7'b1011000;
	end
	
	else if(ten == 4'b1000) begin
		display_ten <= 7'b0000000;
	end
	
	else begin
		display_ten <= 7'b0010000;
	end
end

always@(digit) begin
	if(digit == 4'b0000) begin
		display_digit <= 7'b1000000;
	end
	
	else if(digit == 4'b0001) begin
		display_digit <= 7'b1111001;
	end
	
	else if(digit == 4'b0010) begin
		display_digit <= 7'b0100100;
	end
	
	else if(digit == 4'b0011) begin
		display_digit <= 7'b0110000;
	end
	
	else if(digit == 4'b0100) begin
		display_digit <= 7'b0011001;
	end
	
	else if(digit == 4'b0101) begin
		display_digit <= 7'b0010010;
	end
	
	else if(digit == 4'b0110) begin
		display_digit <= 7'b0000010;
	end
	
	else if(digit == 4'b0111) begin
		display_digit <= 7'b1011000;
	end
	
	else if(digit == 4'b1000) begin
		display_digit <= 7'b0000000;
	end
	
	else begin
		display_digit <= 7'b0010000;
	end
end

endmodule
