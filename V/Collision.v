module Collision(
					
					clk, // Clock
					
					// 輸出
					Collision_Arrow, //碰撞方向 
					
					// 輸入
					Self_Coordinate, // 自己的座標					
					Self_Size,      // 自己的大小
					
					Other_Coordinate, // 其他人的座標
					Other_Size        // 其他人的大小
						);
	
	parameter other_number = 1;
	input clk;
	output reg[3:0]Collision_Arrow;
	
	input [31:0]Self_Coordinate;
	input [31:0]Self_Size;
	input [32 * other_number -1:0]Other_Coordinate;
	input [32 * other_number -1:0]Other_Size;
	
	// 轉換成比較好看的樣子XDD
	reg [15:0]self_up,self_down,self_left,self_right;
	always@(*)
	begin
		self_up <= Self_Coordinate[15 :0];
		self_down <= (Self_Coordinate[15 :0] + Self_Size[15:0]);
		self_left <= Self_Coordinate[31 :16];
		self_right <= (Self_Coordinate[31 :16] + Self_Size[31:16]);
	end
	
	// 轉換成比較好看的樣子XDD
	reg [16*other_number-1:0]other_up,other_down,other_left,other_right;
	always@(*)
	begin
		integer i;
		for(i = 0;i <other_number; i=i+1)
		begin
			other_up[i*16+:16] <= Other_Coordinate[i*32+:16];
			other_down[i*16+:16] <= (Other_Coordinate[i*32+:16] + Other_Size[i*32+:16]);
			other_left[i*16+:16] <= Other_Coordinate[(i+1)*31-:16];
			other_right[i*16+:16] <= (Other_Coordinate[(i+1)*31-:16]  + Other_Size[(i+1)*31-:16] );		
		end
	end
	

	// 偵測有沒有碰撞
	always@(posedge clk)
	begin
	
		// 偵測
		// 參考資料
		// https://stackoverflow.com/a/18068296/4754280
		integer i;
		for(i = 0;i <other_number; i=i+1)
		begin
			// 上面有沒有碰撞
			// 上面有沒有被包在其他物體的中間
			if (self_up  < other_down[i*16+:16] && self_up  > other_up[i*16+:16])
				Collision_Arrow[3] <= 1'b1;
			else
				Collision_Arrow[3] <= 1'b0;
			// 下面有沒有碰撞
			if (self_down > other_up[i*16+:16] && self_down < other_down[i*16+:16])
				Collision_Arrow[2] <= 1'b1;
			else
				Collision_Arrow[2] <= 1'b0;
				
			// 左邊面有沒有碰撞
			if (self_left  < other_right[i*16+:16] && self_left  > other_left[i*16+:16])
				Collision_Arrow[1] <= 1'b1;
			else
				Collision_Arrow[1] <= 1'b0;
				
			// 右邊有沒有碰撞
			if (self_right  < other_right[i*16+:16] && self_right  > other_left[i*16+:16])
				Collision_Arrow[0] <= 1'b1;
			else
				Collision_Arrow[0] <= 1'b0;
			
		end
	end
						
						
						
						
endmodule