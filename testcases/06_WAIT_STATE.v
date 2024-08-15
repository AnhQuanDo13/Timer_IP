task run_test();
	begin
		$display("====================================================================");
		$display("========================== Check Wait-state ========================");
		$display("====================================================================");

		

		test_bench.WRITE(ADDR_TCR,32'h0000_0001,4'hF);
		test_bench.READ(ADDR_TDR0,3);
		repeat (10) @(posedge clk);
		test_bench.READ(ADDR_TDR0,17);

		test_bench.RST;

		test_bench.WRITE(ADDR_TCR,32'h0000_0001,4'hF);
		test_bench.READ(ADDR_TDR0,3);
		repeat (10) @(posedge clk);	
		@(posedge clk); 
			psel = 1;
			pwrite = 0;
			paddr = ADDR_TDR0;
			$display ("Start read at address = %h", ADDR_TDR0, "\n");
			@(posedge clk); #0.1; 
			penable = 1;
			force test_bench.u_timer_top.u_register.tim_pready = 0;
			repeat (10) @(posedge clk);
			release test_bench.u_timer_top.u_register.tim_pready;
			#0.1;
			if (26 == prdata) begin
				$display ("############ DATA: %h", prdata);
				$display ("############ PADSSED ");
				$display ("\n ");
			end else begin
				$display ("############ DATA: %h, EXPECTED: %h", prdata, 26);
				$display ("############ FAILED");
				$display ("\n ");
				cnt_err = cnt_err + 1;
			end
			@(posedge clk);
			psel = 0;
			pwrite = 0;
			penable = 0;
			paddr = 0;  
			$display ("Read transfer finished ", "\n");

		
		end		
endtask
