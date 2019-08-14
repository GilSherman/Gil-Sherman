//dynamic_object_priority_mux
//chooses which object to put first depending on the priority list

module	dynamic_object_priority_mux(	
		input	logic	clk,
		input	logic	resetN,
		input	logic [7:0]	backGroundRGB,    //reg backgound RGB
		
		input	logic	[7:0] player,  			//player RGB
		input	logic	PlayerDrawingRequest,
		
		input	logic	[7:0] missile,  			//missile RGB
		input	logic	MissileDrawingRequest,
		
		input	logic	[7:0] monster, 			//monster RGB
		input	logic	MonsterDrawingRequest,

		output logic	[7:0] redOut, 			// full 24 bits color output
		output logic	[7:0] greenOut, 
		output logic	[7:0] blueOut 
);



//fill your code here


endmodule
