task run_test();
		
		begin
				$display("====================================================================");
				$display("================================ TCR ===============================");
				$display("====================================================================");
				
				$display("=============== TCR ===============");
				$display("*** Reset value check");
				test_bench.READ(ADDR_TCR,32'h0000_0100);
		
				$display("*** R/W access");
				test_bench.WRITE(ADDR_TCR,32'h0000_0000,4'hf);
				test_bench.READ(ADDR_TCR,32'h0000_0000);

				test_bench.WRITE(ADDR_TCR,32'hFFFF_F2FF,4'hf);
				test_bench.READ(ADDR_TCR,32'h0000_0203);

				test_bench.WRITE(ADDR_TCR,32'h3333_3333,4'hf);
				test_bench.READ(ADDR_TCR,32'h0000_0303);

				test_bench.WRITE(ADDR_TCR,32'hAAAA_AAAA,4'hf);
				test_bench.READ(ADDR_TCR,32'h0000_0302);

				test_bench.WRITE(ADDR_TCR,32'h5AA5_A552,4'hf);
				test_bench.READ(ADDR_TCR,32'h0000_0502);

				test_bench.RST;

				$display("*** Reserved bit access");
				test_bench.WRITE(ADDR_TCR,32'hFFFF_FFFF,4'hf);
				test_bench.READ(ADDR_TCR,32'h0000_0103);	
					
		end			
endtask
