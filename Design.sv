module counter(out, clock, enb, reset);//DUT
  output reg [3:0] out;
  input clock, reset, enb;
  
  always@(posedge clock)
    begin
      if(reset)
        out <= 0;
      else begin
        if(enb && out < 9)
          out <= out+1;
        else if(enb && out == 9)//wraps after 9
          out <= 0;
        else if(!enb)
          out <= out;
      end
    end
endmodule
