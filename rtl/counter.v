module counter (
  // System signal
  input wire sys_clk,
  input wire sys_rst_n,

  // Control signals
  input wire [63:0] TDR,
  input wire timer_en,
  input wire div_en,
  input wire halt_req,
  input wire [7:0] clk_div,
  input wire TDR_sel,

  // Output signal
  output reg [63:0] cnt
);

  // Clock division signal
  reg [7:0] clk_cnt;
    
  // Clock enable logic
  always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
      clk_cnt <= 8'b0;
      cnt <= TDR; 
		end else begin
      if (timer_en) begin
        if (TDR_sel) begin
          cnt <= TDR;
        end else begin
          if (div_en) begin
            if (clk_cnt == clk_div) begin
              clk_cnt <= 8'b0;
              cnt <= cnt + 1;
            end else begin
             clk_cnt <= halt_req ? clk_cnt : (clk_cnt + 1);
            end
          end else begin
            cnt <= halt_req ? cnt : (cnt + 1);			 
					end
        end
      end else begin
        cnt <= TDR; 
      end
		end
  end

endmodule
