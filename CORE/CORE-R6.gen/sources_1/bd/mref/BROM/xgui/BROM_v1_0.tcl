# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "FILE_NAME" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ROM_WIDTH" -parent ${Page_0}


}

proc update_PARAM_VALUE.FILE_NAME { PARAM_VALUE.FILE_NAME } {
	# Procedure called to update FILE_NAME when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FILE_NAME { PARAM_VALUE.FILE_NAME } {
	# Procedure called to validate FILE_NAME
	return true
}

proc update_PARAM_VALUE.ROM_WIDTH { PARAM_VALUE.ROM_WIDTH } {
	# Procedure called to update ROM_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ROM_WIDTH { PARAM_VALUE.ROM_WIDTH } {
	# Procedure called to validate ROM_WIDTH
	return true
}


proc update_MODELPARAM_VALUE.FILE_NAME { MODELPARAM_VALUE.FILE_NAME PARAM_VALUE.FILE_NAME } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FILE_NAME}] ${MODELPARAM_VALUE.FILE_NAME}
}

proc update_MODELPARAM_VALUE.ROM_WIDTH { MODELPARAM_VALUE.ROM_WIDTH PARAM_VALUE.ROM_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ROM_WIDTH}] ${MODELPARAM_VALUE.ROM_WIDTH}
}

