module Coordinate_Calculation(clk,
										rst, // Reset
										Coordinate, // 座標
										Move_arrow, // 移動方向
										Move_speed,    // 上下左右移動的速度
										Test
										);
	output [31:0]Test;
	assign Test  = clk;

	input clk,rst;									
	output reg [31:0]Coordinate;
	input [3:0]Move_arrow;
	input [31:0]Move_speed;
	
	reg [31:0]Next_Coordinate;
	
	// 塞入暫存器
	always@(posedge clk or posedge rst)
	begin
		if(rst == 1'd1)
			Coordinate <= {16'd320,16'd100};
		else
			Coordinate <= Next_Coordinate;

			
	end
	
	// 計算位置
	always@(*)
	begin
		// 上下控制
		if(Move_arrow[3] == 1'b1) // 如果向上
			Next_Coordinate[15:0] <=Coordinate[15:0] - Move_speed[31:16];	
		else if(Move_arrow[2] == 1'b1) // 如果向下
			Next_Coordinate[15:0] <=Coordinate[15:0] + Move_speed[31:16];	
		else
			Next_Coordinate[15:0] <=Coordinate[15:0];
		
		// 左右控制
		if(Move_arrow[1] == 1'b1) // 如果向左
			Next_Coordinate[31:16] <=Coordinate[31:16]-Move_speed[15:0];
		else if(Move_arrow[0] == 1'b1) // 如果向右
			Next_Coordinate[31:16] <=Coordinate[31:16]+Move_speed[15:0];	
		else
			Next_Coordinate[31:16] <=Coordinate[31:16];	
	end

endmodule