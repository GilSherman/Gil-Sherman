//game_controller
//detecting collisions

module	game_controller	(	
					input	logic	clk,
					input	logic	resetN,
					input	logic	drawing_request_1, 
					input	logic	drawing_request_2,

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


assign collision = collisionDetected;

endmodule