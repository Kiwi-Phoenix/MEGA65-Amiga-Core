# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "CTL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DATA" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DATB" -parent ${Page_0}
  ipgui::add_param $IPINST -name "POS" -parent ${Page_0}


}

proc update_PARAM_VALUE.CTL { PARAM_VALUE.CTL } {
	# Procedure called to update CTL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CTL { PARAM_VALUE.CTL } {
	# Procedure called to validate CTL
	return true
}

proc update_PARAM_VALUE.DATA { PARAM_VALUE.DATA } {
	# Procedure called to update DATA when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATA { PARAM_VALUE.DATA } {
	# Procedure called to validate DATA
	return true
}

proc update_PARAM_VALUE.DATB { PARAM_VALUE.DATB } {
	# Procedure called to update DATB when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATB { PARAM_VALUE.DATB } {
	# Procedure called to validate DATB
	return true
}

proc update_PARAM_VALUE.POS { PARAM_VALUE.POS } {
	# Procedure called to update POS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.POS { PARAM_VALUE.POS } {
	# Procedure called to validate POS
	return true
}


proc update_MODELPARAM_VALUE.POS { MODELPARAM_VALUE.POS PARAM_VALUE.POS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.POS}] ${MODELPARAM_VALUE.POS}
}

proc update_MODELPARAM_VALUE.CTL { MODELPARAM_VALUE.CTL PARAM_VALUE.CTL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CTL}] ${MODELPARAM_VALUE.CTL}
}

proc update_MODELPARAM_VALUE.DATA { MODELPARAM_VALUE.DATA PARAM_VALUE.DATA } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DATA}] ${MODELPARAM_VALUE.DATA}
}

proc update_MODELPARAM_VALUE.DATB { MODELPARAM_VALUE.DATB PARAM_VALUE.DATB } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DATB}] ${MODELPARAM_VALUE.DATB}
}

