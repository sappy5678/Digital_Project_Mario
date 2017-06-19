module Move_Arrow(
			clk, // Clock
			// 輸出
			Move_Arrow, // 移動方向

			// 輸入
			Collision, // 碰撞 (上/下/左/右)
			Arrow, // 方向箭頭
			Enable_Jump // 有沒有跳的功能
);
	// 輸出
	output reg [3:0]Move_Arrow; // 移動方向

	
	// 輸入
	input [3:0]Collision; // 碰撞 (上/下/左/右)
	input [3:0]Arrow; // 方向箭頭
	input Enable_Jump; // 有沒有跳的功能
	input clk; // Clock
	
	// 參數區
	parameter Jump_Times_Limit = 30;
	reg [10:0]jump_times_limit = Jump_Times_Limit;
	// 變數區
	reg [10:0]jump_times; // 檢查過的次數
	reg [10:0]jump_times_next; // 檢查是否跳過了
	reg jump_enable; // 現在還能不能跳
	reg [3:0]move_limit; // 移動狀態 FSM
	reg [3:0]move_limit_next; // next 移動狀態 FSM
	reg is_jumped = 1'b0; // 看看跳過了沒有
	
	// 計算 能不能跳
	// 新狀態塞進去
	always@(posedge clk)
	begin
		jump_times <= jump_times_next;
	end
	
	// 計算 jump 下一次的狀態
	always@(*)
	begin
		if(jump_enable)
			begin
				jump_times_next <= jump_times + 1'b1;
				is_jumped = 1'b1;
			end
		else if (Collision[2] == 1'b1)
			begin
				jump_times_next <= 2'b0;
				is_jumped = 1'b0;
			end
		else
			jump_times_next <= jump_times;
	end
	
	// 計算 能不能跳
	always@(*)
	begin
		// 能跳
		if((Enable_Jump == 1'b1) && (Arrow[3] == 1'b1) && (jump_times < jump_times_limit)  && (Collision[3] == 1'b0) )
			begin
				jump_enable <=  1'b1;
			end
		// 不能跳
		else
			jump_enable <= 1'b0;
	end
	
	/////////////////////////////////////////
	// 計算 Move_FSM
	// 新狀態塞進去
	always@(posedge clk)
	begin
		move_limit <= move_limit_next;
	end
	
	// 計算 move_limit 下一次的狀態
	always@(*)
	begin
		integer i;
		for(i = 0;i < 3 ;i = i+1)
		begin
			// 檢測上下左右
			if(Collision[i] == 1'b1)
				move_limit_next[i] <= 1'b1;
			else	
				move_limit_next[i] <= 1'b0;
		end
		
		if((Collision[3] == 1'b1) || (jump_enable == 1'b0))
			move_limit_next[3]<= 1'b1;
		else
			move_limit_next[3]<= 1'b0;
	end
	
	// 計算 移動的方向
	always@(*)
	begin
		integer i;
		/*
		for(i = 0;i < 4 ;i = i+1)
		begin
			// 設定上下左右
			if(Arrow[i] == 1'b1 && move_limit[i] != 1'b1)
				Move_Arrow[i] <= 1'b1;
			else
				Move_Arrow[i] <= 1'b0;		
				
		end
		*/
		// 上
		if(Arrow[3] == 1'b1 && move_limit[3] != 1'b1)
				Move_Arrow[3] <= 1'b1;
		else
			Move_Arrow[3] <= 1'b0;
		
		// 下 且掉落
		if((Arrow[2] == 1'b1 && move_limit[2] != 1'b1) || move_limit[2] == 1'b0)
				Move_Arrow[2] <= 1'b1;
		else if(move_limit[2] == 1'b1)
			Move_Arrow[3] <= 1'b1;
		else
			Move_Arrow[2] <=1'b0;
			
		// 左
		if(Arrow[1] == 1'b1 && move_limit[1] != 1'b1)
				Move_Arrow[1] <= 1'b1;
		else
			Move_Arrow[1] <= 1'b0;
		
		// 右
		if(Arrow[0] == 1'b1 && move_limit[0] != 1'b1)
				Move_Arrow[0] <= 1'b1;
		else
			Move_Arrow[0] <= 1'b0;
	end
	
endmodule