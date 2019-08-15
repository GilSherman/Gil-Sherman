//Tal-Aya Shefi, Gil Yair Sherman
//spaceship_move
//detirmines the movement of self-spaceship object (the player itself)

module	spaceship_move	(	
 
					input	logic	clk,
					input	logic	resetN,
					input	logic	startOfFrame,  		// short pulse every start of frame 30Hz 
					input	logic [1:0] X_direction,   //change the direction in X (0-dont move, 1- moveLeft, 2-moveRight)
					
					output	logic	[10:0]	spaceship_topLeftX,// output the top left corner 
					output	logic	[10:0]	spaceship_topLeftY
					
);
  

parameter int INITIAL_X = 64;
parameter int INITIAL_Y = 450;
parameter int X_SPEED = 30;
parameter int DONT_MOVE = 0;

const int	MULTIPLIER	=	64;
// multiplier is used to work with integers in high resolution 
// we devide at the end by multiplier which must be 2^n 
const int	x_FRAME_SIZE	=	639 * MULTIPLIER;
const int	y_FRAME_SIZE	=	479 * MULTIPLIER;


int topLeftX_tmp; // local parameters 
int topLeftY_tmp;


// position calculate 

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
always_ff@(posedge clk or negedge resetN )
begin
	if(!resetN)
	begin
		topLeftX_tmp	<= INITIAL_X * MULTIPLIER;
		topLeftY_tmp	<= INITIAL_Y * MULTIPLIER;
	end
	else begin
		if (startOfFrame == 1'b1) begin // perform only 30 times per second 
			topLeftX_tmp  <= topLeftX_tmp + DONT_MOVE;
		
//select the direction
			if (X_direction == 2'b1)  		//move left 
				if ((topLeftX_tmp >= 64 )) //if left movement is possiable
					topLeftX_tmp  <= topLeftX_tmp - X_SPEED; 
			else begin
				if(X_direction == 2'b10)		//move right
					if ( (topLeftX_tmp <= x_FRAME_SIZE - 64)) //if left movement is possiable
						topLeftX_tmp  <= topLeftX_tmp + X_SPEED;
			end 
		end
	end
end

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//get a better (64 times) resolution using integer   
assign 	spaceship_topLeftX = topLeftX_tmp / MULTIPLIER ;   // note:  it must be 2^n 
assign 	spaceship_topLeftY = topLeftY_tmp / MULTIPLIER ;    


endmodule
