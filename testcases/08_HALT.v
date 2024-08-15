
task run_test();
		begin
				$display("====================================================================");
				$display("=========================== Check HALT =============================");
				$display("====================================================================");	

				$display("*** Check HALT when dbg_mode = 0  ***");
				dbg_mode	=	0;	
				test_bench.WRITE(ADDR_TCR, 32'h0000_0001,4'hF);
				test_bench.WRITE(ADDR_THCSR, 32'h0000_0001,4'hF);
				test_bench.READ(ADDR_THCSR,0);
				test_bench.WRITE(ADDR_THCSR, 32'h0000_0001,4'hF);
				test_bench.READ(ADDR_THCSR,0);
				repeat (100) @(posedge clk);
				test_bench.READ(ADDR_THCSR,0);

				test_bench.RST;

				$display("*** Check HALT when dbg_mode = 1 ***");
				dbg_mode	=	1;
				test_bench.READ(ADDR_THCSR,0);
				test_bench.WRITE(ADDR_TCR, 32'h0000_0001,4'hF);
				test_bench.WRITE(ADDR_THCSR, 32'h0000_0001,4'hF);
				repeat (100) @(posedge clk);
				test_bench.READ(ADDR_THCSR,32'h0000_0003);
				repeat (100) @(posedge clk);
				test_bench.WRITE(ADDR_THCSR, 32'h0000_0000,4'hF);
				test_bench.READ(ADDR_THCSR,32'h0000_0000);

				test_bench.RST;
	
				$display("*** Prove the period of each counting number needs to be same when halt and not halt ***");
				dbg_mode	=	1;	
				test_bench.WRITE(ADDR_TCR, 32'h0000_0503,4'hF);			
				repeat (100) @(posedge clk);										
				test_bench.WRITE(ADDR_THCSR, 32'h0000_0001,4'hF);	
				$display("*** Counter is halting  ***");
				// While counter is halting
				test_bench.READ(ADDR_TDR0,3);
				test_bench.READ(ADDR_TDR0,3);
				test_bench.READ(ADDR_TDR0,3);
				test_bench.WRITE(ADDR_THCSR, 32'h0000_0000,4'hF);	
				$display("*** Counter is stop halting  ***");
				repeat (22) @(posedge clk);										
				test_bench.READ(ADDR_TDR0,4);	
				repeat (30) @(posedge clk);		
				test_bench.READ(ADDR_TDR0,5);
				repeat (30) @(posedge clk);
				test_bench.READ(ADDR_TDR0,6);
			
				
				
								
		end	
endtask
