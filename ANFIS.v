`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:08:27 06/14/2017 
// Design Name: 
// Module Name:    ANFIS 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module anfis(input clk, input ce,input flag_datain, input[15:0] x1,x2,x3,x4,
input[15:0] perm_param, cons_param, input flag_intial_perm, flag_intial_cons,
output  [15:0] y,
output reg  flag_dataout
    );
	 

	 
	 reg[15:0] X [3:0];
	 /*
	 reg[15:0] Xf1 [4:0];
	 reg[15:0] Xf2 [4:0];
	 reg[15:0] Xf3 [4:0];
	 reg[15:0] Xf4 [4:0];
	 reg[15:0] Xf5 [4:0];
	 reg[15:0] Xf6 [4:0];
	 reg[15:0] Xf7 [4:0];
	 reg[15:0] Xf8 [4:0];
	 reg[15:0] Xf9 [4:0];
	 reg[15:0] Xf10 [4:0];
	 reg[15:0] Xf11 [4:0];
	 
	 reg[15:0] Xf [4:0];
	 
	 
	 */
	 
	 wire[15:0] Xf1, Xf2, Xf3, Xf4;
	 
	 wire[15:0] u [7:0];
	 
	 reg[15:0] U1 [7:0];
	 reg[15:0] U2 [7:0];
	 reg[15:0] U3 [7:0];
	 reg[15:0] U [7:0];
	 
	 wire[15:0] w [15:0];
	 
	 reg[15:0] W1 [15:0];
	 reg[15:0] W2 [15:0];
	 reg[15:0] W3 [15:0];
	 reg[15:0] W4 [15:0];
	 reg[15:0] W [15:0];
	 
	 wire[15:0] wb [15:0];
	 
	 reg[15:0] Wb1 [15:0];
	 reg[15:0] Wb [15:0];
	 
	 wire[15:0] fw [15:0];
	 
	 reg  flag_mfin,flag_rulein, flag_normin, flag_consin, flag_sumin;
	 wire flag_mfout,flag_ruleout, flag_normout, flag_consout;
	 
	 
	 reg[3:0] state=0;
	 reg[4:0] count=0;
	 reg[9:0] wrcount;
	 wire[9:0] WC,RC;
	 wire[15:0] test;
	 	//wire[9:0]	rdc, wrc;
		reg WREN, RDEN, reset_fifo=0;
		wire ALMOSTEMPTY, ALMOSTFULL;
	  
	  integer i=0;
	  
	  //reg RDEN_perm,WREN_perm,WE_perm;
	  //reg[15:0] RDADDR_perm=0, WRADDR_perm=0;
	 // wire[15:0] DO_perm;
	 
	 
	  reg[15:0] data_perm1,data_cons1, DI_perm;
	  
	  reg intial_perm, intial_cons;
	  
reg[10:0] clcount=0;
	  
	 always @(posedge clk)begin
	 
	 //clcount<=clcount + 1;
	 wrcount<=WC;
	 //y<=fw[0];
	 //flag_dataout<=flag_mfin;
	 
	 //if(WC>=87)begin
	 //flag_dataout<=1;
	// end
	 
	   case(state)
			
			0:begin        			// parameter data actuation
			   
				
				
				reset_fifo<=1;
			
				if(flag_intial_perm==1)begin

				
				intial_perm<=1;
				data_perm1<=perm_param;
				

				end
				else if(flag_intial_perm==0)begin

				state<=state + 1;
				
				intial_perm<=0;
				end
				
		end
	 
	 
	 
			1:begin
			
				
				
				
					if(flag_intial_cons==1)begin
				
				
						intial_cons<=1;
						data_cons1<=cons_param;
				
				
					end
					else if(flag_intial_cons==0)begin
			
						
						intial_cons<=0;
						
						state<=state + 1;
				
				end
				
			
			end
	 
	 
	
				
		

			2:begin
			
			
					reset_fifo<=0;
					WREN<=1;
					
					if(wrcount==87)begin
					flag_dataout<=1;
					RDEN<=1;
					end
				
					
					/*
					
					X[0]<=X1;
					X[1]<=X2;
					X[2]<=X3;
					X[3]<=X4;
					
					
					
					
					
					
					for (i = 0; i < 8; i = i +1) begin
					U1[i]<=u[i];
					end
					i=0;
					for (i = 0; i < 8; i = i +1) begin
					U2[i]<=U1[i];
					end
					i=0;
					for (i = 0; i < 8; i = i +1) begin
					U[i]<=U2[i];
					end
					i=0;
					//for (i = 0; i < 8; i = i +1) begin
					//U[i]<=U3[i];
					//end
					//i=0;
					
					for (i = 0; i < 16; i = i +1) begin
					W1[i]<=w[i];
					end
					i=0;
					
					for (i = 0; i < 16; i = i +1) begin
					W2[i]<=W1[i];
					end
					i=0;
					for (i = 0; i < 16; i = i +1) begin
					W3[i]<=W2[i];
					end
					i=0;
					for (i = 0; i < 16; i = i +1) begin
					W[i]<=W3[i];
					end
					i=0;
					//for (i = 0; i < 16; i = i +1) begin
					//W[i]<=W4[i];
					//end
					//i=0;
					
					
					
					for (i = 0; i < 16; i = i +1) begin
					Wb[i]<=wb[i];
					end
					i=0;
					//for (i = 0; i < 16; i = i +1) begin
					//Wb[i]<=Wb1[i];
					//end
					
					
					*/
					
					
	
					if(count==0)begin
					if(flag_datain==1)begin
					
					flag_mfin<=1;
					flag_rulein<=1;
					flag_normin<=1;
					flag_consin<=1;
					flag_sumin<=1;
					
					
					state<= state + 1;
					end
				end
			
				count<=count + 1;
				
				if(count==5)begin
				
				count<=0;
				
				end
			
			
			
			
			end
			
			
			3:begin
			
			
			
					if(wrcount==87)begin
					flag_dataout<=1;
					RDEN<=1;
					end
					
					
					
					
					
			
					flag_mfin<=0;
					flag_rulein<=0;
					flag_normin<=0;
					flag_consin<=0;
					flag_sumin<=0;
					state<=2;
					count<=count + 1;
			//flag_mfin<=0;
			//state<=state + 1;
			end
			
			
			
	 
	 
		endcase
	 end
	 
	 
	 /*
	 
	 RAM_perm uRAM_perm (
		.clk(clk), 
		.RDEN(RDEN_perm),
		.WREN(WREN_perm) ,
		.REGCE(0), 
		.WE(WE_perm), 
		.RST(0), 
		.DI(DI_perm), 
		.RDADDR(RDADDR_perm),
		.WRADDR(WRADDR_perm),
		.DO(DO_perm)
	);
	 
	
*/
	 
	 
	 
	 
	 	first_layer fl1 (
		.clk(clk), 
		.flag_datain(flag_mfin), 
		.flag_intial(intial_perm),
		.data_perm(data_perm1),
		.x1(x1), 
		.x2(x2), 
		.x3(x3), 
		.x4(x4), 
		.u1a(u[0]), 
		.u1b(u[1]), 
		.u2a(u[2]), 
		.u2b(u[3]), 
		.u3a(u[4]), 
		.u3b(u[5]), 
		.u4a(u[6]), 
		.u4b(u[7]), 
		.flag_dataout(flag_mfout)
	);
	
	
	
	
	
	
		second_layer sl1 (
		.CLK(clk), 
		.flag_datain(flag_rulein), 
		.u1a(u[0]), 
		.u1b(u[1]), 
		.u2a(u[2]), 
		.u2b(u[3]), 
		.u3a(u[4]), 
		.u3b(u[5]), 
		.u4a(u[6]), 
		.u4b(u[7]), 
		.w1(w[0]), 
		.w2(w[1]), 
		.w3(w[2]), 
		.w4(w[3]), 
		.w5(w[4]), 
		.w6(w[5]), 
		.w7(w[6]), 
		.w8(w[7]), 
		.w9(w[8]), 
		.w10(w[9]), 
		.w11(w[10]), 
		.w12(w[11]), 
		.w13(w[12]), 
		.w14(w[13]), 
		.w15(w[14]), 
		.w16(w[15]), 
		.flag_dataout(flag_ruleout)
	);
	
	
	
	
	
	
	normalize unorm1 (
		.CLK(clk), 
		.flag_normin(flag_normin), 
		.w1(w[0]), 
		.w2(w[1]), 
		.w3(w[2]), 
		.w4(w[3]), 
		.w5(w[4]), 
		.w6(w[5]), 
		.w7(w[6]), 
		.w8(w[7]), 
		.w9(w[8]), 
		.w10(w[9]), 
		.w11(w[10]), 
		.w12(w[11]), 
		.w13(w[12]), 
		.w14(w[13]), 
		.w15(w[14]), 
		.w16(w[15]), 
		.wb1(wb[0]), 
		.wb2(wb[1]), 
		.wb3(wb[2]), 
		.wb4(wb[3]), 
		.wb5(wb[4]), 
		.wb6(wb[5]), 
		.wb7(wb[6]), 
		.wb8(wb[7]), 
		.wb9(wb[8]), 
		.wb10(wb[9]), 
		.wb11(wb[10]), 
		.wb12(wb[11]), 
		.wb13(wb[12]), 
		.wb14(wb[13]), 
		.wb15(wb[14]), 
		.wb16(wb[15]),
		.flag_normout(flag_normout)
	);
	
	
		FIFO_VHDL uuX1 (
		.DI(x1), 
		.clk(clk), 
		.RST(reset_fifo), 
		.RDEN(RDEN), 
		.WREN(WREN), 
		.DO(Xf1), 
		.WRC(WC), 
		.RDC(RC), 
		.test(test),
		.ALMOSTFULL(ALMOSTFULL)
	);
	
	
		FIFO_VHDL uuX2 (
		.DI(x2), 
		.clk(clk), 
		.RST(reset_fifo), 
		.RDEN(RDEN), 
		.WREN(WREN), 
		.DO(Xf2), 
		.WRC(WC), 
		.RDC(RC), 
		.test(test),
		.ALMOSTFULL(ALMOSTFULL)
	);
	
	
	
	
		FIFO_VHDL uuX3 (
		.DI(x3), 
		.clk(clk), 
		.RST(reset_fifo), 
		.RDEN(RDEN), 
		.WREN(WREN), 
		.DO(Xf3), 
		.WRC(WC), 
		.RDC(RC),
		.test(test),		
		.ALMOSTFULL(ALMOSTFULL)
	);
	
	
	
		FIFO_VHDL uuX4 (
		.DI(x4), 
		.clk(clk), 
		.RST(reset_fifo), 
		.RDEN(RDEN), 
		.WREN(WREN), 
		.DO(Xf4), 
		.WRC(WC), 
		.RDC(RC), 
		.test(test),
		.ALMOSTFULL(ALMOSTFULL)
	);
	
	
	
	
	
	/*
	
	FIFO_input uuX1 (
		.clk(clk), 
		.RST(0), 
		.RDEN(RDEN), 
		.WREN(WREN), 
		.DI(X1), 
		.DO(Xf1),
		.RDC(rdc),
		.WRC(wrc),
		.ALMOSTFULL(ALMOSTFULL)
	);
	
	
	FIFO_input uuX2 (
		.clk(clk), 
		.RST(0), 
		.RDEN(RDEN), 
		.WREN(WREN), 
		.DI(X2), 
		.DO(Xf2),
		.RDC(rdc),
		.WRC(wrc),
		.ALMOSTFULL(ALMOSTFULL)
	);
	
	
	FIFO_input uuX3 (
		.clk(clk), 
		.RST(0), 
		.RDEN(RDEN), 
		.WREN(WREN), 
		.DI(X3), 
		.DO(Xf3),
		.RDC(rdc),
		.WRC(wrc),
		.ALMOSTFULL(ALMOSTFULL)
	);
	
	
	FIFO_input uuX4 (
		.clk(clk), 
		.RST(0), 
		.RDEN(RDEN), 
		.WREN(WREN), 
		.DI(X4), 
		.DO(Xf4),
		.RDC(rdc),
		.WRC(wrc),
		.ALMOSTFULL(ALMOSTFULL)
	);
	
	
	*/
	

	
	
	
	
	consequent_layer ucons1 (
		.CLK(clk),
		.X1(Xf1), 
		.X2(Xf2), 
		.X3(Xf3), 
		.X4(Xf4), 
		.data_cons(data_cons1), 
		.flag_consin(flag_consin), 
		.flag_intial_cons(intial_cons), 
		.wb1(wb[0]), 
		.wb2(wb[1]), 
		.wb3(wb[2]), 
		.wb4(wb[3]), 
		.wb5(wb[4]), 
		.wb6(wb[5]), 
		.wb7(wb[6]), 
		.wb8(wb[7]), 
		.wb9(wb[8]), 
		.wb10(wb[9]), 
		.wb11(wb[10]), 
		.wb12(wb[11]), 
		.wb13(wb[12]), 
		.wb14(wb[13]), 
		.wb15(wb[14]), 
		.wb16(wb[15]), 
		.FW1(fw[0]), 
		.FW2(fw[1]), 
		.FW3(fw[2]), 
		.FW4(fw[3]), 
		.FW5(fw[4]), 
		.FW6(fw[5]), 
		.FW7(fw[6]), 
		.FW8(fw[7]), 
		.FW9(fw[8]), 
		.FW10(fw[9]), 
		.FW11(fw[10]), 
		.FW12(fw[11]), 
		.FW13(fw[12]), 
		.FW14(fw[13]), 
		.FW15(fw[14]), 
		.FW16(fw[15]), 
		.flag_consout(flag_consout)
	);
	


sum_layer uut (
		.CLK(clk), 
		.flag_sumin(flag_sumin), 
		.FW1(fw[0]), 
		.FW2(fw[1]), 
		.FW3(fw[2]), 
		.FW4(fw[3]), 
		.FW5(fw[4]), 
		.FW6(fw[5]), 
		.FW7(fw[6]), 
		.FW8(fw[7]), 
		.FW9(fw[8]), 
		.FW10(fw[9]), 
		.FW11(fw[10]), 
		.FW12(fw[11]), 
		.FW13(fw[12]), 
		.FW14(fw[13]), 
		.FW15(fw[14]), 
		.FW16(fw[15]), 
		.Y(y),
		.flag_sumout(flag_sumout)
	);




endmodule
