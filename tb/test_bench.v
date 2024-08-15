`timescale 1ns/100ps

module test_bench ;

	parameter ADDR_TCR 		=	12'h0;
	parameter ADDR_TDR0		=	12'h4;
	parameter ADDR_TDR1		=	12'h8;
	parameter ADDR_TCMP0 	=	12'hC;
	parameter ADDR_TCMP1 	=	12'h10;
	parameter ADDR_TIER		=	12'h14;
	parameter ADDR_TISR		=	12'h18;
	parameter ADDR_THCSR	=	12'h1C;	

  // System signals
  reg 					clk;
	reg 					rst_n;

  // APB signals
  reg		[11:0]	paddr;
  reg						pwrite;
  reg						psel;
  reg						penable;
  reg		[31:0]	pwdata;
	wire					pready;
	wire	[31:0]	prdata;
	wire					tim_int;
	wire					pslverr;
	reg						dbg_mode;
	reg		[3:0]		pstrb;

  
	integer				cnt_err = 0; 

  // Instantiate the top module
	timer_top  u_timer_top (
		.sys_clk			(	clk				),
    .sys_rst_n		(	rst_n			),
    .dbg_mode			(	dbg_mode	),
    .tim_pwrite		(	pwrite		),
		.tim_psel			(	psel			),
    .tim_penable	(	penable		),
    .tim_pstrb		(	pstrb			),
    .tim_paddr		(	paddr			),
    .tim_pwdata		(	pwdata		),
    .tim_prdata		(	prdata		),
    .tim_pready		(	pready		),
    .tim_pslverr	(	pslverr		),
    .tim_int			(	tim_int		)
	);

	// Clock generation
	initial begin
		clk = 0;
		forever #2.5 clk = ~clk;  // 200 MHz clock
	end

  // Resetn generation    
	task RST;
		begin   
			rst_n = 0 ;
			#100;
			rst_n = 1 ;
		end
	endtask
   	
	initial begin
		RST;
	end
    
	`include "run_test.v"
  	
	initial begin
		psel			=	0 ;
		paddr			= 0	;
		pwrite		=	0 ;
		penable		=	0 ;
		pwdata		=	32'h0000_0000 ;
		dbg_mode	=	0;
		pstrb			=	4'b1111 ;
		@(posedge rst_n);
		run_test();
		#100;
		report(cnt_err);
		$finish;
	end
	
	// APB write data to register
	task WRITE;
		input [11:0] address;
		input [31:0] data;
		input [3:0] strb;

		begin
			@(posedge clk);
			psel = 1;
			pwrite = 1;
			penable = 0;
			paddr = address;
			pwdata = data;
			pstrb = strb;
			$display ("Start write to address = %h, data = %h\n", address, data);
			@(posedge clk); #0.1;
			penable = 1;
			@(posedge clk); #0.1;
			@(posedge clk);
			penable = 0;
			psel = 0;
			pwrite = 0;
			paddr = 0;
			pwdata = 0;  
			$display ("Write transfer finished\n");
		end
	endtask

  //APB read data from register
	task READ;
		input [11:0] address;
		input [31:0] data;

		begin
			@(posedge clk);
			psel = 1;
			pwrite = 0;
			paddr = address;
			$display ("Start read at address = %h", address, "\n");
			@(posedge clk); #0.1;
			penable = 1;
			@(posedge clk); #0.1;
			if (data == prdata) begin
				$display ("############ DATA: %h", prdata);
				$display ("############ PADSSED ");
				$display ("\n ");
			end else begin
				$display ("############ DATA: %h, EXPECTED: %h", prdata, data);
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
		
	// APB Slave Error write
		task W_PSLVERR;
		input [31:0] address, data;

		begin
			@(posedge clk);
			psel = 1;
			pwrite = 1;
			penable = 0;
			paddr = address;
			pwdata = data;
			@(posedge clk); #0.1;
			penable = 1;
			$display ("Start write to address = %h, data = %h\n", address, data);
			wait (pready == 1); #0.1;
			if (pslverr == 1) begin
				$display ("############ PSLVERR = 1");
				$display ("############ PADSSED");
			end else begin
				$display ("############ PSLVERR = 0");
				$display ("############ FAILED");
				cnt_err = cnt_err + 1;
			end
			@(posedge clk);
			penable = 0;
			psel = 0;
			pwrite = 0;
			paddr = 0;
			pwdata = 0;

		end
	endtask
		
  //APB Slave Error Read
	task R_PSLVERR;
		input [31:0] address;

		begin
			@(posedge clk);
			psel = 1;
			pwrite = 0;
			paddr = address;
			@(posedge clk); #0.1;
			penable = 1;
			wait (pready == 1); #0.1;
			$display ("Start read at address = %h", address, "\n");
			if (pslverr == 1) begin
				$display ("############ PSLVERR = 1");
				$display ("############ PADSSED");
			end else begin
				$display ("############ PSLVERR = 0");
				$display ("############ FAILED");
				cnt_err = cnt_err + 1;
			end
			@(posedge clk);
			psel = 0;
			pwrite = 0;
			penable = 0;
			paddr = 0;  
		end
  endtask
		
	//Report status
	task report;  
		input integer status_report;
  	  
		begin
			if(status_report==0) begin
				$display("\nTESTCASE RESULT: TEST PASSED");
				$display("\n");
			end else begin
				$display("\nTESTCASE RESULT: TEST FAILED with %0d ERROR",status_report);
				$display("\n");
			end
		end
	endtask

endmodule
