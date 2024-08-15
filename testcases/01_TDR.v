task run_test();
		
		begin
				$display("====================================================================");
				$display("=============================== TDR0/1 =============================");
				$display("====================================================================");
				
				

				$display("=============== TDR0 ===============");
				$display("*** Reset value check");
				
				test_bench.READ(ADDR_TDR0,32'h0000_0000);
		
				$display("*** R/W access");
				test_bench.WRITE(ADDR_TDR0,32'h0000_0000,4'hf);
				test_bench.READ(ADDR_TDR0,32'h0000_0000);

				test_bench.WRITE(ADDR_TDR0,32'hFFFF_FFFF,4'hf);
				test_bench.READ(ADDR_TDR0,32'hFFFF_FFFF);

				test_bench.WRITE(ADDR_TDR0,32'h5555_5555,4'hf);
				test_bench.READ(ADDR_TDR0,32'h5555_5555);
				
				test_bench.WRITE(ADDR_TDR0,32'hAAAA_AAAA,4'hf);
				test_bench.READ(ADDR_TDR0,32'hAAAA_AAAA);

				test_bench.WRITE(ADDR_TDR0,32'h5AA5_A55A,4'hf);
				test_bench.READ(ADDR_TDR0,32'h5AA5_A55A);		
				$display("====================================================================");		
				
				test_bench.RST;
				
				$display("=============== TDR1 ===============");
				$display("*** Reset value check");
				
				test_bench.READ(ADDR_TDR1,32'h0000_0000);
		
				$display("*** R/W access");
				test_bench.WRITE(ADDR_TDR1,32'h0000_0000,4'hf);
				test_bench.READ(ADDR_TDR1,32'h0000_0000);

				test_bench.WRITE(ADDR_TDR1,32'hFFFF_FFFF,4'hf);
				test_bench.READ(ADDR_TDR1,32'hFFFF_FFFF);

				test_bench.WRITE(ADDR_TDR1,32'h5555_5555,4'hf);
				test_bench.READ(ADDR_TDR1,32'h5555_5555);
				
				test_bench.WRITE(ADDR_TDR1,32'hAAAA_AAAA,4'hf);
				test_bench.READ(ADDR_TDR1,32'hAAAA_AAAA);

				test_bench.WRITE(ADDR_TDR1,32'h5AA5_A55A,4'hf);
				test_bench.READ(ADDR_TDR1,32'h5AA5_A55A);	
				$display("====================================================================");			
		end			
endtask
