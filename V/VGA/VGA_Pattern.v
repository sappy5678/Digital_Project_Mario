module	VGA_Pattern	(	//	Read Out Side
						oRed,
						oGreen,
						oBlue,
						iVGA_X,
						iVGA_Y,
						iVGA_CLK,
						action_clk,
						//	Control Signals
						move_right,
						move_jump,
						move_left,
						blk_cordinate,
						blk_length,
						bio_cordinate,
						bio_length,
						blk_id_all,
						bio_id_all,
						char_data,
						iColor_SW	);
//	Read Out Side
output	reg	[9:0]	oRed;
output	reg	[9:0]	oGreen;
output	reg	[9:0]	oBlue;
input	[639:0]		blk_cordinate;
input	[639:0]		blk_length;
input	[319:0]		bio_cordinate;
input	[319:0]		bio_length;
input	[199:0]		blk_id_all;
input	[99:0]		bio_id_all;
input	[63:0]		char_data;
input	[9:0]		iVGA_X;
input	[9:0]		iVGA_Y;
input				iVGA_CLK, action_clk;
//	Control Signals
input				move_right, move_jump, move_left;
input				iColor_SW;

reg[50:0] occupy;
wire[15:0] x_blk[19:0], y_blk[19:0], x_blk_leng[19:0], y_blk_leng[19:0], //20�Ӫ��׬O16bit����ê�����T(x, y, x��, y��)
		  x_bio[9:0], y_bio[9:0], x_bio_leng[9:0], y_bio_leng[9:0], //10�Ӫ��׬O16bit���ͪ����T(x, y, x��, y��)
		  x_char, y_char, x_char_leng, y_char_leng, //16bit���D�����T(x, y, x��, y��)
		  x_sky = 0, y_sky = 0, x_sky_leng = 640, y_sky_leng = 80, //16bit���ѪŸ��T(x, y, x��, y��)
		  x_floor = 0, y_floor = 460, x_floor_leng = 640, y_floor_leng = 20; //16bit���a�����T(x, y, x��, y��)
wire[9:0]  blk_typeid[19:0], //20�Ӫ��׬O10bit����ê��typeid(x, y, x��, y��)
		  bio_typeid[9:0]; //10�Ӫ��׬O10bit���ͪ�typeid(x, y, x��, y��)
		  
integer blk_idx, bio_idx;

parameter char_r = 255, char_g = 255, char_b = 255,
		  sky_r = 210, sky_g = 105, sky_b = 30,
		  floor_r = 204, floor_g = 102, floor_b = 0;
		  
assign {x_blk[19], y_blk[19], x_blk[18], y_blk[18], x_blk[17], y_blk[17], x_blk[16], y_blk[16], x_blk[15], y_blk[15],
		x_blk[14], y_blk[14], x_blk[13], y_blk[13], x_blk[12], y_blk[12], x_blk[11], y_blk[11], x_blk[10], y_blk[10],
		x_blk[9], y_blk[9], x_blk[8], y_blk[8], x_blk[7], y_blk[7], x_blk[6], y_blk[6], x_blk[5], y_blk[5],
		x_blk[4], y_blk[4], x_blk[3], y_blk[3], x_blk[2], y_blk[2], x_blk[1], y_blk[1], x_blk[0], y_blk[0]
	   } = blk_cordinate,
	   {x_blk_leng[19], y_blk_leng[19], x_blk_leng[18], y_blk_leng[18], x_blk_leng[17], y_blk_leng[17], x_blk_leng[16], y_blk_leng[16], x_blk_leng[15], y_blk_leng[15],
		x_blk_leng[14], y_blk_leng[14], x_blk_leng[13], y_blk_leng[13], x_blk_leng[12], y_blk_leng[12], x_blk_leng[11], y_blk_leng[11], x_blk_leng[10], y_blk_leng[10],
		x_blk_leng[9], y_blk_leng[9], x_blk_leng[8], y_blk_leng[8], x_blk_leng[7], y_blk_leng[7], x_blk_leng[6], y_blk_leng[6], x_blk_leng[5], y_blk_leng[5],
		x_blk_leng[4], y_blk_leng[4], x_blk_leng[3], y_blk_leng[3], x_blk_leng[2], y_blk_leng[2], x_blk_leng[1], y_blk_leng[1], x_blk_leng[0], y_blk_leng[0]
	   } = blk_length,
	   {x_bio[9], y_bio[9], x_bio[8], y_bio[8], x_bio[7], y_bio[7], x_bio[6], y_bio[6], x_bio[5], y_bio[5],
	    x_bio[4], y_bio[4], x_bio[3], y_bio[3], x_bio[2], y_bio[2], x_bio[1], y_bio[1], x_bio[0], y_bio[0]
	   } = bio_cordinate,
	   {x_bio_leng[9], y_bio_leng[9], x_bio_leng[8], y_bio_leng[8], x_bio_leng[7], y_bio_leng[7], x_bio_leng[6], y_bio_leng[6], x_bio_leng[5], y_bio_leng[5],
	    x_bio_leng[4], y_bio_leng[4], x_bio_leng[3], y_bio_leng[3], x_bio_leng[2], y_bio_leng[2], x_bio_leng[1], y_bio_leng[1], x_bio_leng[0], y_bio_leng[0]
	   } = bio_length,
	   {x_char_leng, y_char_leng, x_char, y_char} = char_data,
	   {blk_typeid[19], blk_typeid[18], blk_typeid[17], blk_typeid[16], blk_typeid[15], blk_typeid[14], blk_typeid[13], blk_typeid[12], blk_typeid[11], blk_typeid[10],
	    blk_typeid[9], blk_typeid[8], blk_typeid[7], blk_typeid[6], blk_typeid[5], blk_typeid[4], blk_typeid[3], blk_typeid[2], blk_typeid[1], blk_typeid[0]
	   } = blk_id_all,
	   {bio_typeid[9], bio_typeid[8], bio_typeid[7], bio_typeid[6], bio_typeid[5], bio_typeid[4], bio_typeid[3], bio_typeid[2], bio_typeid[1], bio_typeid[0]} = bio_id_all;

