# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "G_ADDRESS_SIZE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "G_DATA_SIZE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "G_FILL_SIZE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "G_RD_DEPTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "G_WR_DEPTH" -parent ${Page_0}


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

proc update_PARAM_VALUE.G_FILL_SIZE { PARAM_VALUE.G_FILL_SIZE } {
	# Procedure called to update G_FILL_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.G_FILL_SIZE { PARAM_VALUE.G_FILL_SIZE } {
	# Procedure called to validate G_FILL_SIZE
	return true
}

proc update_PARAM_VALUE.G_RD_DEPTH { PARAM_VALUE.G_RD_DEPTH } {
	# Procedure called to update G_RD_DEPTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.G_RD_DEPTH { PARAM_VALUE.G_RD_DEPTH } {
	# Procedure called to validate G_RD_DEPTH
	return true
}

proc update_PARAM_VALUE.G_WR_DEPTH { PARAM_VALUE.G_WR_DEPTH } {
	# Procedure called to update G_WR_DEPTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.G_WR_DEPTH { PARAM_VALUE.G_WR_DEPTH } {
	# Procedure called to validate G_WR_DEPTH
	return true
}


proc update_MODELPARAM_VALUE.G_WR_DEPTH { MODELPARAM_VALUE.G_WR_DEPTH PARAM_VALUE.G_WR_DEPTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_WR_DEPTH}] ${MODELPARAM_VALUE.G_WR_DEPTH}
}

proc update_MODELPARAM_VALUE.G_RD_DEPTH { MODELPARAM_VALUE.G_RD_DEPTH PARAM_VALUE.G_RD_DEPTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_RD_DEPTH}] ${MODELPARAM_VALUE.G_RD_DEPTH}
}

proc update_MODELPARAM_VALUE.G_FILL_SIZE { MODELPARAM_VALUE.G_FILL_SIZE PARAM_VALUE.G_FILL_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_FILL_SIZE}] ${MODELPARAM_VALUE.G_FILL_SIZE}
}

proc update_MODELPARAM_VALUE.G_ADDRESS_SIZE { MODELPARAM_VALUE.G_ADDRESS_SIZE PARAM_VALUE.G_ADDRESS_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_ADDRESS_SIZE}] ${MODELPARAM_VALUE.G_ADDRESS_SIZE}
}

proc update_MODELPARAM_VALUE.G_DATA_SIZE { MODELPARAM_VALUE.G_DATA_SIZE PARAM_VALUE.G_DATA_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_DATA_SIZE}] ${MODELPARAM_VALUE.G_DATA_SIZE}
}

