# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "G_BOARD" -parent ${Page_0}
  ipgui::add_param $IPINST -name "G_I2C_CLK_DIV" -parent ${Page_0}


}

proc update_PARAM_VALUE.G_BOARD { PARAM_VALUE.G_BOARD } {
	# Procedure called to update G_BOARD when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.G_BOARD { PARAM_VALUE.G_BOARD } {
	# Procedure called to validate G_BOARD
	return true
}

proc update_PARAM_VALUE.G_I2C_CLK_DIV { PARAM_VALUE.G_I2C_CLK_DIV } {
	# Procedure called to update G_I2C_CLK_DIV when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.G_I2C_CLK_DIV { PARAM_VALUE.G_I2C_CLK_DIV } {
	# Procedure called to validate G_I2C_CLK_DIV
	return true
}


proc update_MODELPARAM_VALUE.G_BOARD { MODELPARAM_VALUE.G_BOARD PARAM_VALUE.G_BOARD } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_BOARD}] ${MODELPARAM_VALUE.G_BOARD}
}

proc update_MODELPARAM_VALUE.G_I2C_CLK_DIV { MODELPARAM_VALUE.G_I2C_CLK_DIV PARAM_VALUE.G_I2C_CLK_DIV } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_I2C_CLK_DIV}] ${MODELPARAM_VALUE.G_I2C_CLK_DIV}
}

