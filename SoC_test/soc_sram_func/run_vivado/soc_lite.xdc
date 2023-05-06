
## Clock Signal
set_property -dict { PACKAGE_PIN AD11  IOSTANDARD LVDS     } [get_ports { clk_in1_n }]; #IO_L12N_T1_MRCC_33 Sch=sysclk_n
set_property -dict { PACKAGE_PIN AD12  IOSTANDARD LVDS     } [get_ports { clk_in1_p }]; #IO_L12P_T1_MRCC_33 Sch=sysclk_p

## Buttons
set_property -dict { PACKAGE_PIN R19   IOSTANDARD LVCMOS33 } [get_ports { resetn }]; #IO_0_14 Sch=cpu_resetn

## LEDs
set_property -dict { PACKAGE_PIN T28   IOSTANDARD LVCMOS33 } [get_ports { led[0] }]; #IO_L11N_T1_SRCC_14 Sch=led[0]
set_property -dict { PACKAGE_PIN V19   IOSTANDARD LVCMOS33 } [get_ports { led[1] }]; #IO_L19P_T3_A10_D26_14 Sch=led[1]
set_property -dict { PACKAGE_PIN U30   IOSTANDARD LVCMOS33 } [get_ports { led[2] }]; #IO_L15N_T2_DQS_DOUT_CSO_B_14 Sch=led[2]
set_property -dict { PACKAGE_PIN U29   IOSTANDARD LVCMOS33 } [get_ports { led[3] }]; #IO_L15P_T2_DQS_RDWR_B_14 Sch=led[3]
set_property -dict { PACKAGE_PIN V20   IOSTANDARD LVCMOS33 } [get_ports { led[4] }]; #IO_L19N_T3_A09_D25_VREF_14 Sch=led[4]
set_property -dict { PACKAGE_PIN V26   IOSTANDARD LVCMOS33 } [get_ports { led[5] }]; #IO_L16P_T2_CSI_B_14 Sch=led[5]
set_property -dict { PACKAGE_PIN W24   IOSTANDARD LVCMOS33 } [get_ports { led[6] }]; #IO_L20N_T3_A07_D23_14 Sch=led[6]
set_property -dict { PACKAGE_PIN W23   IOSTANDARD LVCMOS33 } [get_ports { led[7] }]; #IO_L20P_T3_A08_D24_14 Sch=led[7]

## Switches
set_property -dict { PACKAGE_PIN G19   IOSTANDARD LVCMOS12 } [get_ports { switch[0] }]; #IO_0_17 Sch=sw[0]
set_property -dict { PACKAGE_PIN G25   IOSTANDARD LVCMOS12 } [get_ports { switch[1] }]; #IO_25_16 Sch=sw[1]
set_property -dict { PACKAGE_PIN H24   IOSTANDARD LVCMOS12 } [get_ports { switch[2] }]; #IO_L19P_T3_16 Sch=sw[2]
set_property -dict { PACKAGE_PIN K19   IOSTANDARD LVCMOS12 } [get_ports { switch[3] }]; #IO_L6P_T0_17 Sch=sw[3]
set_property -dict { PACKAGE_PIN N19   IOSTANDARD LVCMOS12 } [get_ports { switch[4] }]; #IO_L19P_T3_A22_15 Sch=sw[4]
set_property -dict { PACKAGE_PIN P19   IOSTANDARD LVCMOS12 } [get_ports { switch[5] }]; #IO_25_15 Sch=sw[5]
set_property -dict { PACKAGE_PIN P26   IOSTANDARD LVCMOS33 } [get_ports { switch[6] }]; #IO_L10P_T1_D14_14 Sch=sw[6]
set_property -dict { PACKAGE_PIN P27   IOSTANDARD LVCMOS33 } [get_ports { switch[7] }]; #IO_L8P_T1_D11_14 Sch=sw[7]

## PMOD Header JC
set_property -dict { PACKAGE_PIN AC26  IOSTANDARD LVCMOS33 } [get_ports { num_csn[0] }]; #IO_L19P_T3_13 Sch=jc[1]
set_property -dict { PACKAGE_PIN AJ27  IOSTANDARD LVCMOS33 } [get_ports { num_csn[2] }]; #IO_L20P_T3_13 Sch=jc[2]
set_property -dict { PACKAGE_PIN AH30  IOSTANDARD LVCMOS33 } [get_ports { num_csn[4] }]; #IO_L18N_T2_13 Sch=jc[3]
set_property -dict { PACKAGE_PIN AK29  IOSTANDARD LVCMOS33 } [get_ports { num_csn[6] }]; #IO_L15P_T2_DQS_13 Sch=jc[4]
set_property -dict { PACKAGE_PIN AD26  IOSTANDARD LVCMOS33 } [get_ports { num_csn[1] }]; #IO_L19N_T3_VREF_13 Sch=jc[7]
set_property -dict { PACKAGE_PIN AG30  IOSTANDARD LVCMOS33 } [get_ports { num_csn[3] }]; #IO_L18P_T2_13 Sch=jc[8]
set_property -dict { PACKAGE_PIN AK30  IOSTANDARD LVCMOS33 } [get_ports { num_csn[5] }]; #IO_L15N_T2_DQS_13 Sch=jc[9]
set_property -dict { PACKAGE_PIN AK28  IOSTANDARD LVCMOS33 } [get_ports { num_csn[7] }]; #IO_L20N_T3_13 Sch=jc[10]

## PMOD Header JD
set_property -dict { PACKAGE_PIN V27   IOSTANDARD LVCMOS33 } [get_ports { num_a_g[5] }]; #IO_L16N_T2_A15_D31_14 Sch=jd[1]
set_property -dict { PACKAGE_PIN Y30   IOSTANDARD LVCMOS33 } [get_ports { num_a_g[3] }]; #IO_L8P_T1_13 Sch=jd[2]
set_property -dict { PACKAGE_PIN V24   IOSTANDARD LVCMOS33 } [get_ports { num_a_g[1] }]; #IO_L23N_T3_A02_D18_14 Sch=jd[3]
set_property -dict { PACKAGE_PIN U24   IOSTANDARD LVCMOS33 } [get_ports { num_a_g[6] }]; #IO_L23P_T3_A03_D19_14 Sch=jd[7]
set_property -dict { PACKAGE_PIN Y26   IOSTANDARD LVCMOS33 } [get_ports { num_a_g[4] }]; #IO_L1P_T0_13 Sch=jd[8]
set_property -dict { PACKAGE_PIN V22   IOSTANDARD LVCMOS33 } [get_ports { num_a_g[2] }]; #IO_L22N_T3_A04_D20_14 Sch=jd[9]
set_property -dict { PACKAGE_PIN W21   IOSTANDARD LVCMOS33 } [get_ports { num_a_g[0] }]; #IO_L24P_T3_A01_D17_14 Sch=jd[10]