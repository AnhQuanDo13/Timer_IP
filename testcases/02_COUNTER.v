task run_test();
		
		begin
				$display("====================================================================");
				$display("========================= Counting behavior ========================");
				$display("====================================================================");

				$display("*** Check counting at boundary of TDR0/1 is correct ***");
				test_bench.WRITE(ADDR_TDR0, 32'hffff_ff00,4'hf);
				test_bench.WRITE(ADDR_TDR1, 32'h0000_0000,4'hf);
				test_bench.WRITE(ADDR_TCR, 32'h0000_0001,4'hf);
				repeat (252) @(posedge clk);
				test_bench.READ(ADDR_TDR0,32'hFFFF_FFFF);
				test_bench.READ(ADDR_TDR1,32'h0000_0001);
				
				test_bench.RST;
				
				$display("*** Check counting at boundary of TDR0/1 is correct ***");				
				test_bench.WRITE(ADDR_TDR0, 32'hffff_ff00,4'hf);
				test_bench.WRITE(ADDR_TDR1, 32'hFFFF_FFFF,4'hf);
				test_bench.WRITE(ADDR_TCR, 32'h0000_0001,4'hf);
				repeat (252) @(posedge clk);
				test_bench.READ(ADDR_TDR0,32'hFFFF_FFFF); 
				test_bench.READ(ADDR_TDR1,32'h0000_0000);
			
				test_bench.RST;
				
				$display("====================================================================");
				$display("=============== Update TDR0/TDR1 when timer is working =============");
				$display("====================================================================");
				
				test_bench.WRITE(ADDR_TCR, 32'h0000_0001,4'hf); 
				test_bench.WRITE(ADDR_TDR0, 32'hffff_fff0,4'hf); 
				test_bench.WRITE(ADDR_TDR1, 32'hffff_ffff,4'hf);
				test_bench.WRITE(ADDR_TIER, 32'h0000_0001,4'hf);	
				repeat(13) @(posedge clk);
								$display("*** Check tim_int ***");
						if (tim_int == 1) begin
								$display ("############ PADSSED, tim_int = 1 \n");
						end else begin
								$display ("############ FAILED, tim_int =0 \n");
								cnt_err = cnt_err + 1;
						end
				
				test_bench.RST;
				
				$display("====================================================================");
				$display("==================== Timer is disabled and resumed =================");
				$display("====================================================================");
				
				$display("*** When timer_en changed from 1->0. Counter does not count ***");
				test_bench.WRITE(ADDR_TDR0, 32'h1234_5678,4'hf); 	
				test_bench.WRITE(ADDR_TDR1, 32'hBDBD_FAFA,4'hf);
				test_bench.WRITE(ADDR_TCR, 32'h0000_0001,4'hf); 
				repeat (10) @(posedge clk);	
				test_bench.WRITE(ADDR_TCR, 32'h0000_0000,4'hf);
				test_bench.READ(ADDR_TDR0,32'h0);
				test_bench.READ(ADDR_TDR1,32'h0);
				
				test_bench.WRITE(ADDR_TCR, 32'h0000_0800,4'hf); 
				test_bench.WRITE(ADDR_TDR0, 32'h0,4'hf); 
				test_bench.WRITE(ADDR_TDR1, 32'h0,4'hf);		
				test_bench.WRITE(ADDR_TCR, 32'h0000_0803,4'hf); 
				repeat (254) @(posedge clk);	
				test_bench.READ(ADDR_TDR0,32'h1);
					
				test_bench.RST;
				$display("====================================================================");
				$display("====================== Counter continue counting ===================");
				$display("====================================================================");
				
				$display("*** When interrupt occurs ***");
				test_bench.WRITE(ADDR_TCMP0, 32'h0000_00FF,4'hf); 
				test_bench.WRITE(ADDR_TCMP1, 32'h0000_0000,4'hf); 
				test_bench.WRITE(ADDR_TIER, 32'h0000_0001,4'hf); 
				test_bench.WRITE(ADDR_TCR, 32'h0000_0001,4'hf); 
				wait (tim_int == 1); 
				test_bench.READ(ADDR_TDR0,32'h102); 
				test_bench.READ(ADDR_TDR1,32'h0);
		
				test_bench.RST;
				
				$display("*** When overflow ***");
				test_bench.WRITE(ADDR_TDR0, 32'hFFFF_FF00,4'hf); 
				test_bench.WRITE(ADDR_TDR1, 32'hFFFF_FFFF,4'hf); 
				test_bench.WRITE(ADDR_TCR, 32'h0000_0001,4'hf); 
				repeat (252) @(posedge clk); 
				test_bench.READ(ADDR_TDR0,32'hFFFF_FFFF); 
				test_bench.READ(ADDR_TDR1,32'h0);
				test_bench.READ(ADDR_TDR0,32'h7); 
				test_bench.READ(ADDR_TDR1,32'h0);
									
		end		


endtask