/*BLOCK u0(
			.x(x_blk),
			.y(y_blk),
			.x_leng(x_blk_leng),
			.y_leng(y_blk_leng),
			.oRed(oRed),
			.oGreen(oGreen),
			.oBlue(oBlue),
			.vga_x(iVGA_X),
			.vga_y(iVGA_Y),
			.blk_clk(action_clk)
		);*/

always@(posedge iVGA_CLK) begin
	/*oRed	<=	(iVGA_Y<120)					?			3	:
				(iVGA_Y>=120 && iVGA_Y<240)		?			7	:
				(iVGA_Y>=240 && iVGA_Y<360)		?			11	:
															15	;
	oGreen	<=	(iVGA_X<80)						?			1	:
				(iVGA_X>=80 && iVGA_X<160)		?			3	:
				(iVGA_X>=160 && iVGA_X<240)		?			5	:
				(iVGA_X>=240 && iVGA_X<320)		?			7	:
				(iVGA_X>=320 && iVGA_X<400)		?			9	:
				(iVGA_X>=400 && iVGA_X<480)		?			11	:
				(iVGA_X>=480 && iVGA_X<560)		?			13	:
															15	;
	oBlue	<=	(iVGA_Y<60)						?			15	:
				(iVGA_Y>=60 && iVGA_Y<120)		?			13	:
				(iVGA_Y>=120 && iVGA_Y<180)		?			11	:
				(iVGA_Y>=180 && iVGA_Y<240)		?			9	:
				(iVGA_Y>=240 && iVGA_Y<300)		?			7	:
				(iVGA_Y>=300 && iVGA_Y<360)		?			5	:
				(iVGA_Y>=360 && iVGA_Y<420)		?			3	:
															1	;*/
															
	if(iVGA_Y > y_char && iVGA_Y < y_char + y_char_leng && iVGA_X > (((y_char + y_char_leng - iVGA_Y) * (x_char_leng / 2)) / y_char_leng + x_char) && iVGA_X < (x_char + x_char_leng - ((y_char + y_char_leng - iVGA_Y) * (x_char_leng / 2)) / y_char_leng)) begin
		oRed <= char_r;
		oGreen <= char_g;
		oBlue <= char_b;
		occupy[0] <= 1'b1;
	end
	else
		occupy[0] <= 1'b0;
		
	/*if(iVGA_X > x_floor && iVGA_X < x_floor + x_floor_leng && iVGA_Y > y_floor && iVGA_Y < y_floor + y_floor_leng) begin
		oRed <= floor_r;
		oGreen <= floor_g;
		oBlue <= floor_b;
		occupy[1] <= 1'b1;
	end
	else
		occupy[1] <= 1'b0;*/
		
	if(iVGA_X > x_sky && iVGA_X < x_sky + x_sky_leng && iVGA_Y > y_sky && iVGA_Y < y_sky + y_sky_leng) begin
		oRed <= sky_r;
		oGreen <= sky_g;
		oBlue <= sky_b;
		occupy[2] <= 1'b1;
	end
	else
		occupy[2] <= 1'b0;
		
	for(blk_idx = 0; blk_idx <= 19; blk_idx = blk_idx + 1) begin
		if(x_blk[blk_idx] + x_blk_leng[blk_idx] > 0 || x_blk[blk_idx] < 610) begin
			if(iVGA_X > x_blk[blk_idx] && iVGA_X < x_blk[blk_idx] + x_blk_leng[blk_idx] && iVGA_Y > y_blk[blk_idx] && iVGA_Y < y_blk[blk_idx] + y_blk_leng[blk_idx]) begin
				oRed   <= (blk_typeid[blk_idx] == 101) ? 0
						 :(blk_typeid[blk_idx] == 102) ? 255
						 :(blk_typeid[blk_idx] == 201) ? 153
						 :(blk_typeid[blk_idx] == 202) ? 0
						 :(blk_typeid[blk_idx] == 302) ? 204 : 0;
						 
				oGreen <= (blk_typeid[blk_idx] == 101) ? 255
						 :(blk_typeid[blk_idx] == 102) ? 255
						 :(blk_typeid[blk_idx] == 201) ? 0
						 :(blk_typeid[blk_idx] == 202) ? 255
						 :(blk_typeid[blk_idx] == 302) ? 0 : 0;
				
				oBlue  <= (blk_typeid[blk_idx] == 101) ? 0
						 :(blk_typeid[blk_idx] == 102) ? 0
						 :(blk_typeid[blk_idx] == 201) ? 0
						 :(blk_typeid[blk_idx] == 202) ? 255
						 :(blk_typeid[blk_idx] == 302) ? 204 : 0;
				
				occupy[blk_idx + 3] <= 1'b1;
			end
			else
				occupy[blk_idx + 3] <= 1'b0;
		end
	end
	
	for(bio_idx = 0; bio_idx <= 9; bio_idx = bio_idx + 1) begin
		if(x_bio[bio_idx] + x_bio_leng[bio_idx] > 0 && x_bio[bio_idx] < 610) begin
			if(iVGA_X > x_bio[bio_idx] && iVGA_X < x_bio[bio_idx] + x_bio_leng[0] && iVGA_Y > y_bio[bio_idx] && iVGA_Y < y_bio[bio_idx] + y_bio_leng[bio_idx]) begin
				oRed   <= (bio_typeid[bio_idx] == 101) ? 0
						 :(bio_typeid[bio_idx] == 102) ? 255
						 :(bio_typeid[bio_idx] == 201) ? 153
						 :(bio_typeid[bio_idx] == 202) ? 0
						 :(bio_typeid[bio_idx] == 302) ? 204 : 0;
						 
				oGreen <= (bio_typeid[bio_idx] == 101) ? 255
						 :(bio_typeid[bio_idx] == 102) ? 255
						 :(bio_typeid[bio_idx] == 201) ? 0
						 :(bio_typeid[bio_idx] == 202) ? 255
						 :(bio_typeid[bio_idx] == 302) ? 0 : 0;
				
				oBlue  <= (bio_typeid[bio_idx] == 101) ? 0
						 :(bio_typeid[bio_idx] == 102) ? 0
						 :(bio_typeid[bio_idx] == 201) ? 0
						 :(bio_typeid[bio_idx] == 202) ? 255
						 :(bio_typeid[bio_idx] == 302) ? 204 : 0;
				
				occupy[bio_idx + 23] <= 1'b1;
			end
			else
				occupy[bio_idx + 23] <= 1'b0;
		end
	end
			
	if(occupy == 0) begin
		oRed <= 0;
		oGreen <= 0;
		oBlue <= 0;
	end
	
	/*x_blk[0] = 200;y_blk[0] = 260;x_blk_leng[0] = 100;y_blk_leng[0] = 200;blk_typeid[0] = 302;
	x_bio[0] = 400;y_bio[0] = 380;x_bio_leng[0] = 40;y_bio_leng[0] = 80;bio_typeid[0] = 201;*/
end

/*always@(posedge action_clk) begin
	if(!move_right && x_char < 550)
		x_char = x_char + 20;
		
	if(!move_left && x_char > 20)
		x_char = x_char - 20;
end*/

endmodule
