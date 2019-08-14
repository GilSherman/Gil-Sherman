//-- Alex Grinshpun Apr 2017
//-- Dudy Nov 13 2017
// System-Verilog version Alex Grinshpun May 2018
// coding convention dudy December 2018
// (c) Technion IIT, Department of Electrical Engineering 2019 



module	smileyBitMap	(	
					input	logic	clk,
					input	logic	resetN,
					input logic	[10:0] offsetX,// offset from top left  position 
					input logic	[10:0] offsetY,
					input	logic	InsideRectangle, //input that the pixel is within a bracket 

					output	logic	drawingRequest, //output that the pixel should be dispalyed 
					output	logic	[7:0] RGBout  //rgb value from the bitmap 
);
// generating a smiley bitmap 

localparam  int OBJECT_WIDTH_X = 26;
localparam  int OBJECT_HEIGHT_Y = 26;

localparam logic [7:0] TRANSPARENT_ENCODING = 8'hFF ;// RGB value in the bitmap representing a transparent pixel 

logic [0:OBJECT_HEIGHT_Y-1] [0:OBJECT_WIDTH_X-1] [7:0] object_colors = {
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF},
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD5, 8'hD0, 8'hD0, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD0, 8'hD0, 8'hD5, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF},
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD5, 8'hD0, 8'hD4, 8'h64, 8'h8C, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h64, 8'hAC, 8'hD0, 8'hD5, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF}, 
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD0, 8'hD4, 8'hD9, 8'h8C, 8'hD9, 8'hFF, 8'hD9, 8'hD9, 8'hD9, 8'hD9, 8'hD9, 8'hFF, 8'hD5, 8'hD5, 8'hD4, 8'hD0, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF}, 
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD0, 8'hD4, 8'hD9, 8'hD9, 8'hFF, 8'hD9, 8'hD9, 8'hD9, 8'hD9, 8'hD9, 8'hD9, 8'hD9, 8'hD9, 8'hD9, 8'hD9, 8'hD9, 8'hD9, 8'hD0, 8'hFF, 8'hFF, 8'hFF, 8'hFF}, 
{8'hFF, 8'hFF, 8'hFF, 8'hD0, 8'hD4, 8'hD9, 8'hD9, 8'hD5, 8'hD4, 8'h88, 8'h6C, 8'hD4, 8'hD9, 8'hD9, 8'hD9, 8'hD9, 8'hB0, 8'hD5, 8'hD9, 8'hD9, 8'hD9, 8'hD9, 8'hCC, 8'hFF, 8'hFF, 8'hFF}, 
{8'hFF, 8'hFF, 8'hD0, 8'hD4, 8'hD9, 8'hD5, 8'hD4, 8'h40, 8'h04, 8'h9B, 8'h9B, 8'h96, 8'hD4, 8'hD9, 8'hD9, 8'hB1, 8'h9B, 8'h72, 8'h24, 8'h8C, 8'hD9, 8'hD9, 8'hD4, 8'hD0, 8'hFF, 8'hFF}, 
{8'hFF, 8'hB6, 8'hD0, 8'hD9, 8'hD5, 8'hD9, 8'h40, 8'h29, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h92, 8'hD9, 8'hD4, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h24, 8'h8C, 8'hD5, 8'hD9, 8'hD0, 8'hD5, 8'hFF}, 
{8'hFF, 8'hD0, 8'hD4, 8'hD9, 8'hB0, 8'h44, 8'h44, 8'hFF, 8'h96, 8'h0A, 8'h92, 8'hFF, 8'hFF, 8'hD0, 8'hB6, 8'hFF, 8'h4E, 8'h0A, 8'hFF, 8'hFF, 8'h44, 8'hB4, 8'hD8, 8'hD4, 8'hD0, 8'hFF}, 
{8'hFF, 8'hD0, 8'hD4, 8'hD8, 8'hD8, 8'hD0, 8'h71, 8'hBA, 8'hFF, 8'h00, 8'h32, 8'hFF, 8'hFF, 8'hD4, 8'hBA, 8'hFF, 8'h68, 8'h2D, 8'h72, 8'hFF, 8'hD0, 8'hD8, 8'hD4, 8'hD4, 8'hD0, 8'hFF}, 
{8'hD5, 8'hD0, 8'hD4, 8'hD4, 8'hD4, 8'hD0, 8'hB6, 8'h76, 8'h00, 8'h00, 8'h56, 8'hFF, 8'hFF, 8'hD4, 8'hBA, 8'h56, 8'h00, 8'h72, 8'h52, 8'hFF, 8'hD0, 8'hD4, 8'hD4, 8'hD4, 8'hD0, 8'hD5}, 
{8'hD5, 8'hD0, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hB6, 8'h9B, 8'h32, 8'h52, 8'h52, 8'hFF, 8'hFF, 8'hD4, 8'hD5, 8'h76, 8'h2D, 8'h76, 8'h96, 8'hFF, 8'hD0, 8'hD4, 8'hD4, 8'hD4, 8'hD0, 8'hD5}, 
{8'hD4, 8'hD0, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD0, 8'hD9, 8'h72, 8'h4E, 8'hFF, 8'hFF, 8'h92, 8'hD9, 8'hD8, 8'h9B, 8'h72, 8'h72, 8'hFF, 8'hB0, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD0, 8'hD4}, 
{8'hD4, 8'hD0, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD0, 8'hD0, 8'hBA, 8'h9B, 8'h76, 8'hD4, 8'hD9, 8'hD9, 8'hD4, 8'hB6, 8'hB6, 8'hD0, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD0, 8'hD5}, 
{8'hD5, 8'hD0, 8'hD4, 8'hD4, 8'hD4, 8'hD0, 8'hD0, 8'hD0, 8'hD0, 8'hD4, 8'hD4, 8'hD4, 8'hD9, 8'hD9, 8'hD8, 8'hD8, 8'hD8, 8'hD0, 8'hD0, 8'hD0, 8'hD0, 8'hD4, 8'hD4, 8'hD4, 8'hD0, 8'hD5}, 
{8'hD5, 8'hD0, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD0, 8'hD0, 8'hD0, 8'hD8, 8'hD8, 8'hD8, 8'hD8, 8'hD8, 8'hD8, 8'hD8, 8'hD8, 8'hD8, 8'hD0, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD0, 8'hD5}, 
{8'hFE, 8'hD0, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD8, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD0, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD0, 8'hFF}, 
{8'hFE, 8'hD0, 8'hD0, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD8, 8'hD4, 8'hD0, 8'hD0, 8'hD0, 8'hD0, 8'hD0, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD0, 8'hFF}, 
{8'hFE, 8'hD5, 8'hD0, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD8, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD0, 8'hD5, 8'hFF}, 
{8'hFE, 8'hFE, 8'hD0, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD0, 8'hD0, 8'hFF, 8'hFF}, 
{8'hFE, 8'hFE, 8'hFE, 8'hD0, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD0, 8'hFF, 8'hFF, 8'hFF}, 
{8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hD0, 8'hD8, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD0, 8'hFF, 8'hFF, 8'hFF, 8'hFF}, 
{8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hD0, 8'hD9, 8'hD9, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD0, 8'hD0, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF}, 
{8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hD5, 8'hD4, 8'hD9, 8'hD9, 8'hD9, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD0, 8'hD0, 8'hD5, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF}, 
{8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hD5, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD4, 8'hD0, 8'hD0, 8'hD5, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF}, 
{8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF}
};

// pipeline (ff) to get the pixel color from the array 	 

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN) begin
		RGBout <=	8'h00;
	end
	else begin
		if (InsideRectangle == 1'b1 )  // inside an external bracket 
			RGBout <= object_colors[offsetY][offsetX];	//get RGB from the colors table  
		else 
			RGBout <= TRANSPARENT_ENCODING ; // force color to transparent so it will not be displayed 
	end 
end

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
// decide if to draw the pixel or not 
assign drawingRequest = (RGBout != TRANSPARENT_ENCODING ) ? 1'b1 : 1'b0 ; // get optional transparent command from the bitmpap   

endmodule