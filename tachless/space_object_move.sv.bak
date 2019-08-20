//Tal-Aya Shefi, Gil Yair Sherman
//space_object_move
//detirmines the movement of any type of space- flowting object (not including self-spaceship)


module	space_object_move	(	
 
					input	logic	clk,
					input	logic	resetN,
					input	logic	startOfFrame,        // short pulse every start of frame 30Hz
					
					input logic spawn,					//at posedge move to initial X position
					input logic [2:0] initPositionX, //initial x position 
						
					input	logic	advance, 				//at posedge increace Y by Y_SPEED 
					
					output	logic	[10:0]	object_topLeftX,// output the top left corner 
					output	logic	[10:0]	object_topLeftY
					
);


parameter int INITIAL_X = 50;
parameter int INITIAL_Y = 5;
parameter int Y_SPEED = 10;

const int	MULTIPLIER	=	64;
// multiplier is used to work with integers in high resolution 
// we devide at the end by multiplier which must be 2^n 
const int	x_FRAME_SIZE	=	639 * MULTIPLIER;
const int	y_FRAME_SIZE	=	479 * MULTIPLIER;

int topLeftX_tmp, topLeftY_tmp; // local parameters 


// position calculate 

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN)
	begin
		topLeftX_tmp	<= INITIAL_X * MULTIPLIER;
		topLeftY_tmp	<= INITIAL_Y * MULTIPLIER;
	end
	else begin
		if (startOfFrame == 1'b1 && advance == 1'b1) begin //startOfFrame perform only 30 times per second, advance determines the speed
			topLeftY_tmp  <= topLeftY_tmp + Y_SPEED; 
		end
	end
end

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//get a better (64 times) resolution using integer   
assign 	object_topLeftX = topLeftX_tmp / MULTIPLIER ;   // note:  it must be 2^n 
assign 	object_topLeftY = topLeftY_tmp / MULTIPLIER ;    


endmodule
