//background_priority_mux
//chooses background depending on the state (normal, Ice or BOOM)

module	background_priority_mux	(	
		input	logic	clk,
		input	logic	resetN,
		input	logic [7:0]	BasicBackgroundRGB,  //regular backgound RGB
		
		input	logic	[7:0] IceRGB,  //Ice RGB
		input	logic	IceDrawingRequest,
		
		input	logic	[7:0] BoomRGB, //Boom RGB
		input	logic	BoomDrawingRequest,

		output logic	[7:0] backGroundRGB //the selected background
);



logic [7:0] tmpRGB;


always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN) begin
			tmpRGB	<= 8'b0;
	end
	else begin
		if (BoomDrawingRequest == 1'b1 )   
			tmpRGB <= BoomRGB;  //first priority 
		else begin
			if (IceDrawingRequest == 1'b1 )   
				tmpRGB <= IceRGB;  //seconed priority 
			else begin
				tmpRGB <= backGroundRGB ; // last priority 
			end
		end
	end ; 
end

assign backGroundRGB = tmpRGB;

endmodule
