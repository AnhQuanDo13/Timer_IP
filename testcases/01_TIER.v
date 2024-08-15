task run_test();
		
		begin
				$display("====================================================================");
				$display("================================ TIER ==============================");
				$display("====================================================================");

				$display("*** Reset value check");
				
				test_bench.READ(ADDR_TIER,32'h0000_0000);
		
				$display("*** R/W access");
				test_bench.WRITE(ADDR_TIER,32'h0000_0000,4'hf);
				test_bench.READ(ADDR_TIER,32'h0000_0000);

				test_bench.WRITE(ADDR_TIER,32'hFFFF_FFFF,4'hf);
				test_bench.READ(ADDR_TIER,32'h0000_0001);

				test_bench.WRITE(ADDR_TIER,32'h5555_5555,4'hf);
				test_bench.READ(ADDR_TIER,32'h0000_0001);
				
				test_bench.WRITE(ADDR_TIER,32'hAAAA_AAAA,4'hf);
				test_bench.READ(ADDR_TIER,32'h0000_0000);

				test_bench.WRITE(ADDR_TIER,32'h5AA5_A55A,4'hf);
				test_bench.READ(ADDR_TIER,32'h0000_0000);	
		end			
endtask
