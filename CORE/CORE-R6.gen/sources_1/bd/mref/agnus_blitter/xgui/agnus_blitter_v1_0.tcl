# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "BLTADAT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLTAFWM" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLTALWM" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLTBDAT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLTCDAT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLTCON0" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLTCON0L" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLTCON1" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLTDDAT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLTSIZE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLTSIZH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLTSIZV" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLT_A" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLT_B" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLT_C" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLT_D" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLT_E" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLT_F" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLT_IDLE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLT_INIT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLT_L1" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLT_L2" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLT_L3" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLT_L4" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CHA" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CHB" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CHC" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CHD" -parent ${Page_0}


}

proc update_PARAM_VALUE.BLTADAT { PARAM_VALUE.BLTADAT } {
	# Procedure called to update BLTADAT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLTADAT { PARAM_VALUE.BLTADAT } {
	# Procedure called to validate BLTADAT
	return true
}

proc update_PARAM_VALUE.BLTAFWM { PARAM_VALUE.BLTAFWM } {
	# Procedure called to update BLTAFWM when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLTAFWM { PARAM_VALUE.BLTAFWM } {
	# Procedure called to validate BLTAFWM
	return true
}

proc update_PARAM_VALUE.BLTALWM { PARAM_VALUE.BLTALWM } {
	# Procedure called to update BLTALWM when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLTALWM { PARAM_VALUE.BLTALWM } {
	# Procedure called to validate BLTALWM
	return true
}

proc update_PARAM_VALUE.BLTBDAT { PARAM_VALUE.BLTBDAT } {
	# Procedure called to update BLTBDAT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLTBDAT { PARAM_VALUE.BLTBDAT } {
	# Procedure called to validate BLTBDAT
	return true
}

proc update_PARAM_VALUE.BLTCDAT { PARAM_VALUE.BLTCDAT } {
	# Procedure called to update BLTCDAT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLTCDAT { PARAM_VALUE.BLTCDAT } {
	# Procedure called to validate BLTCDAT
	return true
}

proc update_PARAM_VALUE.BLTCON0 { PARAM_VALUE.BLTCON0 } {
	# Procedure called to update BLTCON0 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLTCON0 { PARAM_VALUE.BLTCON0 } {
	# Procedure called to validate BLTCON0
	return true
}

proc update_PARAM_VALUE.BLTCON0L { PARAM_VALUE.BLTCON0L } {
	# Procedure called to update BLTCON0L when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLTCON0L { PARAM_VALUE.BLTCON0L } {
	# Procedure called to validate BLTCON0L
	return true
}

proc update_PARAM_VALUE.BLTCON1 { PARAM_VALUE.BLTCON1 } {
	# Procedure called to update BLTCON1 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLTCON1 { PARAM_VALUE.BLTCON1 } {
	# Procedure called to validate BLTCON1
	return true
}

proc update_PARAM_VALUE.BLTDDAT { PARAM_VALUE.BLTDDAT } {
	# Procedure called to update BLTDDAT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLTDDAT { PARAM_VALUE.BLTDDAT } {
	# Procedure called to validate BLTDDAT
	return true
}

proc update_PARAM_VALUE.BLTSIZE { PARAM_VALUE.BLTSIZE } {
	# Procedure called to update BLTSIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLTSIZE { PARAM_VALUE.BLTSIZE } {
	# Procedure called to validate BLTSIZE
	return true
}

proc update_PARAM_VALUE.BLTSIZH { PARAM_VALUE.BLTSIZH } {
	# Procedure called to update BLTSIZH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLTSIZH { PARAM_VALUE.BLTSIZH } {
	# Procedure called to validate BLTSIZH
	return true
}

proc update_PARAM_VALUE.BLTSIZV { PARAM_VALUE.BLTSIZV } {
	# Procedure called to update BLTSIZV when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLTSIZV { PARAM_VALUE.BLTSIZV } {
	# Procedure called to validate BLTSIZV
	return true
}

proc update_PARAM_VALUE.BLT_A { PARAM_VALUE.BLT_A } {
	# Procedure called to update BLT_A when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLT_A { PARAM_VALUE.BLT_A } {
	# Procedure called to validate BLT_A
	return true
}

proc update_PARAM_VALUE.BLT_B { PARAM_VALUE.BLT_B } {
	# Procedure called to update BLT_B when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLT_B { PARAM_VALUE.BLT_B } {
	# Procedure called to validate BLT_B
	return true
}

proc update_PARAM_VALUE.BLT_C { PARAM_VALUE.BLT_C } {
	# Procedure called to update BLT_C when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLT_C { PARAM_VALUE.BLT_C } {
	# Procedure called to validate BLT_C
	return true
}

proc update_PARAM_VALUE.BLT_D { PARAM_VALUE.BLT_D } {
	# Procedure called to update BLT_D when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLT_D { PARAM_VALUE.BLT_D } {
	# Procedure called to validate BLT_D
	return true
}

