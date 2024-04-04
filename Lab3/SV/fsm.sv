module FSM (clk, reset, left, right, y);

   input logic  clk;
   input logic  reset;
   input logic 	left;
   input logic  right;
   
   output logic [5:0] y;

   typedef enum 	logic [3:0] {S0, S1, S2, S3, S4, S5, S6, S7, S8, S9} statetype;
   statetype state, nextstate;

   // state register
   always_ff @(posedge clk)
     if (reset) state <= S0; 
     else       state <= nextstate;
   
   // next state logic
   always_comb
     case (state)
        S0: begin
	        y <= 6'b000000;
          if (left & right) nextstate <= S7;
	        else if (left) nextstate <= S1;
          else if (right) nextstate <= S4;
        end
        S1: begin
	        y <= 6'b001000;	 
          nextstate <= S2; 
        end
        S2: begin
          y <= 6'b011000;
          nextstate <= S3; 
        end
        S3: begin
          y <= 6'b111000;
          nextstate <= S0;
        end
        S4: begin
          y <= 6'b000100;
          nextstate <= S5; 
        end
        S5: begin
          y <= 6'b000110;
          nextstate <= S6; 
        end
        S6: begin
          y <= 6'b000111;
          nextstate <= S0;
        end
        S7: begin
          y <= 6'b001100;
          nextstate <= S8;
        end 
        S8: begin
          y <= 6'b011110;
          nextstate <= S9;
        end
        S9: begin
          y <= 6'b111111;
          nextstate <= S0;
        end
        default: begin
	        y <= 6'b000000;	  	  
	        nextstate <= S0;
        end
      endcase
   
endmodule
