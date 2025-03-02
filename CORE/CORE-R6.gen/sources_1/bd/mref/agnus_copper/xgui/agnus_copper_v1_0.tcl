# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "COP1LCH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "COP1LCL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "COP2LCH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "COP2LCL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "COPCON" -parent ${Page_0}
  ipgui::add_param $IPINST -name "COPINS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "COPJMP1" -parent ${Page_0}
  ipgui::add_param $IPINST -name "COPJMP2" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FETCH1" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FETCH2" -parent ${Page_0}
  ipgui::add_param $IPINST -name "RESET" -parent ${Page_0}
  ipgui::add_param $IPINST -name "WAITSKIP1" -parent ${Page_0}
  ipgui::add_param $IPINST -name "WAITSKIP2" -parent ${Page_0}


}

proc update_PARAM_VALUE.COP1LCH { PARAM_VALUE.COP1LCH } {
	# Procedure called to update COP1LCH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COP1LCH { PARAM_VALUE.COP1LCH } {
	# Procedure called to validate COP1LCH
	return true
}

proc update_PARAM_VALUE.COP1LCL { PARAM_VALUE.COP1LCL } {
	# Procedure called to update COP1LCL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COP1LCL { PARAM_VALUE.COP1LCL } {
	# Procedure called to validate COP1LCL
	return true
}

proc update_PARAM_VALUE.COP2LCH { PARAM_VALUE.COP2LCH } {
	# Procedure called to update COP2LCH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COP2LCH { PARAM_VALUE.COP2LCH } {
	# Procedure called to validate COP2LCH
	return true
}

proc update_PARAM_VALUE.COP2LCL { PARAM_VALUE.COP2LCL } {
	# Procedure called to update COP2LCL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COP2LCL { PARAM_VALUE.COP2LCL } {
	# Procedure called to validate COP2LCL
	return true
}

proc update_PARAM_VALUE.COPCON { PARAM_VALUE.COPCON } {
	# Procedure called to update COPCON when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COPCON { PARAM_VALUE.COPCON } {
	# Procedure called to validate COPCON
	return true
}

proc update_PARAM_VALUE.COPINS { PARAM_VALUE.COPINS } {
	# Procedure called to update COPINS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COPINS { PARAM_VALUE.COPINS } {
	# Procedure called to validate COPINS
	return true
}

proc update_PARAM_VALUE.COPJMP1 { PARAM_VALUE.COPJMP1 } {
	# Procedure called to update COPJMP1 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COPJMP1 { PARAM_VALUE.COPJMP1 } {
	# Procedure called to validate COPJMP1
	return true
}

proc update_PARAM_VALUE.COPJMP2 { PARAM_VALUE.COPJMP2 } {
	# Procedure called to update COPJMP2 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COPJMP2 { PARAM_VALUE.COPJMP2 } {
	# Procedure called to validate COPJMP2
	return true
}

proc update_PARAM_VALUE.FETCH1 { PARAM_VALUE.FETCH1 } {
	# Procedure called to update FETCH1 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FETCH1 { PARAM_VALUE.FETCH1 } {
	# Procedure called to validate FETCH1
	return true
}

proc update_PARAM_VALUE.FETCH2 { PARAM_VALUE.FETCH2 } {
	# Procedure called to update FETCH2 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FETCH2 { PARAM_VALUE.FETCH2 } {
	# Procedure called to validate FETCH2
	return true
}

proc update_PARAM_VALUE.RESET { PARAM_VALUE.RESET } {
	# Procedure called to update RESET when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.RESET { PARAM_VALUE.RESET } {
	# Procedure called to validate RESET
	return true
}

proc update_PARAM_VALUE.WAITSKIP1 { PARAM_VALUE.WAITSKIP1 } {
	# Procedure called to update WAITSKIP1 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.WAITSKIP1 { PARAM_VALUE.WAITSKIP1 } {
	# Procedure called to validate WAITSKIP1
	return true
}

proc update_PARAM_VALUE.WAITSKIP2 { PARAM_VALUE.WAITSKIP2 } {
	# Procedure called to update WAITSKIP2 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.WAITSKIP2 { PARAM_VALUE.WAITSKIP2 } {
	# Procedure called to validate WAITSKIP2
	return true
}


proc update_MODELPARAM_VALUE.COP1LCH { MODELPARAM_VALUE.COP1LCH PARAM_VALUE.COP1LCH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COP1LCH}] ${MODELPARAM_VALUE.COP1LCH}
}

proc update_MODELPARAM_VALUE.COP1LCL { MODELPARAM_VALUE.COP1LCL PARAM_VALUE.COP1LCL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COP1LCL}] ${MODELPARAM_VALUE.COP1LCL}
}

proc update_MODELPARAM_VALUE.COP2LCH { MODELPARAM_VALUE.COP2LCH PARAM_VALUE.COP2LCH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COP2LCH}] ${MODELPARAM_VALUE.COP2LCH}
}

proc update_MODELPARAM_VALUE.COP2LCL { MODELPARAM_VALUE.COP2LCL PARAM_VALUE.COP2LCL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COP2LCL}] ${MODELPARAM_VALUE.COP2LCL}
}

proc update_MODELPARAM_VALUE.COPCON { MODELPARAM_VALUE.COPCON PARAM_VALUE.COPCON } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COPCON}] ${MODELPARAM_VALUE.COPCON}
}

proc update_MODELPARAM_VALUE.COPINS { MODELPARAM_VALUE.COPINS PARAM_VALUE.COPINS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COPINS}] ${MODELPARAM_VALUE.COPINS}
}

proc update_MODELPARAM_VALUE.COPJMP1 { MODELPARAM_VALUE.COPJMP1 PARAM_VALUE.COPJMP1 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COPJMP1}] ${MODELPARAM_VALUE.COPJMP1}
}

proc update_MODELPARAM_VALUE.COPJMP2 { MODELPARAM_VALUE.COPJMP2 PARAM_VALUE.COPJMP2 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COPJMP2}] ${MODELPARAM_VALUE.COPJMP2}
}

proc update_MODELPARAM_VALUE.RESET { MODELPARAM_VALUE.RESET PARAM_VALUE.RESET } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.RESET}] ${MODELPARAM_VALUE.RESET}
}

proc update_MODELPARAM_VALUE.FETCH1 { MODELPARAM_VALUE.FETCH1 PARAM_VALUE.FETCH1 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FETCH1}] ${MODELPARAM_VALUE.FETCH1}
}

proc update_MODELPARAM_VALUE.FETCH2 { MODELPARAM_VALUE.FETCH2 PARAM_VALUE.FETCH2 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FETCH2}] ${MODELPARAM_VALUE.FETCH2}
}

proc update_MODELPARAM_VALUE.WAITSKIP1 { MODELPARAM_VALUE.WAITSKIP1 PARAM_VALUE.WAITSKIP1 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.WAITSKIP1}] ${MODELPARAM_VALUE.WAITSKIP1}
}

proc update_MODELPARAM_VALUE.WAITSKIP2 { MODELPARAM_VALUE.WAITSKIP2 PARAM_VALUE.WAITSKIP2 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.WAITSKIP2}] ${MODELPARAM_VALUE.WAITSKIP2}
}

