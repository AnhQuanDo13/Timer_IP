task run_test();
		
		begin
				$display("====================================================================");
				$display("======================== Reserved registers ========================");
				$display("====================================================================");
				
				test_bench.WRITE(12'hFFF,32'h1234_5678,4'hf);
				test_bench.READ(12'hFFF,32'h0000_0000);
				
				test_bench.WRITE(12'hFFC,32'h1234_5678,4'hf);
				test_bench.READ(12'hFFC,32'h0000_0000);
				
				test_bench.WRITE(12'h020,32'h1234_5678,4'hf);
				test_bench.READ(12'hFFF,32'h0000_0000);				
					
		end			
endtask
