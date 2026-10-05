\m4_TLV_version 1d: tl-x.org
\SV
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
	m4_include_lib(['https://raw.githubusercontent.com/stevehoover/LF-Building-a-RISC-V-CPU-Core/main/lib/calc_viz.tlv'])
   /* verilator lint_on WIDTH */
\TLV
   // Connect SV inputs to TLV pipesignals.
   $reset = *reset;
   
   // ins
   $val1[31:0] = {26'h0, $val1_rand[5:0]};
   $val2[31:0] = {28'h0, $val2_rand[3:0]};
   
   // all ops
   $sum[31:0] = $val1[31:0] + $val2[31:0];
   $diff[31:0] = $val1[31:0] - $val2[31:0];
   $prod[31:0] = $val1[31:0] * $val2[31:0];
   $quot[31:0] = $val1[31:0] / $val2[31:0];
   
   // choice
   $out[31:0] =
      $op[1:0] == 0 ? $sum:
      $op[1:0] == 1 ? $diff:
      $op[1:0] == 2 ? $prod:
                      $quot;
   
   // Assert these to end simulation (before the cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
   
   // better vis
   m4+calc_viz()
\SV
   endmodule
