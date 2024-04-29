// Code your design here
module sync_fifo (
    interf dif
);

  parameter depth = 8;  // Depth of the FIFO
  parameter ptr_size = 3;  // width of pointer for read and write
  parameter data_width = 8;  // Width of data in bits

  reg [data_width-1:0] mem[0:depth-1];
  reg [ptr_size-1:0] wr_ptr;
  reg [ptr_size-1:0] rd_ptr;
  reg [depth-1:0] count;

  always @(posedge dif.clk or posedge dif.reset) begin
      if (dif.reset || dif.clear) begin
      wr_ptr <= 0;
      rd_ptr <= 0;
      count  <= 0;
    end else begin
      fork
        begin
          if (dif.wr_en && !dif.full) begin
            mem[wr_ptr] <= dif.din;
            wr_ptr <= wr_ptr + 1;
          end
        end
        begin
          if (dif.rd_en && !dif.empty1) begin
            dif.dout <= mem[rd_ptr];
            rd_ptr   <= rd_ptr + 1;
          end
        end
      join

      if (dif.wr_en && !dif.full) begin
        if (!(dif.rd_en && !dif.empty1)) begin
          count <= count + 1;
        end
      end else begin
        if (dif.rd_en && !dif.empty1) begin
          count <= count - 1;
        end
      end
    end
  end

  assign dif.full   = (count == depth);
  assign dif.empty1 = (count == 0);

endmodule

