module Coin(
				clk,
				Collision, // 看看有沒有碰撞
				Coordinate, //輸入座標
				Result_Coordinate, // 輸出座標
				Type,// 輸入型態
				Result_Type,// 輸出型態
				Collision_Enable, //能不能撞到
				Size,
				Result_Size,
				);

	input clk;
	input [3:0]Collision;
	input [31:0]Coordinate,Size;
	input [9:0]Type;
	
	output reg Collision_Enable;
	output [9:0]Result_Type;
	output reg[31:0]Result_Coordinate,Result_Size;
	
	assign Result_Type = Type;
	
	always@(posedge clk)
	begin
		if(Collision[0] || Collision[1] || Collision[2] ||Collision[3])
		begin
			Result_Coordinate <= {-16'd1,-16'd1};
			Result_Size <= {16'd0,16'd0};
			Collision_Enable	<= 1'd0;
		end
		
		else
		begin
			Result_Coordinate <= Coordinate;
			Result_Size <= Size;
			Collision_Enable	<= 1'd1;
		end
	end
				
endmodule