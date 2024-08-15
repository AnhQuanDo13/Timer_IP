
task run_test();
		begin
				$display("====================================================================");
				$display("=========================== Check PSTRB ============================");
				$display("====================================================================");	
				
				test_bench.WRITE(ADDR_TCMP0,32'hf,4'hf);
				test_bench.WRITE(ADDR_TCMP1,32'h0,4'hf);
				test_bench.WRITE(ADDR_TIER,32'h1,4'hf);
				test_bench.WRITE(ADDR_TCR,32'h1,4'hf);

				repeat (32) @(posedge clk);

				test_bench.READ(ADDR_TISR,32'h1);

				
				test_bench.WRITE(ADDR_TISR,32'h1,4'b0000); 
				test_bench.READ(ADDR_TISR,32'h1);	
				

								
		end	
endtask
