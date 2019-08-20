//ALL_TIME
//controls all time related commands

module	ALL_TIME	(	
		input	logic	clk,
		input	logic	resetN,
		input	logic	run,      //game is running
		input logic turbo,    //sets the game to turbo mode
		input	logic	Ice,      //freeze enemy advancment and spawn
		
		output logic spawn,   //the rate of creation of new enemies
		output logic advance, //the speed of advancment
		output logic lvl      //current lvl of the game
);



/////dont forget ice not included


parameter int INITIAL_SPAWN_RATE = 512;
parameter int INITIAL_ADVANCE_SPEED	=	64; 
/////////////////////////////////////////////////
//consider if needs to be more generic' like fast-clock and slow-clock
/////////////////////////////////////////////////

parameter int TURBO_MULTIPLIER = 1/4;

int spawn_counter, advance_counter;
int tmp_spawn_rate, tmp_advance_speed;

always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN)	begin
			tmp_spawn_rate		<= INITIAL_SPAWN_RATE;
			tmp_advance_speed <= INITIAL_ADVANCE_SPEED;
			spawn_counter		<= 10'b0;
			advance_counter	<= 10'b0;
			spawn		<= 1'b0;
			advance	<= 1'b0;
	end
	else
	begin
	
///////for beginning, and because im lazy
//		if(run) begin
		if(run || 1'b1) begin
		
//			if(turbo) begin
			if(turbo && 1'b0) begin
			
				tmp_spawn_rate <= tmp_spawn_rate * TURBO_MULTIPLIER;
				tmp_advance_speed <= tmp_advance_speed * TURBO_MULTIPLIER;
			end
			else begin
				tmp_spawn_rate		<= INITIAL_SPAWN_RATE;
				tmp_advance_speed <= INITIAL_ADVANCE_SPEED;
///////////////////////////////////////////////////////
//think if there is a better way to do this, without those 2 lines doplicated
//////////////////////////////////////////////////////
			end
			if (spawn_counter >= tmp_spawn_rate) begin
					spawn_counter  <= 10'b0;
					spawn				<= 1'b1;
			end
			if (advance_counter >= tmp_advance_speed) begin
					advance_counter <= 10'b0;
					advance				<= 1'b1;
					
/////////////////////////////////////////
//so, i decided to make the reading a little bit better,
//from now on' there are going to be stories =)
// im on the flight now, (super tired)
// every member of the family is in a different row (exept noam ans mom, daa)
// my mom just sent me a tomato soup ><
// so now im sitting in an airplan' coding time, with a hot coffee-like cup of soup
// quite enjoying myself  =)
///// p.s. tons of spelling errors
/////////////////////////////////////////
					
					
			end
			else begin
					spawn_counter 	 <= spawn_counter + 1'b1;
					advance_counter <= advance_counter + 1'b1;
					spawn			<= 1'b0;
					advance		<= 1'b0;
			end
		end
	end;
end

/////i dont think you need an assign here, according to prescalar.sv
/////gotta check that



//////////////////////////////////////////
//kill me i dont understand what is wrong with this constant or whar is hurting to it in his life. for real why it do such problems to everybody evertime? y b "declared more than once" ? Y ?!
//////////////////////////////////////////

endmodule
