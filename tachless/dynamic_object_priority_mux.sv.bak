//dynamic_object_priority_mux
//chooses which object to put first depending on the priority list

module	dynamic_object_priority_mux(	
		input	logic	clk,
		input	logic	resetN,
		input	logic [7:0]	backGroundRGB,    //reg backgound RGB
		
		input	logic	[7:0] playerRGB,  			//player RGB
		input	logic	PlayerDrawingRequest,
		
		input	logic	[7:0] missileRGB,  			//missile RGB
		input	logic	MissileDrawingRequest,
		
		input	logic	[7:0] monsterRGB, 			//monster RGB
		input	logic	MonsterDrawingRequest,

		output logic	[7:0] redOut, 			// full 24 bits color output
		output logic	[7:0] greenOut, 
		output logic	[7:0] blueOut 
);



logic [7:0] tmpRGB;


assign redOut	  = {tmpRGB[7:5], {5{tmpRGB[5]}}}; //--  extend LSB to create 10 bits per color  
assign greenOut  = {tmpRGB[4:2], {5{tmpRGB[2]}}};
assign blueOut	  = {tmpRGB[1:0], {6{tmpRGB[0]}}};

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN) begin
			tmpRGB	<= 8'b0;
	end
	else begin
		if (PlayerDrawingRequest == 1'b1 )   
			tmpRGB <= playerRGB;  //first priority 
		else begin
			if (MissileDrawingRequest == 1'b1 )   
				tmpRGB <= missileRGB;  //seconed priority 
			else begin
				if (MonsterDrawingRequest == 1'b1 )   
					tmpRGB <= monsterRGB;  //third priority 
				else
					tmpRGB <= backGroundRGB ; // last priority 
			end
		end
	end ; 
end

endmodule
