module ParkSensor(
  input wire clk,
  input wire reset,
  input wire park_enable,
  input wire obstacle_detect,
  output wire park_status
);

  reg [3:0] count;
  reg park_detected;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      count <= 4'b0000;
      park_detected <= 1'b0;
    end else if (park_enable) begin
      if (obstacle_detect) begin
        if (count < 4'b1111)
          count <= count + 1;
        else
          park_detected <= 1'b1;
      end else if (count > 4'b0000) begin
        count <= count - 1;
        park_detected <= 1'b0;
      end
    end else begin
      count <= 4'b0000;
      park_detected <= 1'b0;
    end
  end

  assign park_status = park_detected;

endmodule
