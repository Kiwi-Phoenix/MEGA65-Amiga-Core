# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "G_ADDRESS_SIZE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "G_DATA_SIZE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "G_FREQ_HZ" -parent ${Page_0}
  ipgui::add_param $IPINST -name "G_NUM_SLAVES" -parent ${Page_0}


}

proc update_PARAM_VALUE.G_ADDRESS_SIZE { PARAM_VALUE.G_ADDRESS_SIZE } {
	# Procedure called to update G_ADDRESS_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.G_ADDRESS_SIZE { PARAM_VALUE.G_ADDRESS_SIZE } {
	# Procedure called to validate G_ADDRESS_SIZE
	return true
}

proc update_PARAM_VALUE.G_DATA_SIZE { PARAM_VALUE.G_DATA_SIZE } {
	# Procedure called to update G_DATA_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.G_DATA_SIZE { PARAM_VALUE.G_DATA_SIZE } {
	# Procedure called to validate G_DATA_SIZE
	return true
}

proc update_PARAM_VALUE.G_FREQ_HZ { PARAM_VALUE.G_FREQ_HZ } {
	# Procedure called to update G_FREQ_HZ when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.G_FREQ_HZ { PARAM_VALUE.G_FREQ_HZ } {
	# Procedure called to validate G_FREQ_HZ
	return true
}

proc update_PARAM_VALUE.G_NUM_SLAVES { PARAM_VALUE.G_NUM_SLAVES } {
	# Procedure called to update G_NUM_SLAVES when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.G_NUM_SLAVES { PARAM_VALUE.G_NUM_SLAVES } {
	# Procedure called to validate G_NUM_SLAVES
	return true
}


proc update_MODELPARAM_VALUE.G_NUM_SLAVES { MODELPARAM_VALUE.G_NUM_SLAVES PARAM_VALUE.G_NUM_SLAVES } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_NUM_SLAVES}] ${MODELPARAM_VALUE.G_NUM_SLAVES}
}

proc update_MODELPARAM_VALUE.G_FREQ_HZ { MODELPARAM_VALUE.G_FREQ_HZ PARAM_VALUE.G_FREQ_HZ } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_FREQ_HZ}] ${MODELPARAM_VALUE.G_FREQ_HZ}
}

proc update_MODELPARAM_VALUE.G_ADDRESS_SIZE { MODELPARAM_VALUE.G_ADDRESS_SIZE PARAM_VALUE.G_ADDRESS_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_ADDRESS_SIZE}] ${MODELPARAM_VALUE.G_ADDRESS_SIZE}
}

proc update_MODELPARAM_VALUE.G_DATA_SIZE { MODELPARAM_VALUE.G_DATA_SIZE PARAM_VALUE.G_DATA_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_DATA_SIZE}] ${MODELPARAM_VALUE.G_DATA_SIZE}
}

