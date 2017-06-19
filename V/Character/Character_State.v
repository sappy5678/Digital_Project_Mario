module Character_State(clk,State,Score,Life,Collision,Collision_Type);

	input clk;
	input [3:0]Collision; // 碰撞 (上/下/左/右)
	input [10:0]Collision_Type;   // 碰撞物體的型態

	output reg [10:0]State;
	reg [10:0]next_state;
	output reg [10:0]Score; // 分數
	output reg [10:0]Life; // 生命值
	
	always@(posedge clk)
	State<=next_state;
	
	always@(*)
	begin
		if(Collision_Type == 11'd302 && Collision[2] != 1'b1)  // 撞到怪物死亡
			next_state <= 11'd1;
			
		else if(Collision_Type == 11'd302 && Collision[2] == 1'b1) // 踩到怪物
			Score <= Score + 11'd3;
	
		else if(Collision_Type == 11'd102) // 吃到金幣
			Score <= Score+11'd1;
			
		else
			next_state <= 11'd0; // 存活
	end
	
	
endmodule