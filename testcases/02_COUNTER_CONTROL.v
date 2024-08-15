task run_test();
		begin
				$display("====================================================================");
				$display("========================== Default mode ============================");
				$display("====================================================================");	

				$display("*** Case div_en = 0 ***");
				test_bench.WRITE(ADDR_TCR, 32'h0000_0001,4'hf);
				repeat (4) @(posedge clk); 
				test_bench.READ(ADDR_TDR0,7);
				test_bench.READ(ADDR_TDR0,11);
				test_bench.READ(ADDR_TDR0,15);

				test_bench.RST;

				$display("====================================================================");
				$display("========================== Control mode ============================");
				$display("====================================================================");	
				
				$display("*** Case div_val = 0, div_en = 1 ***");
				test_bench.WRITE(ADDR_TCR, 32'h0000_0003,4'hf);
				repeat (4) @(posedge clk); // 1 2 3 4
				test_bench.READ(ADDR_TDR0,7);
				test_bench.READ(ADDR_TDR0,11);
				test_bench.READ(ADDR_TDR0,15);
				
				test_bench.RST;				

				$display("*** Case div_val = 1, div_en = 1 ***");
				test_bench.WRITE(ADDR_TCR, 32'h0000_0103,4'hf);
				repeat (9) @(posedge clk);
				test_bench.READ(ADDR_TDR0,6);
				test_bench.READ(ADDR_TDR0,8);
				test_bench.READ(ADDR_TDR0,10);
				
				test_bench.RST;

				$display("*** Case div_val = 2, div_en = 1 ***");
				test_bench.WRITE(ADDR_TCR, 32'h0000_0203,4'hf);
				repeat (19) @(posedge clk);
				test_bench.READ(ADDR_TDR0,5);
				test_bench.READ(ADDR_TDR0,6);
				test_bench.READ(ADDR_TDR0,7);

				test_bench.RST;

				$display("*** Case div_val = 3, div_en = 1 ***");
				test_bench.WRITE(ADDR_TCR, 32'h0000_0303,4'hf);
				repeat (38) @(posedge clk);
				test_bench.READ(ADDR_TDR0,5);
				repeat (5) @(posedge clk);
				test_bench.READ(ADDR_TDR0,6);
				repeat (5) @(posedge clk);
				test_bench.READ(ADDR_TDR0,7);

				test_bench.RST;

				$display("*** Case div_val = 4, div_en = 1 ***");
				test_bench.WRITE(ADDR_TCR, 32'h0000_0403,4'hf);
				repeat (78) @(posedge clk);
				test_bench.READ(ADDR_TDR0,5);
				repeat (13) @(posedge clk);			
				test_bench.READ(ADDR_TDR0,6);
				repeat (13) @(posedge clk);
				test_bench.READ(ADDR_TDR0,7);

				test_bench.RST;

				$display("*** Case div_val = 5, div_en = 1 ***");
				test_bench.WRITE(ADDR_TCR, 32'h0000_0503,4'hf);
				repeat (158) @(posedge clk);
				test_bench.READ(ADDR_TDR0,5);
				repeat (29) @(posedge clk);			
				test_bench.READ(ADDR_TDR0,6);
				repeat (29) @(posedge clk);
				test_bench.READ(ADDR_TDR0,7);

				test_bench.RST;

				$display("*** Case div_val = 6, div_en = 1 ***");
				test_bench.WRITE(ADDR_TCR, 32'h0000_0603,4'hf);
				repeat (328) @(posedge clk);
				test_bench.READ(ADDR_TDR0,5);
				repeat (61) @(posedge clk);			
				test_bench.READ(ADDR_TDR0,6);
				repeat (61) @(posedge clk);
				test_bench.READ(ADDR_TDR0,7);
				
				test_bench.RST;

				$display("*** Case div_val = 7, div_en = 1 ***");
				test_bench.WRITE(ADDR_TCR, 32'h0000_0703,4'hf);
				repeat (638) @(posedge clk);
				test_bench.READ(ADDR_TDR0,5);
				repeat (125) @(posedge clk);			
				test_bench.READ(ADDR_TDR0,6);
				repeat (125) @(posedge clk);
				test_bench.READ(ADDR_TDR0,7);


				test_bench.RST;

				$display("*** Case div_val = 8, div_en = 1 ***");
				test_bench.WRITE(ADDR_TCR, 32'h0000_0803,4'hf);
				repeat (1278) @(posedge clk);
				test_bench.READ(ADDR_TDR0,5);
				repeat (253) @(posedge clk);			
				test_bench.READ(ADDR_TDR0,6);
				repeat (253) @(posedge clk);
				test_bench.READ(ADDR_TDR0,7);

				test_bench.RST;

				$display("====================================================================");
				$display("=============== Set div_val but does not set div_en ================");
				$display("====================================================================");	

				$display("*** Case div_val = 1, div_en = 0 ***");
				test_bench.WRITE(ADDR_TCR, 32'h0000_0101,4'hf);
				repeat (4) @(posedge clk); // 1 2 3 4
				test_bench.READ(ADDR_TDR0,7);
				test_bench.READ(ADDR_TDR0,11);
				test_bench.READ(ADDR_TDR0,15);
				
				test_bench.RST;

				$display("*** Case div_val = 2, div_en = 0 ***");
				test_bench.WRITE(ADDR_TCR, 32'h0000_0201,4'hf);
				repeat (4) @(posedge clk); // 1 2 3 4
				test_bench.READ(ADDR_TDR0,7);
				test_bench.READ(ADDR_TDR0,11);
				test_bench.READ(ADDR_TDR0,15);

				test_bench.RST;

				$display("*** Case div_val = 3, div_en = 0 ***");
				test_bench.WRITE(ADDR_TCR, 32'h0000_0301,4'hf);
				repeat (4) @(posedge clk); // 1 2 3 4
				test_bench.READ(ADDR_TDR0,7);
				test_bench.READ(ADDR_TDR0,11);
				test_bench.READ(ADDR_TDR0,15);

				test_bench.RST;				

				$display("*** Case div_val = 4, div_en = 0 ***");
				test_bench.WRITE(ADDR_TCR, 32'h0000_0401,4'hf);
				repeat (4) @(posedge clk); // 1 2 3 4
				test_bench.READ(ADDR_TDR0,7);
				test_bench.READ(ADDR_TDR0,11);
				test_bench.READ(ADDR_TDR0,15);

				test_bench.RST;

				$display("*** Case div_val = 5, div_en = 0 ***");
				test_bench.WRITE(ADDR_TCR, 32'h0000_0501,4'hf);
				repeat (4) @(posedge clk); // 1 2 3 4
				test_bench.READ(ADDR_TDR0,7);
				test_bench.READ(ADDR_TDR0,11);
				test_bench.READ(ADDR_TDR0,15);


				test_bench.RST;

				$display("*** Case div_val = 6, div_en = 0 ***");
				test_bench.WRITE(ADDR_TCR, 32'h0000_0601,4'hf);
				repeat (4) @(posedge clk); // 1 2 3 4
				test_bench.READ(ADDR_TDR0,7);
				test_bench.READ(ADDR_TDR0,11);
				test_bench.READ(ADDR_TDR0,15);
				
				test_bench.RST;

				$display("*** Case div_val = 7, div_en = 0 ***");
				test_bench.WRITE(ADDR_TCR, 32'h0000_0701,4'hf);
				repeat (4) @(posedge clk); // 1 2 3 4
				test_bench.READ(ADDR_TDR0,7);
				test_bench.READ(ADDR_TDR0,11);
				test_bench.READ(ADDR_TDR0,15);

				test_bench.RST;

				$display("*** Case div_val = 8, div_en = 0 ***");
				test_bench.WRITE(ADDR_TCR, 32'h0000_0801,4'hf);
				repeat (4) @(posedge clk); // 1 2 3 4
				test_bench.READ(ADDR_TDR0,7);
				test_bench.READ(ADDR_TDR0,11);
				test_bench.READ(ADDR_TDR0,15);
			
		end	
endtask