proc update_PARAM_VALUE.BLT_E { PARAM_VALUE.BLT_E } {
	# Procedure called to update BLT_E when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLT_E { PARAM_VALUE.BLT_E } {
	# Procedure called to validate BLT_E
	return true
}

proc update_PARAM_VALUE.BLT_F { PARAM_VALUE.BLT_F } {
	# Procedure called to update BLT_F when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLT_F { PARAM_VALUE.BLT_F } {
	# Procedure called to validate BLT_F
	return true
}

proc update_PARAM_VALUE.BLT_IDLE { PARAM_VALUE.BLT_IDLE } {
	# Procedure called to update BLT_IDLE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLT_IDLE { PARAM_VALUE.BLT_IDLE } {
	# Procedure called to validate BLT_IDLE
	return true
}

proc update_PARAM_VALUE.BLT_INIT { PARAM_VALUE.BLT_INIT } {
	# Procedure called to update BLT_INIT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLT_INIT { PARAM_VALUE.BLT_INIT } {
	# Procedure called to validate BLT_INIT
	return true
}

proc update_PARAM_VALUE.BLT_L1 { PARAM_VALUE.BLT_L1 } {
	# Procedure called to update BLT_L1 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLT_L1 { PARAM_VALUE.BLT_L1 } {
	# Procedure called to validate BLT_L1
	return true
}

proc update_PARAM_VALUE.BLT_L2 { PARAM_VALUE.BLT_L2 } {
	# Procedure called to update BLT_L2 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLT_L2 { PARAM_VALUE.BLT_L2 } {
	# Procedure called to validate BLT_L2
	return true
}

proc update_PARAM_VALUE.BLT_L3 { PARAM_VALUE.BLT_L3 } {
	# Procedure called to update BLT_L3 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLT_L3 { PARAM_VALUE.BLT_L3 } {
	# Procedure called to validate BLT_L3
	return true
}

proc update_PARAM_VALUE.BLT_L4 { PARAM_VALUE.BLT_L4 } {
	# Procedure called to update BLT_L4 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLT_L4 { PARAM_VALUE.BLT_L4 } {
	# Procedure called to validate BLT_L4
	return true
}

proc update_PARAM_VALUE.CHA { PARAM_VALUE.CHA } {
	# Procedure called to update CHA when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CHA { PARAM_VALUE.CHA } {
	# Procedure called to validate CHA
	return true
}

proc update_PARAM_VALUE.CHB { PARAM_VALUE.CHB } {
	# Procedure called to update CHB when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CHB { PARAM_VALUE.CHB } {
	# Procedure called to validate CHB
	return true
}

proc update_PARAM_VALUE.CHC { PARAM_VALUE.CHC } {
	# Procedure called to update CHC when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CHC { PARAM_VALUE.CHC } {
	# Procedure called to validate CHC
	return true
}

proc update_PARAM_VALUE.CHD { PARAM_VALUE.CHD } {
	# Procedure called to update CHD when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CHD { PARAM_VALUE.CHD } {
	# Procedure called to validate CHD
	return true
}


proc update_MODELPARAM_VALUE.BLTCON0 { MODELPARAM_VALUE.BLTCON0 PARAM_VALUE.BLTCON0 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLTCON0}] ${MODELPARAM_VALUE.BLTCON0}
}

proc update_MODELPARAM_VALUE.BLTCON0L { MODELPARAM_VALUE.BLTCON0L PARAM_VALUE.BLTCON0L } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLTCON0L}] ${MODELPARAM_VALUE.BLTCON0L}
}

proc update_MODELPARAM_VALUE.BLTCON1 { MODELPARAM_VALUE.BLTCON1 PARAM_VALUE.BLTCON1 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLTCON1}] ${MODELPARAM_VALUE.BLTCON1}
}

proc update_MODELPARAM_VALUE.BLTAFWM { MODELPARAM_VALUE.BLTAFWM PARAM_VALUE.BLTAFWM } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLTAFWM}] ${MODELPARAM_VALUE.BLTAFWM}
}

proc update_MODELPARAM_VALUE.BLTALWM { MODELPARAM_VALUE.BLTALWM PARAM_VALUE.BLTALWM } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLTALWM}] ${MODELPARAM_VALUE.BLTALWM}
}

proc update_MODELPARAM_VALUE.BLTADAT { MODELPARAM_VALUE.BLTADAT PARAM_VALUE.BLTADAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLTADAT}] ${MODELPARAM_VALUE.BLTADAT}
}

proc update_MODELPARAM_VALUE.BLTBDAT { MODELPARAM_VALUE.BLTBDAT PARAM_VALUE.BLTBDAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLTBDAT}] ${MODELPARAM_VALUE.BLTBDAT}
}

