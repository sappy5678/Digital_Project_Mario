module Level2_Map(clk,
						// 輸出
						Life_ID_Array,// 前10個生物的ID
						Life_Type_Array, // 前10個生物的型態
						Life_Coordinate_Array, // 前10個生物的座標
						Life_Size_Array, // 前10個生物的大小
						Object_ID_Array,// 前10個物體的ID
						Object_Type_Array, // 前10個物體的型態
						Object_Coordinate_Array, // 前10個生物的座標
						Object_Size_Array, // 前10個生物的大小
						
						// 輸入
						//Base_Coordinate,	// 基礎座標
						Arrow, // 方向
						rst,
						
						// Test
						Test
						);
						
	output [31:0] Test;
	assign Test = Mario_Collision;
	
	input clk,rst;
   
	reg [59:0]object_collision_enable; // 能不能碰撞
	output reg[99:0]Life_ID_Array,Life_Type_Array;
	output reg[32*10-1:0]Life_Coordinate_Array,Life_Size_Array;
	output reg[10*20-1:0]Object_ID_Array,Object_Type_Array;
	output reg[32*20-1:0] Object_Coordinate_Array,Object_Size_Array;
	reg [9:0] Life_ID[9:0],Life_Type[9:0],Object_ID[19:0],Object_Type[19:0];
	reg [31:0]Life_Coordinate[9:0],Life_Size[9:0],Object_Coordinate[19:0],Object_Size[19:0];
	input [3:0] Arrow;
	
	// unpack
	integer Life_Number,Object_Number;
	always@(*)
	begin
		for(Life_Number = 0; Life_Number < 10;Life_Number = Life_Number + 1)
		begin		
			Life_ID_Array[Life_Number*10+:10] <= Life_ID[Life_Number] ;
			Life_Type_Array[Life_Number*10+:10] <=  Life_Type[Life_Number];
			
			
			// 32
			Life_Coordinate_Array[Life_Number*32+:32] <=  Life_Coordinate[Life_Number];
			Life_Size_Array[Life_Number*32+:32] <=  Life_Size[Life_Number];

		end
		
		for(Object_Number = 0; Object_Number < 20;Object_Number = Object_Number + 1)
		begin
			Object_ID_Array[Object_Number*10+:10] <=  Object_ID[Object_Number];
			Object_Type_Array[Object_Number*10+:10] <=  Object_Type[Object_Number];
			Object_Coordinate_Array[Object_Number*32+:32] <=  Object_Coordinate[Object_Number];
			Object_Size_Array[Object_Number*32+:32] <=  Object_Size[Object_Number];
		end
	end
	

	// Seeting !!!!!!!!!!!!!!!!!!!!!!!!!
	reg [9:0] Object_Collision_Enable = {
		1'd1,1'd1,8'd0
														};
	reg [9:0]
		life_ID[59:0],
		life_type[59:0],
		object_ID[59:0],
		object_type[59:0]; // 只有60個物體
	reg signed [31:0]
		life_coordinate[59:0],
		life_size[59:0],
		object_coordinate[59:0],						
		object_size[59:0]; // 只有60個物體
	
	// 取前 9個生物+主角、20個物體出來
	integer Life_Number_1,Object_Number_1;
	always@(*)
	begin
		for(Life_Number_1 = 0; Life_Number_1 < 9;Life_Number_1 = Life_Number_1 + 1)
		begin
			Life_Coordinate[Life_Number_1] <= life_coordinate[Life_Number_1];
			Life_Size[Life_Number_1] <= life_size[Life_Number_1];	
			Life_ID[Life_Number_1] <= life_ID[Life_Number_1];
			Life_Type[Life_Number_1] <= life_type[Life_Number_1]; 
			
		end
		for(Object_Number_1 = 0; Object_Number_1 < 20;Object_Number_1 = Object_Number_1 + 1)
		begin
			Object_ID[Object_Number_1] <= object_ID[Object_Number_1];
			Object_ID[Object_Number_1] <= object_ID[Object_Number_1];
			Object_Type[Object_Number_1] <= object_type[Object_Number_1];
			Object_Type[Object_Number_1] <= object_type[Object_Number_1];
			Object_Coordinate[Object_Number_1][31:16]<=object_coordinate[Object_Number_1][31:16];
			Object_Coordinate[Object_Number_1][15:0]<=object_coordinate[Object_Number_1][15:0];
			Object_Size[Object_Number_1]<= object_size[Object_Number_1];

		end
		
		
		Object_Collision_Enable <= object_collision_enable[9:0];
	end
	
	// 檢查前 N 生物
	integer i,empty;
	wire [31:0]Base_Coordinate;
	assign Base_Coordinate[31:16] = Mario_Coordinate[31:16] ;
	always@(posedge clk or posedge rst)
	begin
		if(rst == 1'd1)
		begin
			// 地板
			object_ID[0] <= 10'd1;
			object_type[0] <= 10'd101;
			object_coordinate[0] <= {16'd100,16'd450};
			object_size[0] <= {16'd300,16'd20};
			object_collision_enable[0] <= 1'd1;
			
			// 測試用小方塊
			object_ID[1] <= 10'd2;
			object_type[1] <= 10'd101;
			object_coordinate[1] <= {16'd370,16'd400};
			object_size[1] <= {16'd30,16'd30};
			object_collision_enable[1] <= 1'd1;
			
			// 測試用小方塊
			object_ID[2] <= 10'd3;
			object_type[2] <= 10'd101;
			object_coordinate[2] <= {16'd550,16'd350};
			object_size[2] <= {16'd30,16'd30};
			object_collision_enable[2] <= 1'd1;
			
			// 測試用小方塊
			object_ID[3] <= 10'd4;
			object_type[3] <= 10'd101;
			object_coordinate[3] <= {16'd670,16'd400};
			object_size[3] <= {16'd30,16'd30};
			object_collision_enable[3] <= 1'd1;
			
			// 測試用小方塊
			object_ID[4] <= 10'd3;
			object_type[4] <= 10'd101;
			object_coordinate[4] <= {16'd750,16'd300};
			object_size[4] <= {16'd50,16'd50};
			object_collision_enable[4] <= 1'd1;
			
			// 測試用小方塊
			object_ID[5] <= 10'd3;
			object_type[5] <= 10'd101;
			object_coordinate[5] <= {16'd850,16'd270};
			object_size[5] <= {16'd40,16'd20};
			object_collision_enable[5] <= 1'd1;
			
			// 暫時沒有東西
			for(empty = 6;empty<60;empty=empty+1)
			begin
				object_ID[empty] <= 10'd101;
				object_type[empty] <= 10'd101;
				object_coordinate[empty] <= {empty*150,16'd300};
				object_size[empty] <= {16'd30,16'd30};
				object_collision_enable[empty] <= 1'd1;
			end
			/*
			object_ID <={
			10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,
			10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,
			10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,
			10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,
			10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,
			10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd1,10'd2,
								};
			object_type<={
			10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,
			10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,
			10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,
			10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,
			10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,
			10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd0,10'd101,10'd101
									};
			object_coordinate<={
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd460,
			16'd430,16'd430,
											};
											
			object_size <={
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd0,16'd0,
			16'd480,16'd20,
			16'd430,16'd430
									};
									*/
									
			
		end
		// 如果第一個超出邊界 看 X 軸
		
		else if((Object_Coordinate[0][31:16])  < 16'd1)
		begin
			//Life_ID << 10; Life_Type <<10; Object_ID << 10; Object_Type<<10;
			//Life_Coordinate << 32; Life_Size << 32; Object_Coordinate << 32; Object_Size << 32;
				
			//life_ID << 10; life_type << 10; object_ID<<10; object_type<<10;
			//life_coordinate << 32; life_size << 32; object_coordinate << 32; object_size << 32;
				
			// Shift Right
			for(i = 0;i < 59; i = i+1)
			begin
					object_ID[i] <=object_ID[i+1];
					object_type[i] <=object_type[i+1];
					object_coordinate[i] <=object_coordinate[i+1];
					object_size[i] <=object_size[i+1];
					object_collision_enable[i]<=object_collision_enable[i+1];
			end
		end
		
		// 維持原樣
		else
		begin
				for(i = 0;i < 60; i = i+1)
				begin
					object_ID[i] <=object_ID[i];
					object_type[i] <=object_type[i];
					object_coordinate[i] <=object_coordinate[i];
					object_size[i] <=object_size[i];
					object_collision_enable[i]<=object_collision_enable[i];
				end
		end
	
	end
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////
	// 分別給每個生物體資訊
	// 生物1 主角
	
	wire [31:0]Mario_Coordinate;
	wire [31:0]Mario_Size ;
	wire Mario_Collision_Enable;
	wire Mario_UID;
	wire Mario_Type;
	wire life;
	wire score;
	reg [3:0]collision;
	reg [9:0]Collision_Type;
	Character #(
			.H_speed(3), .V_speed(3)
			)mario(
			// 標準型態
			// 輸出
			.UID(Mario_UID), // 唯一辨識ID
			.Type(Mario_Type), // 型態
			.Coordinate(Mario_Coordinate), // 座標 (X/Y) 左上 0 0
			.Size(Mario_Size), // 大小(X/Y) 右下為正			
			.Collision_Enable(Mario_Collision_Enable), // 是否可以碰撞 1 可 0 會穿透			
			
			// 輸入
			.Collision(Mario_Collision), // 碰撞 (上/下/左/右)
			// TODO
			.Collision_Type(0),   // 碰撞物體的型態
			.clk(clk), // Clock
			.Mario_Signal(Mario_Signal),
			
			// 瑪利歐獨有型態
			// 輸出
			.Life(life), // 生命值
			.Score(score), // 分數
			
			// 輸入
			.Arrow(Arrow), // 方向箭頭
			.rst(rst),
			.Test()
			
	);
	// 馬力歐
	always@(*)
	begin
		Life_ID[9] <= Mario_UID;
		Life_Type[9] <= Mario_Type;
		Life_Coordinate[9] <= Mario_Coordinate;
		Life_Size[9] <= Mario_Size;
	end
	
	wire [19:0]Mario_Signal;
	// 馬力歐碰撞
	// 10 對 1 碰撞
	wire [3:0]Mario_Collision;
	Multi_to_One_Collision m2o(.clk(clk),
										.Collision(Mario_Collision),
										.Singal(Mario_Signal),
										.Other_Coordinate(Object_Coordinate_Array),
										.Other_Size(Object_Size_Array),
										.Collision_Enable(Object_Collision_Enable),
										.Self_Coordinate(Mario_Coordinate),
										.Self_Size(Mario_Size),
										.Type_List(Object_Type_Array)
										);
										
	
	// 地板
	/*
	always@(*)
	begin
		object_ID[0] <= 10'd1;
		object_type[0] <= 10'd101;
		object_coordinate[0] <= {16'd0,16'd460};
		object_size[0] <= {16'd480,16'd20};
		object_collision_enable[0] <= 1'd1;
	
	// 測試用小方塊
		object_ID[1] <= 10'd2;
		object_type[1] <= 10'd101;
		object_coordinate[1] <= {16'd430,16'd430};
		object_size[1] <= {16'd20,16'd20};
		object_collision_enable[1] <= 1'd1;
	end
	*/
endmodule