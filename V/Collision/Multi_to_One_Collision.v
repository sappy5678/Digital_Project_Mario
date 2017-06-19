module Multi_to_One_Collision(clk,Collision,Singal,Other_Coordinate,Other_Size,Collision_Enable,Self_Coordinate,Self_Size,Type_List);
	
	
	input clk;
	input [32*20-1:0] Other_Coordinate,Other_Size;
	input [31:0] Self_Coordinate,Self_Size;	
	input [19:0]Collision_Enable;
	input [10*20-1:0]Type_List;
	output reg[19:0]Singal;
	reg [19:0]is_Collision;
	reg [9:0]Type_Array[19:0];
	reg [31:0] other_coordinate[19:0],other_size[19:0];
	
	
	
	
	// Signal 檢查
	always@(posedge clk)
	begin
		// 如果吃到$$$
		// 送出增加$$的訊號
		if(
			(Type_Array[0] == 10'd102 && is_Collision[0] == 1'b1) ||
			(Type_Array[1] == 10'd102 && is_Collision[1] == 1'b1) ||
			(Type_Array[2] == 10'd102 && is_Collision[2] == 1'b1) ||
			(Type_Array[3] == 10'd102 && is_Collision[3] == 1'b1) ||
			(Type_Array[4] == 10'd102 && is_Collision[4] == 1'b1) ||
			(Type_Array[5] == 10'd102 && is_Collision[5] == 1'b1) ||
			(Type_Array[6] == 10'd102 && is_Collision[6] == 1'b1) ||
			(Type_Array[7] == 10'd102 && is_Collision[7] == 1'b1) ||
			(Type_Array[8] == 10'd102 && is_Collision[8] == 1'b1) ||
			(Type_Array[9] == 10'd102 && is_Collision[9] == 1'b1) ||
			(Type_Array[10] == 10'd102 && is_Collision[10] == 1'b1) ||
			(Type_Array[11] == 10'd102 && is_Collision[11] == 1'b1) ||
			(Type_Array[12] == 10'd102 && is_Collision[12] == 1'b1) ||
			(Type_Array[13] == 10'd102 && is_Collision[13] == 1'b1) ||
			(Type_Array[14] == 10'd102 && is_Collision[14] == 1'b1) ||
			(Type_Array[15] == 10'd102 && is_Collision[15] == 1'b1) ||
			(Type_Array[16] == 10'd102 && is_Collision[16] == 1'b1) ||
			(Type_Array[17] == 10'd102 && is_Collision[17] == 1'b1) ||
			(Type_Array[18] == 10'd102 && is_Collision[18] == 1'b1) ||
			(Type_Array[19] == 10'd102 && is_Collision[19] == 1'b1) 
			)
			Singal[0] <= 1'b1;
		else
			Singal[0] <= 1'b0;
	end
	
	integer i ;
	always@(*)
	begin
		for(i = 0; i < 20; i =i+1)
		begin
			other_coordinate[i] <= Other_Coordinate[i*32+:32];
			other_size[i] <= Other_Size[i*32+:32];
			is_Collision[i] <= Collision_Enable[i] && (collision[i][0] || collision[i][1] || collision[i][2] || collision[i][3]);
			Type_Array[i] <= Type_List[i*10+:10];
		end
	end
	
	output reg[3:0]Collision;
	
	wire [3:0] collision[19:0];
	
		
	always@(*)
	begin
		if( 
		(Collision_Enable[19] && collision[19][3]) || 
		(Collision_Enable[18] && collision[18][3]) || 
		(Collision_Enable[17] && collision[17][3]) || 
		(Collision_Enable[16] && collision[16][3]) || 
		(Collision_Enable[15] && collision[15][3]) || 
		(Collision_Enable[14] && collision[14][3]) ||
		(Collision_Enable[13] && collision[13][3]) ||
	 	(Collision_Enable[12] && collision[12][3]) ||
		(Collision_Enable[11] && collision[11][3]) ||
		(Collision_Enable[10] && collision[10][3]) ||
		(Collision_Enable[9]  && collision[9][3]) || 
		(Collision_Enable[8]  && collision[8][3]) || 
		(Collision_Enable[7]  && collision[7][3]) || 
		(Collision_Enable[6]  && collision[6][3]) || 
		(Collision_Enable[5]  && collision[5][3]) || 
		(Collision_Enable[4]  && collision[4][3]) ||
		(Collision_Enable[3]  && collision[3][3]) ||
	 	(Collision_Enable[2]  && collision[2][3]) ||
		(Collision_Enable[1]  && collision[1][3]) ||
		(Collision_Enable[0]  && collision[0][3])
		)
			Collision[3] <= 1'd1;
		else
			Collision[3] <= 1'd0;
			
		if( 
		(Collision_Enable[19] && collision[19][2]) || 
		(Collision_Enable[18] && collision[18][2]) || 
		(Collision_Enable[17] && collision[17][2]) || 
		(Collision_Enable[16] && collision[16][2]) || 
		(Collision_Enable[15] && collision[15][2]) || 
		(Collision_Enable[14] && collision[14][2]) ||
		(Collision_Enable[13] && collision[13][2]) ||
	 	(Collision_Enable[12] && collision[12][2]) ||
		(Collision_Enable[11] && collision[11][2]) ||
		(Collision_Enable[10] && collision[10][2]) ||
		(Collision_Enable[9] && collision[9][2]) || 
		(Collision_Enable[8] && collision[8][2]) || 
		(Collision_Enable[7] && collision[7][2]) || 
		(Collision_Enable[6] && collision[6][2]) || 
		(Collision_Enable[5] && collision[5][2]) || 
		(Collision_Enable[4] && collision[4][2]) ||
		(Collision_Enable[3] && collision[3][2]) ||
	 	(Collision_Enable[2] && collision[2][2]) ||
		(Collision_Enable[1] && collision[1][2]) ||
		(Collision_Enable[0] && collision[0][2])
		)
			Collision[2] <= 1'd1;
		else
			Collision[2] <= 1'd0;
		
		if( 
		(Collision_Enable[19] && collision[19][1]) || 
		(Collision_Enable[18] && collision[18][1]) || 
		(Collision_Enable[17] && collision[17][1]) || 
		(Collision_Enable[16] && collision[16][1]) || 
		(Collision_Enable[15] && collision[15][1]) || 
		(Collision_Enable[14] && collision[14][1]) ||
		(Collision_Enable[13] && collision[13][1]) ||
	 	(Collision_Enable[12] && collision[12][1]) ||
		(Collision_Enable[11] && collision[11][1]) ||
		(Collision_Enable[10] && collision[10][1]) ||
		(Collision_Enable[9] && collision[9][1]) || 
		(Collision_Enable[8] && collision[8][1]) || 
		(Collision_Enable[7] && collision[7][1]) || 
		(Collision_Enable[6] && collision[6][1]) || 
		(Collision_Enable[5] && collision[5][1]) || 
		(Collision_Enable[4] && collision[4][1]) ||
		(Collision_Enable[3] && collision[3][1]) ||
	 	(Collision_Enable[2] && collision[2][1]) ||
		(Collision_Enable[1] && collision[1][1]) ||
		(Collision_Enable[0] && collision[0][1])
		
		)
			Collision[1] <= 1'd1;
		else
			Collision[1] <= 1'd0;
		
		// 右邊
		if( 
		(Collision_Enable[19] && collision[19][0]) || 
		(Collision_Enable[18] && collision[18][0]) || 
		(Collision_Enable[17] && collision[17][0]) || 
		(Collision_Enable[16] && collision[16][0]) || 
		(Collision_Enable[15] && collision[15][0]) || 
		(Collision_Enable[14] && collision[14][0]) ||
		(Collision_Enable[13] && collision[13][0]) ||
	 	(Collision_Enable[12] && collision[12][0]) ||
		(Collision_Enable[11] && collision[11][0]) ||
		(Collision_Enable[10] && collision[10][0]) ||
		(Collision_Enable[9] && collision[9][0]) || 
		(Collision_Enable[8] && collision[8][0]) || 
		(Collision_Enable[7] && collision[7][0]) || 
		(Collision_Enable[6] && collision[6][0]) || 
		(Collision_Enable[5] && collision[5][0]) || 
		(Collision_Enable[4] && collision[4][0]) ||
		(Collision_Enable[3] && collision[3][0]) ||
	 	(Collision_Enable[2] && collision[2][0]) ||
		(Collision_Enable[1] && collision[1][0]) ||
		(Collision_Enable[0] && collision[0][0])
		)
			Collision[0] <= 1'd1;
		else
			Collision[0] <= 1'd0;
	end
	
	// C0
	Collision c0(
					
					.clk(clk), // Clock
					
					// 輸出
					.Collision_Arrow(collision[0]), //碰撞方向 
					
					// 輸入
					.Self_Coordinate(Self_Coordinate), // 自己的座標					
					.Self_Size(Self_Size),      // 自己的大小
					
					.Other_Coordinate(other_coordinate[0]), // 其他人的座標
					.Other_Size(other_size[0])        // 其他人的大小
						);
		// C1
	Collision c1(
					
					.clk(clk), // Clock
					
					// 輸出
					.Collision_Arrow(collision[1]), //碰撞方向 
					
					// 輸入
					.Self_Coordinate(Self_Coordinate), // 自己的座標					
					.Self_Size(Self_Size),      // 自己的大小
					
					.Other_Coordinate(other_coordinate[1]), // 其他人的座標
					.Other_Size(other_size[1])        // 其他人的大小
						);
	
		// C2
	Collision c2(
					
					.clk(clk), // Clock
					
					// 輸出
					.Collision_Arrow(collision[2]), //碰撞方向 
					
					// 輸入
					.Self_Coordinate(Self_Coordinate), // 自己的座標					
					.Self_Size(Self_Size),      // 自己的大小
					
					.Other_Coordinate(other_coordinate[2]), // 其他人的座標
					.Other_Size(other_size[2])        // 其他人的大小
						);
						
		// C3
	Collision c3(
					
					.clk(clk), // Clock
					
					// 輸出
					.Collision_Arrow(collision[3]), //碰撞方向 
					
					// 輸入
					.Self_Coordinate(Self_Coordinate), // 自己的座標					
					.Self_Size(Self_Size),      // 自己的大小
					
					.Other_Coordinate(other_coordinate[3]), // 其他人的座標
					.Other_Size(other_size[3])        // 其他人的大小
						);
	
		// C4
	Collision c4(
					
					.clk(clk), // Clock
					
					// 輸出
					.Collision_Arrow(collision[4]), //碰撞方向 
					
					// 輸入
					.Self_Coordinate(Self_Coordinate), // 自己的座標					
					.Self_Size(Self_Size),      // 自己的大小
					
					.Other_Coordinate(other_coordinate[4]), // 其他人的座標
					.Other_Size(other_size[4])        // 其他人的大小
						);
						
		// C5
	Collision c5(
					
					.clk(clk), // Clock
					
					// 輸出
					.Collision_Arrow(collision[5]), //碰撞方向 
					
					// 輸入
					.Self_Coordinate(Self_Coordinate), // 自己的座標					
					.Self_Size(Self_Size),      // 自己的大小
					
					.Other_Coordinate(other_coordinate[5]), // 其他人的座標
					.Other_Size(other_size[5])        // 其他人的大小
						);
	
	// C6
	Collision c6(
					
					.clk(clk), // Clock
					
					// 輸出
					.Collision_Arrow(collision[6]), //碰撞方向 
					
					// 輸入
					.Self_Coordinate(Self_Coordinate), // 自己的座標					
					.Self_Size(Self_Size),      // 自己的大小
					
					.Other_Coordinate(other_coordinate[6]), // 其他人的座標
					.Other_Size(other_size[6])        // 其他人的大小
						);
	// C7
	Collision c7(
					
					.clk(clk), // Clock
					
					// 輸出
					.Collision_Arrow(collision[7]), //碰撞方向 
					
					// 輸入
					.Self_Coordinate(Self_Coordinate), // 自己的座標					
					.Self_Size(Self_Size),      // 自己的大小
					
					.Other_Coordinate(other_coordinate[7]), // 其他人的座標
					.Other_Size(other_size[7])        // 其他人的大小
						);
						
	// C8
	Collision c8(
					
					.clk(clk), // Clock
					
					// 輸出
					.Collision_Arrow(collision[8]), //碰撞方向 
					
					// 輸入
					.Self_Coordinate(Self_Coordinate), // 自己的座標					
					.Self_Size(Self_Size),      // 自己的大小
					
					.Other_Coordinate(other_coordinate[8]), // 其他人的座標
					.Other_Size(other_size[8])        // 其他人的大小
						);					
						
	// C9
	Collision c9(
					
					.clk(clk), // Clock
					
					// 輸出
					.Collision_Arrow(collision[9]), //碰撞方向 
					
					// 輸入
					.Self_Coordinate(Self_Coordinate), // 自己的座標					
					.Self_Size(Self_Size),      // 自己的大小
					
					.Other_Coordinate(other_coordinate[9]), // 其他人的座標
					.Other_Size(other_size[9])        // 其他人的大小
						);
		// C10
	Collision c10(
					
					.clk(clk), // Clock
					
					// 輸出
					.Collision_Arrow(collision[10]), //碰撞方向 
					
					// 輸入
					.Self_Coordinate(Self_Coordinate), // 自己的座標					
					.Self_Size(Self_Size),      // 自己的大小
					
					.Other_Coordinate(other_coordinate[10]), // 其他人的座標
					.Other_Size(other_size[10])        // 其他人的大小
						);
		// C11
	Collision c11(
					
					.clk(clk), // Clock
					
					// 輸出
					.Collision_Arrow(collision[11]), //碰撞方向 
					
					// 輸入
					.Self_Coordinate(Self_Coordinate), // 自己的座標					
					.Self_Size(Self_Size),      // 自己的大小
					
					.Other_Coordinate(other_coordinate[11]), // 其他人的座標
					.Other_Size(other_size[11])        // 其他人的大小
						);
	
		// C12
	Collision c12(
					
					.clk(clk), // Clock
					
					// 輸出
					.Collision_Arrow(collision[12]), //碰撞方向 
					
					// 輸入
					.Self_Coordinate(Self_Coordinate), // 自己的座標					
					.Self_Size(Self_Size),      // 自己的大小
					
					.Other_Coordinate(other_coordinate[12]), // 其他人的座標
					.Other_Size(other_size[12])        // 其他人的大小
						);
						
		// C13
	Collision c13(
					
					.clk(clk), // Clock
					
					// 輸出
					.Collision_Arrow(collision[13]), //碰撞方向 
					
					// 輸入
					.Self_Coordinate(Self_Coordinate), // 自己的座標					
					.Self_Size(Self_Size),      // 自己的大小
					
					.Other_Coordinate(other_coordinate[13]), // 其他人的座標
					.Other_Size(other_size[13])        // 其他人的大小
						);
	
		// C14
	Collision c14(
					
					.clk(clk), // Clock
					
					// 輸出
					.Collision_Arrow(collision[14]), //碰撞方向 
					
					// 輸入
					.Self_Coordinate(Self_Coordinate), // 自己的座標					
					.Self_Size(Self_Size),      // 自己的大小
					
					.Other_Coordinate(other_coordinate[14]), // 其他人的座標
					.Other_Size(other_size[14])        // 其他人的大小
						);
						
		// C15
	Collision c15(
					
					.clk(clk), // Clock
					
					// 輸出
					.Collision_Arrow(collision[15]), //碰撞方向 
					
					// 輸入
					.Self_Coordinate(Self_Coordinate), // 自己的座標					
					.Self_Size(Self_Size),      // 自己的大小
					
					.Other_Coordinate(other_coordinate[15]), // 其他人的座標
					.Other_Size(other_size[15])        // 其他人的大小
						);
	
	// C16
	Collision c16(
					
					.clk(clk), // Clock
					
					// 輸出
					.Collision_Arrow(collision[16]), //碰撞方向 
					
					// 輸入
					.Self_Coordinate(Self_Coordinate), // 自己的座標					
					.Self_Size(Self_Size),      // 自己的大小
					
					.Other_Coordinate(other_coordinate[16]), // 其他人的座標
					.Other_Size(other_size[16])        // 其他人的大小
						);
	// C17
	Collision c17(
					
					.clk(clk), // Clock
					
					// 輸出
					.Collision_Arrow(collision[17]), //碰撞方向 
					
					// 輸入
					.Self_Coordinate(Self_Coordinate), // 自己的座標					
					.Self_Size(Self_Size),      // 自己的大小
					
					.Other_Coordinate(other_coordinate[17]), // 其他人的座標
					.Other_Size(other_size[17])        // 其他人的大小
						);
						
	// C18
	Collision c18(
					
					.clk(clk), // Clock
					
					// 輸出
					.Collision_Arrow(collision[18]), //碰撞方向 
					
					// 輸入
					.Self_Coordinate(Self_Coordinate), // 自己的座標					
					.Self_Size(Self_Size),      // 自己的大小
					
					.Other_Coordinate(other_coordinate[18]), // 其他人的座標
					.Other_Size(other_size[18])        // 其他人的大小
						);					
						
	// C19
	Collision c19(
					
					.clk(clk), // Clock
					
					// 輸出
					.Collision_Arrow(collision[19]), //碰撞方向 
					
					// 輸入
					.Self_Coordinate(Self_Coordinate), // 自己的座標					
					.Self_Size(Self_Size),      // 自己的大小
					
					.Other_Coordinate(other_coordinate[19]), // 其他人的座標
					.Other_Size(other_size[19])        // 其他人的大小
						);
endmodule