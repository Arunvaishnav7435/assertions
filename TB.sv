//SV Topics : Randomization
//Problem statement : to verify a BCD counter's functionality using assertion
//======================================

module assertions(out, clock, enb, reset);//assertion module
  input [3:0] out;
  input clock, reset, enb;
  
  sequence s1;		//sequences
    (out == 4'd9);
  endsequence
  
  sequence s2;
    (!reset && enb);
  endsequence
  
  sequence s3;
    (out == 4'd0);
  endsequence
  
  //if the current value is 9 and in next cycle reset is not high and enb is high then the value should wrap back to 0
  property p;  //property definition
    @(posedge clock) s1 |=> s2 |-> s3;
  endproperty
  
  always@(posedge clock)
    begin
      assert (!(out[3] && (out[2] || out[1])));//immediate assertion
    end  //fails before DUT is reset as the out is unknown
  
  assert property(p)   //concurrent assertion
      $display("property p succeded");
    else
      $display($time, ", property p failed");
endmodule

module test;
  logic [3:0] out;
  logic clock, enb, reset;
  
  counter m1(out, clock, enb, reset);
  
  bind counter assertions a1(out, clock, enb, reset);//assertion binding with DUT
  
  always #5 clock = ~clock;//clock generation
  
  task clk;			//using negedge of clock
    @(negedge clock)
    #0;
  endtask
  
  task rst;//reset DUT task
    clk;
    reset = 1;
    clk;
    reset = 0;
  endtask
  
  initial begin
    {clock, reset, enb} = 0;
    #1;
    rst;
    enb = 1;
    #1000;
    enb = 0;
    #100;
    $finish();
  end
endmodule
