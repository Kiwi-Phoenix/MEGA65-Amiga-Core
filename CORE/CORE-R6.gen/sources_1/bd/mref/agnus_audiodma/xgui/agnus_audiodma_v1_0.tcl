# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "AUD0DAT_REG" -parent ${Page_0}
  ipgui::add_param $IPINST -name "AUD1DAT_REG" -parent ${Page_0}
  ipgui::add_param $IPINST -name "AUD2DAT_REG" -parent ${Page_0}
  ipgui::add_param $IPINST -name "AUD3DAT_REG" -parent ${Page_0}


}

proc update_PARAM_VALUE.AUD0DAT_REG { PARAM_VALUE.AUD0DAT_REG } {
	# Procedure called to update AUD0DAT_REG when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AUD0DAT_REG { PARAM_VALUE.AUD0DAT_REG } {
	# Procedure called to validate AUD0DAT_REG
	return true
}

proc update_PARAM_VALUE.AUD1DAT_REG { PARAM_VALUE.AUD1DAT_REG } {
	# Procedure called to update AUD1DAT_REG when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AUD1DAT_REG { PARAM_VALUE.AUD1DAT_REG } {
	# Procedure called to validate AUD1DAT_REG
	return true
}

proc update_PARAM_VALUE.AUD2DAT_REG { PARAM_VALUE.AUD2DAT_REG } {
	# Procedure called to update AUD2DAT_REG when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AUD2DAT_REG { PARAM_VALUE.AUD2DAT_REG } {
	# Procedure called to validate AUD2DAT_REG
	return true
}

proc update_PARAM_VALUE.AUD3DAT_REG { PARAM_VALUE.AUD3DAT_REG } {
	# Procedure called to update AUD3DAT_REG when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AUD3DAT_REG { PARAM_VALUE.AUD3DAT_REG } {
	# Procedure called to validate AUD3DAT_REG
	return true
}


proc update_MODELPARAM_VALUE.AUD0DAT_REG { MODELPARAM_VALUE.AUD0DAT_REG PARAM_VALUE.AUD0DAT_REG } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AUD0DAT_REG}] ${MODELPARAM_VALUE.AUD0DAT_REG}
}

proc update_MODELPARAM_VALUE.AUD1DAT_REG { MODELPARAM_VALUE.AUD1DAT_REG PARAM_VALUE.AUD1DAT_REG } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AUD1DAT_REG}] ${MODELPARAM_VALUE.AUD1DAT_REG}
}

proc update_MODELPARAM_VALUE.AUD2DAT_REG { MODELPARAM_VALUE.AUD2DAT_REG PARAM_VALUE.AUD2DAT_REG } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AUD2DAT_REG}] ${MODELPARAM_VALUE.AUD2DAT_REG}
}

proc update_MODELPARAM_VALUE.AUD3DAT_REG { MODELPARAM_VALUE.AUD3DAT_REG PARAM_VALUE.AUD3DAT_REG } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AUD3DAT_REG}] ${MODELPARAM_VALUE.AUD3DAT_REG}
}

