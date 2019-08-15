//enemy_generator
//basicly, a decoder
//generates a new enemy at posegde of "generateNew"
//each new enemy will get a new random starting point, and a random type

module enemy_generator(	
		input	logic	clk,
		input	logic	resetN,
	
		input	logic	generateNew, 				//generates a new enemy at posegde
		input	logic	[3:0] randomType,     	//creates this type of monster
		input	logic	[3:0] randomLocation,   //determines the starting point of the enemy
	
	//for bigger project
		input logic [4:0] enemyInstanceAvailable,  //Id of a "dead" enemyInstance 
																  //that can be created
	
	
	//for bigger project
		output logic generateInstance,		//enables an istance display
		output logic [3:0] newType, 			//connection to each instance
		output logic [10:0] newLocation		//connection to each instance
		
);

		

	
assign generateInstance = generateNew;
assign newType = 4'b1;
assign newLocation = 11'b1000000;

endmodule
