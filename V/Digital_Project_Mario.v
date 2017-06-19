module Digital_Project_Mario(
										
										CLOCK_50,
										Move_Arrow_Input, // 移動方向
										SW, // switch
										
										VGA_R, //VGA
										VGA_G, //VGA
										VGA_B, //VGA
										VGA_HS,
										VGA_VS,
										
										SEG,
										
										// For test
										Test,
										Test2,
										Test3
										
										);
										
	output [13:0] SEG;
	output [31:0] Test,Test2;
	output [31:0] Test3;
	assign Test = Life_Coordinate[9];
	assign Test2 = Life_Size[9];
	//assign Test3 = Object_Type_Array[19:10];
	Score_Display SD(.score(Life_Coordinate[9][27:21] ), .display_ten(SEG[13:7]), .display_digit(SEG[6:0]));
	
	input CLOCK_50;
	output VGA_VS,VGA_HS;
	output	[3:0]	VGA_R;   				//	VGA Red[3:0]
	output	[3:0]	VGA_G;	 				//	VGA Green[3:0]
	output	[3:0]	VGA_B;   				//	VGA Blue[3:0]
	input [2:0]Move_Arrow_Input;
	wire [3:0]Move_Arrow;
	reg [9:0] Life_ID[9:0],Life_Type[9:0],Object_ID[19:0],Object_Type[19:0];	
	reg [31:0]Life_Coordinate[9:0],Life_Size[9:0],Object_Coordinate[19:0],Object_Size[19:0];
	wire[99:0]Life_ID_Array,Life_Type_Array;
	wire[32*10-1:0]Life_Coordinate_Array,Life_Size_Array;
	wire[10*20-1:0]Object_ID_Array,Object_Type_Array;
	wire[32*20-1:0]Object_Coordinate_Array,Object_Size_Array;

	
	input	[9:0]	SW;
	assign Move_Arrow[3] = ~Move_Arrow_Input[1]; // 上
	assign Move_Arrow[1] = ~Move_Arrow_Input[2]; // 左
	assign Move_Arrow[0] = ~Move_Arrow_Input[0]; // 右
	
	// CLOCK_50
	// GAME_CLK[20]
	Level1_Map LV1(.clk(GAME_CLK[19]),
						// 輸出
						.Life_ID_Array(Life_ID_Array),// 前10個生物的ID
						.Life_Type_Array(Life_Type_Array), // 前10個生物的型態
						.Life_Coordinate_Array(Life_Coordinate_Array), // 前10個生物的座標
						.Life_Size_Array(Life_Size_Array), // 前10個生物的大小
						.Object_ID_Array(Object_ID_Array),// 前10個物體的ID
						.Object_Type_Array(Object_Type_Array), // 前10個物體的型態
						.Object_Coordinate_Array(Object_Coordinate_Array), // 前10個生物的座標
						.Object_Size_Array(Object_Size_Array), // 前10個生物的大小
						
						// 輸入
						//Base_Coordinate,	// 基礎座標
						.Arrow(Move_Arrow), // 方向
						// TODO
						.rst(SW[0]),
						
						// Test
						.Test(Test3)
						);
						
	reg [20*32-1:0]Visual_Object_Coordinate_Array;
	
	integer i;
	always@(*)
	begin
		for(i = 0; i < 20; i = i+1)
		begin
			Visual_Object_Coordinate_Array[(32*i+16)+:16] <=Object_Coordinate_Array[(32*i+16)+:16] - Life_Coordinate[9][31:16] + 16'd320;
			Visual_Object_Coordinate_Array[(32*i)+:16] <=Object_Coordinate_Array[(32*i)+:16] ;
		end
	end
	// unpack
	integer Life_Number,Object_Number;
	always@(*)
	begin
		for(Life_Number = 0; Life_Number < 10;Life_Number = Life_Number + 1)
		begin		
			Life_ID[Life_Number] <= Life_ID_Array[Life_Number*10+:10] ;
			Life_Type[Life_Number] <=  Life_Type_Array[Life_Number*10+:10];
			
			
			// 32
			Life_Coordinate[Life_Number] <=  Life_Coordinate_Array[Life_Number*32+:32];
			Life_Size[Life_Number] <=  Life_Size_Array[Life_Number*32+:32];

		end
		
		for(Object_Number = 0; Object_Number < 20;Object_Number = Object_Number + 1)
		begin
			Object_ID[Object_Number] <=  Object_ID_Array[Object_Number*10+:10];
			Object_Type[Object_Number] <=  Object_Type_Array[Object_Number*10+:10];
			Object_Coordinate[Object_Number] <=  Object_Coordinate_Array[Object_Number*32+:32];
			Object_Size[Object_Number] <=  Object_Size_Array[Object_Number*32+:32];
		end
	end
	
	////////////////////////	VGA			////////////////////////////
	wire			VGA_CTRL_CLK;
	wire	[20:0]GAME_CLK; //for gaming clock
	wire	[9:0]	mVGA_X;
	wire	[9:0]	mVGA_Y;
	wire	[9:0]	mVGA_R;
	wire	[9:0]	mVGA_G;
	wire	[9:0]	mVGA_B;
	//wire	[19:0]	mVGA_ADDR;
	wire	[9:0]	sVGA_R;
	wire	[9:0]	sVGA_G;
	wire	[9:0]	sVGA_B;
	assign	VGA_R	=	sVGA_R[3:0];
	assign	VGA_G	=	sVGA_G[3:0];
	assign	VGA_B	=	sVGA_B[3:0];
	
	
	VGA_REAL_GAME_CLK u4
		(	.inclk0(CLOCK_50),
			.outclk(GAME_CLK)
		);

	VGA_CLK		u1
		(	.inclk0(CLOCK_50),
			.c0(VGA_CTRL_CLK)
		);

	VGA_Ctrl	u2
		(	//	Host Side
			.oCurrent_X(mVGA_X),
			.oCurrent_Y(mVGA_Y),
			.iRed(mVGA_R),
			.iGreen(mVGA_G),
			.iBlue(mVGA_B),
			//	VGA Side
			.oVGA_R(sVGA_R),
			.oVGA_G(sVGA_G),
			.oVGA_B(sVGA_B),
			.oVGA_HS(VGA_HS),
			.oVGA_VS(VGA_VS),
			.oVGA_SYNC(),
			.oVGA_BLANK(),
			.oVGA_CLOCK(),
			//	Control Signal
			.iCLK(VGA_CTRL_CLK),
			.iRST_N(1)
		);


		
	VGA_Pattern	u3
		(	//	Read Out Side
			.oRed(mVGA_R),
			.oGreen(mVGA_G),
			.oBlue(mVGA_B),
			.iVGA_X(mVGA_X),
			.iVGA_Y(mVGA_Y),
			.iVGA_CLK(VGA_CTRL_CLK),
			.action_clk(GAME_CLK[18]),
			//	Control Signals
			.move_right(0),
			.move_jump(0),
			.move_left(0),
			.blk_cordinate({Visual_Object_Coordinate_Array}),
			.blk_length({Object_Size_Array}),
			.bio_cordinate(Life_Coordinate_Array),
			.bio_length(Life_Size_Array),
			.blk_id_all(Object_Type_Array),
			.bio_id_all(Life_Type_Array),
			.char_data({Life_Size[9] ,16'd320,Life_Coordinate[9][15:0]}),
			.iColor_SW(SW[0])
		);
						
						
		

endmodule