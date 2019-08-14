//-- Alex Grinshpun Apr 2017
//-- Dudy Nov 13 2017
// System-Verilog version Alex Grinshpun May 2018
// coding convention dudy December 2018
// (c) Technion IIT, Department of Electrical Engineering  May 2019 

module	objects_mux	(	
					input		logic	clk,
					input		logic	resetN,
					// smiley 
					input		logic	[7:0] smileyRGB, // two set of inputs per unit
					input		logic	smileyDrawingRequest,
					// add the box here 
					
					input		logic	[7:0] boxRBG, // two set of inputs per unit
					input		logic	boxDrawingRequest,
										
					// background 
					input		logic	[7:0] backGroundRGB, 

					output	logic	[7:0] redOut, // full 24 bits color output
					output	logic	[7:0] greenOut, 
					output	logic	[7:0] blueOut 
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
		if (smileyDrawingRequest == 1'b1 )   
			tmpRGB <= smileyRGB;  //first priority 
		else begin
			if (boxDrawingRequest == 1'b1 )   
				tmpRGB <= boxRBG;  //seconed priority 
				else
				tmpRGB <= backGroundRGB ; // last priority 
		end
	end ; 
end

endmodule


