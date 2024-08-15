
task run_test();
		begin
				$display("====================================================================");
				$display("======================= Check error handling =======================");
				$display("====================================================================");	

				$display("*** Prohibited to change div_en when timer_en = 1");
				test_bench.WRITE(ADDR_TCR,32'h0000_0101,4'hF);
				test_bench.READ(ADDR_TCR,32'h0000_0101);

				test_bench.W_PSLVERR(ADDR_TCR,32'h0000_0103);
				test_bench.READ(ADDR_TCR,32'h0000_0101);

				test_bench.RST;

				test_bench.WRITE(ADDR_TCR,32'h0000_0003,4'hF);
				test_bench.READ(ADDR_TCR,32'h0000_0003);

				test_bench.WRITE(ADDR_TCR,32'h0000_0703,4'hF);
				test_bench.READ(ADDR_TCR,32'h0000_0703);

				test_bench.W_PSLVERR(ADDR_TCR,32'h0000_0701);
				test_bench.READ(ADDR_TCR,32'h0000_0703);

				test_bench.RST;

				test_bench.WRITE(ADDR_TCR,32'h0000_0002,4'hF);
				test_bench.READ(ADDR_TCR,32'h0000_0002);

				test_bench.WRITE(ADDR_TCR,32'h0000_0702,4'hF);
				test_bench.READ(ADDR_TCR,32'h0000_0702);
				$display("====================================================================");

				test_bench.RST;

				$display("*** Special access for div_val. Can not write to div_Val if wdata[11:8] > 8");
				test_bench.WRITE(ADDR_TCR,32'h0000_0803,4'hF);
				test_bench.READ(ADDR_TCR,32'h0000_0803);

				test_bench.W_PSLVERR(ADDR_TCR,32'h0000_0903);
				test_bench.READ(ADDR_TCR,32'h0000_0803);

				test_bench.WRITE(ADDR_TCR,32'h0000_0703,4'hF);
				test_bench.READ(ADDR_TCR,32'h0000_0703);
				$display("====================================================================");

				
								
		end	
endtask
