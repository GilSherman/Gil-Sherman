//collision_detector
//detecting collisions

module	collision_detector	(	
		input	logic	clk,
		input	logic	resetN,
		input	logic	drawing_request_1, //number drawing request
		input	logic	drawing_request_2, //smiley drawing request


		output logic collision
);

logic collisionDetected;


always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN) begin
		collisionDetected <=	1'b0;
	end
	else begin
		if(drawing_request_1 && drawing_request_2)
			collisionDetected <=	1'b1;
		else 
			collisionDetected <=	1'b0;
	end 
end

//////////////////////////////
//It is known:
//if you run sinteza, and get 1 err
//EVERYTHING IS OK!
//
//#life_with_tplftx
//////////////////////////////



assign collision = collisionDetected;

endmodule
