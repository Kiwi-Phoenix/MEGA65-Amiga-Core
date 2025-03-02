# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "FMODE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SPRPOSCTLBASE" -parent ${Page_0}


}

proc update_PARAM_VALUE.FMODE { PARAM_VALUE.FMODE } {
	# Procedure called to update FMODE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FMODE { PARAM_VALUE.FMODE } {
	# Procedure called to validate FMODE
	return true
}

proc update_PARAM_VALUE.SPRPOSCTLBASE { PARAM_VALUE.SPRPOSCTLBASE } {
	# Procedure called to update SPRPOSCTLBASE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SPRPOSCTLBASE { PARAM_VALUE.SPRPOSCTLBASE } {
	# Procedure called to validate SPRPOSCTLBASE
	return true
}


proc update_MODELPARAM_VALUE.SPRPOSCTLBASE { MODELPARAM_VALUE.SPRPOSCTLBASE PARAM_VALUE.SPRPOSCTLBASE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SPRPOSCTLBASE}] ${MODELPARAM_VALUE.SPRPOSCTLBASE}
}

proc update_MODELPARAM_VALUE.FMODE { MODELPARAM_VALUE.FMODE PARAM_VALUE.FMODE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FMODE}] ${MODELPARAM_VALUE.FMODE}
}

