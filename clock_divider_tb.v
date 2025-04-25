`timescale 1ns/1ps
module clock_divider_tb;
	reg clk;
	reg rst;
	wire clk_out;
	
	clock_divider #(.DIV_FACTOR(10)) uut(
		.clk(clk),
		.rst(rst),
		.clk_out(clk_out)
	);
	
	integer f;
	
	initial begin
		$dumpfile("clock_divider.vcd");
		$dumpvars(0,clock_divider_tb);
		
		f=$fopen("monitor_log.txt","w");
		if(!f) begin
			$display("無法開啟monitor_log.txt");
			$finish;
		end
		
		clk = 0;
		rst = 1;
		#10 rst=0;
		
		#200 $fclose(f);
		$display("模擬完成");
		$finish;
	end
	
	always begin
		#5 clk = ~clk;
		$fwrite(f,"time = %0t ns, clk = %b, clk_out = %b, rst = %b\n", $time, clk, clk_out, rst);
	end
endmodule	