# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "AUD0BASE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "AUD1BASE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "AUD2BASE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "AUD3BASE" -parent ${Page_0}


}

proc update_PARAM_VALUE.AUD0BASE { PARAM_VALUE.AUD0BASE } {
	# Procedure called to update AUD0BASE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AUD0BASE { PARAM_VALUE.AUD0BASE } {
	# Procedure called to validate AUD0BASE
	return true
}

proc update_PARAM_VALUE.AUD1BASE { PARAM_VALUE.AUD1BASE } {
	# Procedure called to update AUD1BASE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AUD1BASE { PARAM_VALUE.AUD1BASE } {
	# Procedure called to validate AUD1BASE
	return true
}

proc update_PARAM_VALUE.AUD2BASE { PARAM_VALUE.AUD2BASE } {
	# Procedure called to update AUD2BASE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AUD2BASE { PARAM_VALUE.AUD2BASE } {
	# Procedure called to validate AUD2BASE
	return true
}

proc update_PARAM_VALUE.AUD3BASE { PARAM_VALUE.AUD3BASE } {
	# Procedure called to update AUD3BASE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AUD3BASE { PARAM_VALUE.AUD3BASE } {
	# Procedure called to validate AUD3BASE
	return true
}


proc update_MODELPARAM_VALUE.AUD0BASE { MODELPARAM_VALUE.AUD0BASE PARAM_VALUE.AUD0BASE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AUD0BASE}] ${MODELPARAM_VALUE.AUD0BASE}
}

proc update_MODELPARAM_VALUE.AUD1BASE { MODELPARAM_VALUE.AUD1BASE PARAM_VALUE.AUD1BASE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AUD1BASE}] ${MODELPARAM_VALUE.AUD1BASE}
}

proc update_MODELPARAM_VALUE.AUD2BASE { MODELPARAM_VALUE.AUD2BASE PARAM_VALUE.AUD2BASE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AUD2BASE}] ${MODELPARAM_VALUE.AUD2BASE}
}

proc update_MODELPARAM_VALUE.AUD3BASE { MODELPARAM_VALUE.AUD3BASE PARAM_VALUE.AUD3BASE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AUD3BASE}] ${MODELPARAM_VALUE.AUD3BASE}
}

