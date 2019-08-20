//game_score
//keeps the score for each game

module	game_score	(	
		input	logic	clk,
		input	logic	resetN,
		input	logic	collisionDetected, //when a collision was detected, adds 
												 //the given amount to the score
		input	logic	type_or_score, //YET TO BE DECIDED, HAVE TO CONSIDER WHAT WOULD BE DONE IN BIGGER NUMBERS>>> MOSTLY HOW WILLL THE COLLISION DETECTOR WIL MANAGE...

		output logic	drawingRequest,   // indicates pixel inside the bracket
		//output logic	[7:0]	 RGBout 		
		
		output logic	num_of_Thousands,
		output logic	num_of_hundreds,
		output logic	num_of_tens,
		output logic	num_of_units
		
		////   ^^^ CHanGE THE NAMES BECAUSE THEY ARE HORRIBLE
		/// this is in case of the method down below (the next green thing)
);
/////// (yes, this one)
////// probably should split it into several parts, one fot the score
////// one for the background of the score place
////// and one for each number... 
///////// (also should think how many numers are needed for the total score)
//////// and also a mux that decides what to transfer next 
///////// a priority mux' for the leters and the back, then to be trransfered 
///////// to the bigger mus of show.


/////////also, think about the booomm... mayby just a non stoping all screen kinda
///////// thing that creates a collision with everything... one at a time


int score;

int num_of_Thousands_TMP, num_of_hundreds_TMP;
int num_of_tens_TMP, num_of_units_TMP;

always_ff@(posedge clk or negedge resetN)
begin	
	if(!resetN) begin
		score = 0;
	end
	else begin
	
	/// assuming type_or_score is really just pure added_score
		if(collisionDetected)
			score <=	score + type_or_score;
			
			//// think if there is a better way to do that math... 
			///// this method is a lot of transistors.. it is not a KFULA of 2
			
			num_of_Thousands_TMP <= score / 1000 ;
			num_of_hundreds_TMP <= score % 1000 / 100 ;
			num_of_tens_TMP <= score % 100 / 10;
			num_of_units_TMP <= score % 10;
	end 
end

assign drawingRequest = 1'b1; // always displaying the score.

assign num_of_Thousands = num_of_Thousands_TMP;
assign num_of_hundreds = num_of_hundreds_TMP;
assign num_of_tens = num_of_tens_TMP;
assign num_of_units = num_of_units_TMP;

endmodule
