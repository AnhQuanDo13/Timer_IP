task run_test();
		begin
				$display("====================================================================");
				$display("========================= Interrupt pending ========================");
				$display("====================================================================");	

				$display("*** Set condition ***");
				test_bench.WRITE(ADDR_TCMP0,32'h0000_00FF,4'hF);
				test_bench.WRITE(ADDR_TCMP1,32'h0000_0000,4'hF);
				test_bench.WRITE(ADDR_TCR,32'h0000_0001,4'hF);
				repeat (253) @(posedge clk);
				$display("*** Check tim_int ***");
						if (tim_int != 1) begin
								$display ("############ PADSSED, tim_int = 0 \n");
						end else begin
								$display ("############ FAILED, tim_int =1 \n");
								cnt_err = cnt_err + 1;
						end
				test_bench.READ(ADDR_TISR,32'h0000_0001);

				test_bench.RST;		
					
				$display("*** Clear condition ***");
				test_bench.WRITE(ADDR_TCMP0,32'h0000_00FF,4'hF);
				test_bench.WRITE(ADDR_TCMP1,32'h0000_0000,4'hF);
				test_bench.WRITE(ADDR_TCR,32'h0000_0001,4'hF);
				repeat (253) @(posedge clk);
				$display("*** Check tim_int ***");
						if (tim_int != 1) begin
								$display ("############ PADSSED, tim_int = 0 \n");
						end else begin
								$display ("############ FAILED, tim_int =1 \n");
								cnt_err = cnt_err + 1;
						end
				test_bench.READ(ADDR_TISR,32'h0000_0001);
				test_bench.WRITE(ADDR_TISR,32'h0000_0000,4'hF);
				test_bench.READ(ADDR_TISR,32'h0000_0001);
				test_bench.WRITE(ADDR_TISR,32'h0000_0001,4'hF);
				test_bench.READ(ADDR_TISR,32'h0000_0000);
				
				test_bench.RST;		
								
				$display("*** Manual condition ***");
				test_bench.WRITE(ADDR_TDR0,32'hFFFF_FFFF,4'hF);
				test_bench.WRITE(ADDR_TDR1,32'hFFFF_FFFF,4'hF);
				test_bench.WRITE(ADDR_TCR,32'h0000_0001,4'hF);
				$display("*** Check tim_int ***");
						if (tim_int != 1) begin
								$display ("############ PADSSED, tim_int = 0 \n");
						end else begin
								$display ("############ FAILED, tim_int =1 \n");
								cnt_err = cnt_err + 1;
						end
				test_bench.READ(ADDR_TISR,32'h0000_0001);
				
				test_bench.RST;
				
				$display("====================================================================");
				$display("========================= Interrupt enable =========================");
				$display("====================================================================");	
				
				$display("*** Set condition ***");
				test_bench.WRITE(ADDR_TCMP0,32'h0000_00FF,4'hF);
				test_bench.WRITE(ADDR_TCMP1,32'h0000_0000,4'hF);
				test_bench.WRITE(ADDR_TIER,32'h0000_0001,4'hF);
				test_bench.WRITE(ADDR_TCR,32'h0000_0001,4'hF);
				wait (tim_int == 1);
				test_bench.READ(ADDR_TISR,32'h0000_0001);

				test_bench.RST;		
				
				$display("*** Clear condition ***");
				test_bench.WRITE(ADDR_TCMP0,32'h0000_00FF,4'hF);
				test_bench.WRITE(ADDR_TCMP1,32'h0000_0000,4'hF);
				test_bench.WRITE(ADDR_TIER,32'h0000_0001,4'hF);
				test_bench.WRITE(ADDR_TCR,32'h0000_0001,4'hF);
				wait (tim_int == 1);
				test_bench.READ(ADDR_TISR,32'h0000_0001);
				test_bench.WRITE(ADDR_TISR,32'h0000_0000,4'hF);
				test_bench.READ(ADDR_TISR,32'h0000_0001);
				test_bench.WRITE(ADDR_TISR,32'h0000_0001,4'hF);
				test_bench.READ(ADDR_TISR,32'h0000_0000);
				$display("*** Check tim_int ***");
						if (tim_int == 0) begin
								$display ("############ PADSSED, tim_int = 0 \n");
						end else begin
								$display ("############ FAILED, tim_int =1 \n");
								cnt_err = cnt_err + 1;
						end
				
				test_bench.RST;		
								
				$display("*** Manual condition ***");
				test_bench.WRITE(ADDR_TDR0,32'hFFFF_FFFF,4'hF);
				test_bench.WRITE(ADDR_TDR1,32'hFFFF_FFFF,4'hF);
				test_bench.WRITE(ADDR_TIER,32'h0000_0001,4'hF);
				test_bench.WRITE(ADDR_TCR,32'h0000_0001,4'hF);
								$display("*** Check tim_int ***");
						if (tim_int == 1) begin
								$display ("############ PADSSED, tim_int = 1 \n");
						end else begin
								$display ("############ FAILED, tim_int = 0 \n");
								cnt_err = cnt_err + 1;
						end
				test_bench.READ(ADDR_TISR,32'h0000_0001);
				
				test_bench.RST;		
								
				$display("*** Mask condition ***");
				test_bench.WRITE(ADDR_TCMP0,32'h0000_00FF,4'hF);
				test_bench.WRITE(ADDR_TCMP1,32'h0000_0000,4'hF);
				test_bench.WRITE(ADDR_TIER,32'h0000_0001,4'hF);
				test_bench.WRITE(ADDR_TCR,32'h0000_0001,4'hF);
				wait (tim_int == 1);
				test_bench.READ(ADDR_TISR,32'h0000_0001);
				test_bench.WRITE(ADDR_TIER,32'h0000_0000,4'hF);
				test_bench.READ(ADDR_TIER,32'h0);
								$display("*** Check tim_int ***");
						if (tim_int != 1) begin
								$display ("############ PADSSED, tim_int = 0 \n");
						end else begin
								$display ("############ FAILED, tim_int =1 \n");
								cnt_err = cnt_err + 1;
						end
				test_bench.READ(ADDR_TISR,32'h0000_0001);
			
				test_bench.RST;
				$display("====================================================================");
				$display("============= Once asserted, interrupt must be kept ================");
				$display("====================================================================");	
				
				test_bench.WRITE(ADDR_TCMP0,32'h0000_00FF,4'hF);
				test_bench.WRITE(ADDR_TCMP1,32'h0000_0000,4'hF);
				test_bench.WRITE(ADDR_TIER,32'h0000_0001,4'hF);
				test_bench.WRITE(ADDR_TCR,32'h0000_0001,4'hF);
				wait (tim_int == 1);
				test_bench.READ(ADDR_TISR,32'h0000_0001);

				test_bench.WRITE(ADDR_TCR,32'h0000_0000,4'hF);
								$display("*** Check tim_int ***");
						if (tim_int == 1) begin
								$display ("############ PADSSED, tim_int = 1 \n");
						end else begin
								$display ("############ FAILED, tim_int = 0 \n");
								cnt_err = cnt_err + 1;
						end
				test_bench.READ(ADDR_TISR,32'h0000_0001);
				
				test_bench.RST;	

				test_bench.RST;
				$display("====================================================================");
				$display("============= Interrupt trigger again when int_en = 1 ==============");
				$display("====================================================================");	
				
				test_bench.WRITE(ADDR_TCMP0,32'h0000_00FF,4'hF);
				test_bench.WRITE(ADDR_TCMP1,32'h0000_0000,4'hF);
				test_bench.WRITE(ADDR_TIER,32'h0000_0001,4'hF);
				test_bench.WRITE(ADDR_TCR,32'h0000_0001,4'hF);
				repeat (300) @(posedge clk);

				test_bench.WRITE(ADDR_TIER,32'h0000_0000,4'hF);
				@(posedge clk);
								$display("*** Check tim_int ***");
						if (tim_int == 0) begin
								$display ("############ PADSSED, tim_int = 0 \n");
						end else begin
								$display ("############ FAILED, tim_int = 1 \n");
								cnt_err = cnt_err + 1;
						end
				repeat (300) @(posedge clk);
				test_bench.WRITE(ADDR_TIER,32'h0000_0001,4'hF);
				@(posedge clk);
								$display("*** Check tim_int ***");
						if (tim_int == 1) begin
								$display ("############ PADSSED, tim_int = 1 \n");
						end else begin
								$display ("############ FAILED, tim_int = 0 \n");
								cnt_err = cnt_err + 1;
						end
				
				test_bench.RST;
								
				$display("*** Manual condition ***");
				test_bench.WRITE(ADDR_TDR0,32'hFFFF_FFF0,4'hF);
				test_bench.WRITE(ADDR_TDR1,32'hFFFF_FFFF,4'hF);
				test_bench.WRITE(ADDR_TCMP0,32'hFFFF_FFFF,4'hF);
				test_bench.WRITE(ADDR_TCMP1,32'hFFFF_FFFF,4'hF);
				test_bench.WRITE(ADDR_TIER,32'hFFFF_FFFF,4'hF);
				test_bench.WRITE(ADDR_TCR,32'h0000_0001,4'hF);
				#100;
				test_bench.READ(ADDR_TISR,32'h0000_0001);

				test_bench.RST;

				$display("*** Set condition ***");
				test_bench.WRITE(ADDR_TCMP0,32'h0000_00FF,4'hF);
				test_bench.WRITE(ADDR_TCMP1,32'h0000_0000,4'hF);
				test_bench.WRITE(ADDR_TDR0,32'hFFFF_FFF0,4'hF);
				test_bench.WRITE(ADDR_TDR1,32'hFFFF_FFFF,4'hF);
				test_bench.WRITE(ADDR_TIER,32'h0000_0001,4'hF);
				test_bench.WRITE(ADDR_TCR,32'h0000_0001,4'hF);
				#1000;	
			
								
		end	
endtask
