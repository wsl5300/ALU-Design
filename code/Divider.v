`timescale 1ns/1ns
module Divider( clk, dataA, dataB, Signal, dataOut, reset );
input clk ;
input reset ;
input [31:0] dataA ;
input [31:0] dataB ;
input [5:0] Signal ;
output [63:0] dataOut ;

reg [63:0] temp ;
reg [6:0] counter = 0 ;
reg [63:0] REM ;


parameter DIVU = 6'b011011;
parameter OUT = 6'b111111;


always@( posedge clk or reset )
begin
        if ( reset )
                temp = 32'b0 ;

        else
        begin
		case ( Signal )
  		DIVU:	// ===========DIVU============
		begin
			if ( counter == 0 )
			begin
				REM[63:32] = dataB ;  // 被除數
				counter++ ;
			end

			else
			begin
				REM = REM << 1 ;	// 先左移1
				if ( counter <= 32 )
				begin

					// 檢查該bit的被除數 > 除數
					REM[63:32] = REM[63:32] - dataA ;

					if ( REM[63:32] >= 0 )
						REM[31:31] = 1 ;
					else
					begin
						REM[63:32] = REM[63:32] + dataA ;
						REM[31:31] = 0 ;

					end

	
					REM = REM << 1 ;
					counter++ ;
				end

				else 
					counter = 0 ;

			end 

		end
		
		

  		OUT:	// ============OUT============
		begin
			 temp[63:32] = dataA / dataB ;
			 temp[31:0]= dataA % dataB ;
			 #330 ;
		end


		endcase


        end

end
assign dataOut = temp ;


endmodule