proc update_MODELPARAM_VALUE.BLTCDAT { MODELPARAM_VALUE.BLTCDAT PARAM_VALUE.BLTCDAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLTCDAT}] ${MODELPARAM_VALUE.BLTCDAT}
}

proc update_MODELPARAM_VALUE.BLTDDAT { MODELPARAM_VALUE.BLTDDAT PARAM_VALUE.BLTDDAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLTDDAT}] ${MODELPARAM_VALUE.BLTDDAT}
}

proc update_MODELPARAM_VALUE.BLTSIZE { MODELPARAM_VALUE.BLTSIZE PARAM_VALUE.BLTSIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLTSIZE}] ${MODELPARAM_VALUE.BLTSIZE}
}

proc update_MODELPARAM_VALUE.BLTSIZH { MODELPARAM_VALUE.BLTSIZH PARAM_VALUE.BLTSIZH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLTSIZH}] ${MODELPARAM_VALUE.BLTSIZH}
}

proc update_MODELPARAM_VALUE.BLTSIZV { MODELPARAM_VALUE.BLTSIZV PARAM_VALUE.BLTSIZV } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLTSIZV}] ${MODELPARAM_VALUE.BLTSIZV}
}

proc update_MODELPARAM_VALUE.CHA { MODELPARAM_VALUE.CHA PARAM_VALUE.CHA } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CHA}] ${MODELPARAM_VALUE.CHA}
}

proc update_MODELPARAM_VALUE.CHB { MODELPARAM_VALUE.CHB PARAM_VALUE.CHB } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CHB}] ${MODELPARAM_VALUE.CHB}
}

proc update_MODELPARAM_VALUE.CHC { MODELPARAM_VALUE.CHC PARAM_VALUE.CHC } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CHC}] ${MODELPARAM_VALUE.CHC}
}

proc update_MODELPARAM_VALUE.CHD { MODELPARAM_VALUE.CHD PARAM_VALUE.CHD } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CHD}] ${MODELPARAM_VALUE.CHD}
}

proc update_MODELPARAM_VALUE.BLT_IDLE { MODELPARAM_VALUE.BLT_IDLE PARAM_VALUE.BLT_IDLE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLT_IDLE}] ${MODELPARAM_VALUE.BLT_IDLE}
}

proc update_MODELPARAM_VALUE.BLT_INIT { MODELPARAM_VALUE.BLT_INIT PARAM_VALUE.BLT_INIT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLT_INIT}] ${MODELPARAM_VALUE.BLT_INIT}
}

proc update_MODELPARAM_VALUE.BLT_A { MODELPARAM_VALUE.BLT_A PARAM_VALUE.BLT_A } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLT_A}] ${MODELPARAM_VALUE.BLT_A}
}

proc update_MODELPARAM_VALUE.BLT_B { MODELPARAM_VALUE.BLT_B PARAM_VALUE.BLT_B } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLT_B}] ${MODELPARAM_VALUE.BLT_B}
}

proc update_MODELPARAM_VALUE.BLT_C { MODELPARAM_VALUE.BLT_C PARAM_VALUE.BLT_C } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLT_C}] ${MODELPARAM_VALUE.BLT_C}
}

proc update_MODELPARAM_VALUE.BLT_D { MODELPARAM_VALUE.BLT_D PARAM_VALUE.BLT_D } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLT_D}] ${MODELPARAM_VALUE.BLT_D}
}

proc update_MODELPARAM_VALUE.BLT_E { MODELPARAM_VALUE.BLT_E PARAM_VALUE.BLT_E } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLT_E}] ${MODELPARAM_VALUE.BLT_E}
}

proc update_MODELPARAM_VALUE.BLT_F { MODELPARAM_VALUE.BLT_F PARAM_VALUE.BLT_F } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLT_F}] ${MODELPARAM_VALUE.BLT_F}
}

proc update_MODELPARAM_VALUE.BLT_L1 { MODELPARAM_VALUE.BLT_L1 PARAM_VALUE.BLT_L1 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLT_L1}] ${MODELPARAM_VALUE.BLT_L1}
}

proc update_MODELPARAM_VALUE.BLT_L2 { MODELPARAM_VALUE.BLT_L2 PARAM_VALUE.BLT_L2 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLT_L2}] ${MODELPARAM_VALUE.BLT_L2}
}

proc update_MODELPARAM_VALUE.BLT_L3 { MODELPARAM_VALUE.BLT_L3 PARAM_VALUE.BLT_L3 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLT_L3}] ${MODELPARAM_VALUE.BLT_L3}
}

proc update_MODELPARAM_VALUE.BLT_L4 { MODELPARAM_VALUE.BLT_L4 PARAM_VALUE.BLT_L4 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLT_L4}] ${MODELPARAM_VALUE.BLT_L4}
}

