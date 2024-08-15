task run_test();
		
		begin
				$display("====================================================================");
				$display("=========================== One-hot check ==========================");
				$display("====================================================================");
				
				test_bench.WRITE(ADDR_TCR, 32'h1010_1010,4'hF);				
				test_bench.WRITE(ADDR_TDR0, 32'h1111_1111,4'hF);
				test_bench.WRITE(ADDR_TDR1, 32'h2222_2222,4'hF);
				test_bench.WRITE(ADDR_TCMP0, 32'h3333_3333,4'hF);
				test_bench.WRITE(ADDR_TCMP1, 32'h4444_4444,4'hF);
				test_bench.WRITE(ADDR_TIER, 32'h5555_5555,4'hF);				
				test_bench.WRITE(ADDR_TISR, 32'h6666_6666,4'hF);
				test_bench.WRITE(ADDR_THCSR, 32'h7777_7777,4'hF);	

				test_bench.READ(ADDR_TCR,32'h0000_0000);
				test_bench.READ(ADDR_TDR0,32'h1111_1111);
				test_bench.READ(ADDR_TDR1,32'h2222_2222);
				test_bench.READ(ADDR_TCMP0,32'h3333_3333);							
				test_bench.READ(ADDR_TCMP1,32'h4444_4444);
				test_bench.READ(ADDR_TIER,32'h0000_0001);
				test_bench.READ(ADDR_TISR,32'h0000_0000);
				test_bench.READ(ADDR_THCSR,32'h0000_0000);			
					
		end			
endtask
