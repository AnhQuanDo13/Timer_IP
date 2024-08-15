task run_test();
		
		begin
				$display("====================================================================");
				$display("=========================== Check PSLVERR ==========================");
				$display("====================================================================");
				
				test_bench.W_PSLVERR(1,32'h1234_5678);
				test_bench.W_PSLVERR(2,32'h1234_5678);
				test_bench.W_PSLVERR(10,32'h1234_5678);
				test_bench.W_PSLVERR(29,32'h1234_5678);
				

				test_bench.R_PSLVERR(10);
				test_bench.R_PSLVERR(23);
				test_bench.R_PSLVERR(27);
				test_bench.R_PSLVERR(30);



			
		end		
endtask
