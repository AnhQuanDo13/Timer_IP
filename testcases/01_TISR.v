task run_test();
		
		begin
				$display("====================================================================");
				$display("================================ TISR ==============================");
				$display("====================================================================");
				
				$display("*** Reset value check");
				test_bench.READ(ADDR_TISR,32'h0000_0000);
		
				$display("*** R/W access");
				test_bench.WRITE(ADDR_TISR,32'h0000_0001,4'hf);
				test_bench.READ(ADDR_TISR,32'h0000_0000);

				test_bench.WRITE(ADDR_TISR,32'h0000_0000,4'hf);
				test_bench.READ(ADDR_TISR,32'h0000_0000);
				
				test_bench.WRITE(ADDR_TISR,32'hFFFF_FFFF,4'hf);
				test_bench.READ(ADDR_TISR,32'h0000_0000);

				test_bench.WRITE(ADDR_TISR,32'h5555_5555,4'hf);
				test_bench.READ(ADDR_TISR,32'h0000_0000);
				
				test_bench.WRITE(ADDR_TISR,32'hAAAA_AAAA,4'hf);
				test_bench.READ(ADDR_TISR,32'h0000_0000);

				test_bench.WRITE(ADDR_TISR,32'h5AA5_A55A,4'hf);
				test_bench.READ(ADDR_TISR,32'h0000_0000);
			
		end			
endtask
