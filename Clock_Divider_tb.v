`timescale 1ns/1ps

module Clock_Divider_tb();
reg       I_ref_clk_tb;
reg       I_rst_n_tb;
reg       I_clk_en_tb;
reg [3:0] I_div_ratio_tb;
wire      O_div_clk_tb;

parameter CLK_PER = 10 ;

initial
 begin
  $dumpfile("Clock_Divider.vcd");    
  $dumpvars; 
  initialize();
  reset();
  divide(2);
  reset();
  divide(3);
  reset();
  divide(4);
  reset();
  divide(5);
  reset();
  divide(6);
  reset();
  divide(7);
  reset();
  divide(8);
  reset();
  divide(1);
  #(10*CLK_PER)
  $finish;
 end 
 
 always #(CLK_PER/2) I_ref_clk_tb = ~I_ref_clk_tb  ;  // REF_CLK_period = 10 ns  REF_CLK_frequency = 100 MHz
 
 task initialize;
  begin
   I_ref_clk_tb = 0 ;
   I_rst_n_tb   = 1 ;
   I_clk_en_tb  = 0 ;
  end
 endtask
 
 task reset;
  begin
   I_rst_n_tb   = 0 ;
   #(2*CLK_PER)
   I_rst_n_tb   = 1 ;
  end
 endtask
 
 task divide;
  input [3:0] div;
  begin
   I_clk_en_tb = 1;
   I_div_ratio_tb = div ;
   #(20*CLK_PER);
  end
 endtask
 
 Clock_Divider DUT(
 .I_ref_clk(I_ref_clk_tb),
 .I_rst_n(I_rst_n_tb),
 .I_clk_en(I_clk_en_tb),
 .I_div_ratio(I_div_ratio_tb),
 .O_div_clk(O_div_clk_tb) 
 );
 
endmodule