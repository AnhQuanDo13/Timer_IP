module timer_top (
	input wire 					sys_clk,
  input wire 					sys_rst_n,
  input wire 					tim_psel,
  input wire 					tim_pwrite,
  input wire 					tim_penable,
  input wire 	[11:0] 	tim_paddr,
  input wire 	[31:0] 	tim_pwdata,
  output wire [31:0] 	tim_prdata,
  output wire 				tim_pready,
  input wire	[3:0] 	tim_pstrb,
 	output wire 				tim_pslverr,
  input wire 					dbg_mode,
  output wire 				tim_int
);
	// Internal signals
  wire								timer_en;
  wire								div_en;
  wire				[7:0]		clk_div;
	wire				[63:0]	cnt; 
  wire				[63:0]	TDR;  	
  wire								halt_req;
  wire								TDR_sel;

  // Instantiate the counter module
	counter u_counter (
		.sys_clk			( sys_clk			),
    .sys_rst_n		( sys_rst_n		),
    .TDR_sel			( TDR_sel			),
    .TDR					( TDR					),
    .timer_en			( timer_en		),
    .div_en				( div_en			),
    .halt_req			( halt_req		),
    .clk_div			( clk_div			),
    .cnt					( cnt					)
	);

  // Instantiate the register module
	register  u_register (
		.sys_clk			( sys_clk			),
		.sys_rst_n		( sys_rst_n		),
		.TDR_sel			( TDR_sel			),
		.dbg_mode			( dbg_mode		),
		.tim_psel			( tim_psel		),
		.tim_pwrite		( tim_pwrite	),
		.tim_pstrb		( tim_pstrb		),
		.tim_penable	( tim_penable	),
		.tim_paddr		( tim_paddr		),
		.tim_pwdata		( tim_pwdata	),
		.tim_prdata		( tim_prdata	),
		.tim_pready		( tim_pready	),
		.tim_pslverr	( tim_pslverr	),
		.tim_int			( tim_int			),
		.halt_req			( halt_req		),
		.timer_en			( timer_en		),
		.clk_div			( clk_div			),
		.div_en				( div_en			),
		.TDR					( TDR					),
		.cnt					( cnt					)
		);

endmodule

