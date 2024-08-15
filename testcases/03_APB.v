task run_test();
		
		begin
				$display("====================================================================");
				$display("============================ Normal APB ============================");
				$display("====================================================================");

				test_bench.WRITE(ADDR_TDR0,32'h1234_5678,4'hf);
				test_bench.READ(ADDR_TDR0,32'h1234_5678);

				test_bench.WRITE(ADDR_TDR1,32'h1234_5678,4'hf);
				test_bench.READ(ADDR_TDR1,32'h1234_5678);

				test_bench.RST;

				$display("====================================================================");
				$display("========================== Wrong protocol ==========================");
				$display("====================================================================");

				$display("*** Psel does not assert ***");
				force psel = 0;
				test_bench.WRITE(ADDR_TDR0,32'h1234_5678,4'hf);
				release psel;

				test_bench.READ(ADDR_TDR0,32'h0000_0000);

				test_bench.RST;

				$display("*** Penable does not assert ***");
				force penable = 0;
				test_bench.WRITE(ADDR_TDR0,32'h1234_5678,4'hf);
				release penable;

				test_bench.READ(ADDR_TDR0,32'h0000_0000);
				
				test_bench.RST;

				$display("====================================================================");
				$display("========================== Multiple access =========================");
				$display("====================================================================");
			
				$display("*** WW-RR ***");
				test_bench.WRITE(ADDR_TCR,32'h0000_0001,4'hf);
				test_bench.WRITE(ADDR_TDR0,32'hAAAA_AAAA,4'hf);
				test_bench.WRITE(ADDR_TDR1,32'hFFFF_FFFF,4'hf);

				test_bench.READ(ADDR_TDR0,32'hAAAA_AAAC);
				test_bench.READ(ADDR_TDR1,32'hFFFF_FFFF);
				
				test_bench.RST;

				$display("*** WR-WR ***");
				test_bench.WRITE(ADDR_TCR,32'h0000_0001,4'hf);
				test_bench.WRITE(ADDR_TDR0,32'h1234_1234,4'hf);
				test_bench.READ(ADDR_TDR0,32'h1234_1236);				
				test_bench.WRITE(ADDR_TDR1,32'hFFFF_FFFF,4'hf);
				test_bench.READ(ADDR_TDR1,32'hFFFF_FFFF);
										
		end		


endtask
