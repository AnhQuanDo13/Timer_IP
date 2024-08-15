module register (
	// System signal
  input wire					sys_clk,
  input wire					sys_rst_n,

  // APB signal
  input wire					tim_psel,
  input wire					tim_pwrite,
  input wire					tim_penable,
	input wire	[3:0]		tim_pstrb,
  input wire	[11:0]	tim_paddr,
  input wire	[31:0]	tim_pwdata,
  output reg	[31:0]	tim_prdata,
  output wire					tim_pready,
  output reg					tim_pslverr,
  output reg					tim_int,
  input wire					dbg_mode,

  // Counter controlled signal
  input wire [63:0] cnt,
  output reg        timer_en,
  output reg [7:0]  clk_div,
  output reg        div_en,
  output reg [63:0] TDR,
	output reg        halt_req,
  output reg        TDR_sel
);

  // Register offsets
  localparam TCR_OFFSET   = 12'h000;
  localparam TDR0_OFFSET  = 12'h004;
  localparam TDR1_OFFSET  = 12'h008;
  localparam TCMP0_OFFSET = 12'h00C;
  localparam TCMP1_OFFSET = 12'h010;
  localparam TIER_OFFSET  = 12'h014;
  localparam TISR_OFFSET  = 12'h018;
  localparam THCSR_OFFSET = 12'h01C;

  // Registers
  reg [31:0] TCR, TDR0, TDR1, TCMP0, TCMP1, TIER, TISR, THCSR;
  reg [3:0] div_val;
  reg [3:0] pre_val;
  reg				TDR0_sel, TDR1_sel;
  reg				int_st;
	reg				int_en;
	reg				halt_ack;
	reg				WS;
    
  // Assignments
  always @(*) begin
    timer_en = TCR[0];
    div_en   = TCR[1];
    div_val  = TCR[11:8];
    int_en   = TIER[0];
    int_st   = TISR[0];
    halt_req = THCSR[0];
    halt_ack = THCSR[1];
    TDR      = {TDR1, TDR0};
    TDR_sel  = TDR0_sel || TDR1_sel;
  end

	assign interrupt = ((cnt == {TCMP1, TCMP0}) || (cnt == 64'hFFFF_FFFF_FFFF_FFFF)) ? 1 : 0;

  assign invalid_addr = (tim_pready && tim_paddr != 12'h004 && tim_paddr != 12'h000 && tim_paddr != 12'h008 && tim_paddr != 12'h00C && tim_paddr != 12'h010 && tim_paddr != 12'h014 && tim_paddr != 12'h018 && tim_paddr != 12'h01C);

	// APB write
  always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
			TCR         <= 32'h0000_0100;
			TDR0        <= 32'h0000_0000;
			TDR1        <= 32'h0000_0000;
      TCMP0       <= 32'hFFFF_FFFF;
      TCMP1       <= 32'hFFFF_FFFF;
      TIER        <= 32'h0000_0000;
      TISR        <= 32'h0000_0000;
      THCSR       <= 32'h0000_0000;
      tim_prdata  <= 32'h0000_0000;
      pre_val     <= 1;
      tim_int     <= 0;
    end else if (tim_psel && tim_pwrite && tim_penable && tim_pready) begin
      case (tim_paddr)
        TCR_OFFSET: begin
					TCR[7:0]			<= (tim_pstrb[0]) ? tim_pwdata[7:0] 	: 0;
          TCR[15:8]			<= (tim_pstrb[1]) ? tim_pwdata[15:8] 	: 0;
          TCR[23:16]		<= (tim_pstrb[2]) ? tim_pwdata[23:16] : 0;
          TCR[31:24]		<= (tim_pstrb[3]) ? tim_pwdata[31:24] : 0;
					if (!TCR[0]) begin
						TCR[1] <= tim_pwdata[1];
					end else begin
						if (TCR[1]) begin
							if (tim_pwdata[1]) 
								TCR[1] <= tim_pwdata[1];
							else	
								TCR[1] <= TCR[1];
						end else begin
							if (tim_pwdata[1]) 
								TCR[1] <= TCR[1];
							else
								TCR[1] <= tim_pwdata[1];
						end
					end
				
					if (tim_pwdata[11:8] > 8) TCR[11:8] <= pre_val;
          else											pre_val		<= tim_pwdata[11:8];

        end
        TDR0_OFFSET: begin
          TDR0[7:0]			<= (tim_pstrb[0]) ? tim_pwdata[7:0] 	: 0;
          TDR0[15:8]		<= (tim_pstrb[1]) ? tim_pwdata[15:8] 	: 0;
          TDR0[23:16]		<= (tim_pstrb[2]) ? tim_pwdata[23:16] : 0;
          TDR0[31:24]		<= (tim_pstrb[3]) ? tim_pwdata[31:24] : 0;
        end
        TDR1_OFFSET: begin
          TDR1[7:0]			<= (tim_pstrb[0]) ? tim_pwdata[7:0] 	: 0;
					TDR1[15:8]		<= (tim_pstrb[1]) ? tim_pwdata[15:8] 	: 0;
					TDR1[23:16]		<= (tim_pstrb[2]) ? tim_pwdata[23:16] : 0;
          TDR1[31:24]		<= (tim_pstrb[3]) ? tim_pwdata[31:24] : 0;
        end
        TCMP0_OFFSET: begin
          TCMP0[7:0]  	<= (tim_pstrb[0]) ? tim_pwdata[7:0] 	: 0;
          TCMP0[15:8] 	<= (tim_pstrb[1]) ? tim_pwdata[15:8] 	: 0;
          TCMP0[23:16] 	<= (tim_pstrb[2]) ? tim_pwdata[23:16] : 0;
					TCMP0[31:24] 	<= (tim_pstrb[3]) ? tim_pwdata[31:24] : 0;
        end
        TCMP1_OFFSET: begin
          TCMP1[7:0]  	<= (tim_pstrb[0]) ? tim_pwdata[7:0] 	: 0;
          TCMP1[15:8] 	<= (tim_pstrb[1]) ? tim_pwdata[15:8] 	: 0;
          TCMP1[23:16] 	<= (tim_pstrb[2]) ? tim_pwdata[23:16] : 0;
          TCMP1[31:24] 	<= (tim_pstrb[3]) ? tim_pwdata[31:24] : 0;
        end
        TIER_OFFSET: begin
          TIER[7:0]			<= (tim_pstrb[0]) ? tim_pwdata[7:0] 	: 0;
          TIER[15:8]		<= (tim_pstrb[1]) ? tim_pwdata[15:8] 	: 0;
          TIER[23:16]		<= (tim_pstrb[2]) ? tim_pwdata[23:16] : 0;
          TIER[31:24]		<= (tim_pstrb[3]) ? tim_pwdata[31:24] : 0;
        end
        TISR_OFFSET: begin
          TISR[7:0]			<= (tim_pstrb[0]) ? tim_pwdata[7:0] 	: 0;
          TISR[15:8]		<= (tim_pstrb[1]) ? tim_pwdata[15:8] 	: 0;
          TISR[23:16]		<= (tim_pstrb[2]) ? tim_pwdata[23:16] : 0;
          TISR[31:24]		<= (tim_pstrb[3]) ? tim_pwdata[31:24] : 0;
					if (tim_pstrb[0]) begin
						if (tim_pwdata[0] == 1) begin
							TISR[0] <= 0;
							tim_int <= 0;
						end else begin
							TISR[0] <= TISR[0];
							tim_int <= tim_int;
						end
					end else begin
							TISR[0] <= TISR[0];
							tim_int <= tim_int;
					end		
        end 
        default: begin
          THCSR[7:0]  	<= (tim_pstrb[0]) ? tim_pwdata[7:0] 	: 0;
          THCSR[15:8] 	<= (tim_pstrb[1]) ? tim_pwdata[15:8] 	: 0;
          THCSR[23:16] 	<= (tim_pstrb[2]) ? tim_pwdata[23:16] : 0;
          THCSR[31:24] 	<= (tim_pstrb[3]) ? tim_pwdata[31:24] : 0;
        end 
			endcase
    end
	end

  // APB read operation
  always @(*) begin
    if (tim_psel && !tim_pwrite && tim_penable && tim_pready) begin
      case (tim_paddr)
        TCR_OFFSET:   tim_prdata <= {20'b0, TCR[11:8], 6'b0, TCR[1], TCR[0]};
        TDR0_OFFSET:  tim_prdata <= (timer_en) ? cnt[31:0] : TDR0;
        TDR1_OFFSET:  tim_prdata <= (timer_en) ? cnt[63:32] : TDR1;
        TCMP0_OFFSET: tim_prdata <= TCMP0;
        TCMP1_OFFSET: tim_prdata <= TCMP1;
        TIER_OFFSET:  tim_prdata <= {31'b0, TIER[0]};
        TISR_OFFSET:  tim_prdata <= {31'b0, TISR[0]};
        THCSR_OFFSET: tim_prdata <= {30'b0, THCSR[1], THCSR[0]};
        default: tim_prdata <= 32'h0;
      endcase
		end else begin
			tim_prdata <= 32'h0000_0000;
		end
  end

	// Wait-state
	always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
      WS <= 0;
		end else begin
			if (tim_psel && tim_penable) begin
				WS <=  1;
			end else begin
				WS <=  0;
			end
		end
	end


	assign	tim_pready = (tim_penable & WS);


	// Pslverr
	always @(*) begin
    if (invalid_addr || (tim_pready && tim_pwrite && tim_paddr == TCR_OFFSET && ((tim_pwdata[11:8] > 4'b1000) || (TCR[0] && !TCR[1] && tim_pwdata[1]) || (TCR[0] && TCR[1] && !tim_pwdata[1])))) begin
			tim_pslverr = 1;
    end else begin
      tim_pslverr = 0;
    end
	end 
 
	// TDR_sel
  always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
			TDR0_sel <= 0;
			TDR1_sel <= 0;
		end else begin
			if (tim_psel && tim_pwrite && tim_penable && tim_pready) begin
				case (tim_paddr)
				  TDR0_OFFSET: TDR0_sel <= 1;
				  TDR1_OFFSET: TDR1_sel <= 1;
				  default: begin
				    TDR0_sel <= 0;
				    TDR1_sel <= 0;
				  end
				endcase
			end else begin
				TDR0_sel <= 0;
				TDR1_sel <= 0;
			end
		end
  end

	reg timer_en_delay;

	always @(posedge sys_clk) begin
		timer_en_delay <= timer_en;
	end

	assign timer_en_st = !timer_en && timer_en_delay;

	always @(*) begin
		if (timer_en_st) begin
			TDR0 <=  0 ;
			TDR1 <=  0 ;
		end else begin
			TDR0 <= TDR0;
			TDR1 <= TDR1;
		end
	end

	// Interrupt 
  always @(*) begin
    if (interrupt) begin
			if(TIER[0]) begin
				tim_int <= 1;
				TISR[0] <= 1;
			end else begin
				tim_int <= 0;
				TISR[0] <= 1;
			end
		end else begin
			tim_int <= TIER[0] ? TISR[0] : 0;
		end
  end

  // Div_val
	always @(*) begin
		if (div_val == 4'b0000)
			clk_div <= 8'd0;
		else
			clk_div <= (1 << div_val) - 1;
	end

  // Halt acknowledge
  always @(*) begin
    if (dbg_mode) begin
			THCSR[1] <= THCSR[0] ? 1 : 0;
    end else begin
      THCSR[0] <= 0;
      THCSR[1] <= 0;
    end
  end

endmodule

