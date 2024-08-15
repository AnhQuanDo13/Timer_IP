
task run_test();
		begin
				$display("====================================================================");
				$display("=========================== Check PSTRB ============================");
				$display("====================================================================");	

				test_bench.WRITE(ADDR_TCMP0,32'h1234_5678,4'b1101); 
				test_bench.READ(ADDR_TCMP0,32'h1234_0078);	
				
				test_bench.WRITE(ADDR_TCMP0,32'h1234_5678,4'b0000); 
				test_bench.READ(ADDR_TCMP0,32'h0000_0000);

				test_bench.WRITE(ADDR_TCMP1,32'hFFFF_FFFF,4'b1001); 
				test_bench.READ(ADDR_TCMP1,32'hFF00_00FF);
				
				test_bench.WRITE(ADDR_TCMP1,32'hFFFF_FFFF,4'b0000); 
				test_bench.READ(ADDR_TCMP1,32'h0000_0000);
				
				test_bench.WRITE(ADDR_TDR0,32'h5555_5555,4'b1111); 
				test_bench.READ(ADDR_TDR0,32'h5555_5555);
				
				test_bench.WRITE(ADDR_TDR0,32'h5555_5555,4'b0000); 
				test_bench.READ(ADDR_TDR0,32'h0000_0000);	

				test_bench.WRITE(ADDR_TDR1,32'hAAAA_AAAA,4'b0000); 
				test_bench.READ(ADDR_TDR1,32'h0000_0000);
				
				test_bench.WRITE(ADDR_TCMP0,32'h5AA5_A55A,4'b0101); 
				test_bench.READ(ADDR_TCMP0,32'h00A5_005A);	
				
				test_bench.WRITE(ADDR_TCR,32'h5555_5555,4'b0000); 
				test_bench.READ(ADDR_TCR,32'h0000_0000);	
				
				test_bench.WRITE(ADDR_TIER,32'h5555_5555,4'b0000); 
				test_bench.READ(ADDR_TIER,32'h0000_0000);	
				
				test_bench.WRITE(ADDR_TISR,32'h5555_5555,4'b0000); 
				test_bench.READ(ADDR_TISR,32'h0000_0001);	
				
				test_bench.WRITE(ADDR_THCSR,32'h5555_5555,4'b0000); 
				test_bench.READ(ADDR_THCSR,32'h0000_0000);	
				

								
		end	
endtask
