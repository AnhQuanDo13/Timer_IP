task run_test();
		begin
				$display("====================================================================");
				$display("=========================== TIMER RESET ============================");
				$display("====================================================================");	

				test_bench.WRITE(ADDR_TDR0,32'hFFFF_FFF0,4'hf); 	
				test_bench.WRITE(ADDR_TDR1,32'hFFFF_FFFF,4'hf);	
				test_bench.WRITE(ADDR_TCR, 32'h0000_0001,4'hf); 	
				repeat (16) @(posedge clk);
				test_bench.READ(ADDR_TISR,1);
				test_bench.RST;

				test_bench.WRITE(ADDR_TCMP0, 32'h0000_000F,4'hf); 	
				test_bench.WRITE(ADDR_TCMP1, 32'h0000_0000,4'hf); 	
				test_bench.WRITE(ADDR_TIER, 32'h0000_0001,4'hf); 	
				test_bench.WRITE(ADDR_TCR, 32'h0000_0001,4'hf);
				test_bench.READ(ADDR_TISR,32'h0);
				repeat (10) @(posedge clk);
				test_bench.READ(ADDR_TISR,32'h1);				
				
								
		end	
endtask
