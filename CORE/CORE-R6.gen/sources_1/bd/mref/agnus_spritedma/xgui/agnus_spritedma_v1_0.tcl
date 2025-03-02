# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "FMODE_REG" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SPRPOSCTLBASE_REG" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SPRPTBASE_REG" -parent ${Page_0}


}

proc update_PARAM_VALUE.FMODE_REG { PARAM_VALUE.FMODE_REG } {
	# Procedure called to update FMODE_REG when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FMODE_REG { PARAM_VALUE.FMODE_REG } {
	# Procedure called to validate FMODE_REG
	return true
}

proc update_PARAM_VALUE.SPRPOSCTLBASE_REG { PARAM_VALUE.SPRPOSCTLBASE_REG } {
	# Procedure called to update SPRPOSCTLBASE_REG when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SPRPOSCTLBASE_REG { PARAM_VALUE.SPRPOSCTLBASE_REG } {
	# Procedure called to validate SPRPOSCTLBASE_REG
	return true
}

proc update_PARAM_VALUE.SPRPTBASE_REG { PARAM_VALUE.SPRPTBASE_REG } {
	# Procedure called to update SPRPTBASE_REG when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SPRPTBASE_REG { PARAM_VALUE.SPRPTBASE_REG } {
	# Procedure called to validate SPRPTBASE_REG
	return true
}


proc update_MODELPARAM_VALUE.SPRPTBASE_REG { MODELPARAM_VALUE.SPRPTBASE_REG PARAM_VALUE.SPRPTBASE_REG } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SPRPTBASE_REG}] ${MODELPARAM_VALUE.SPRPTBASE_REG}
}

proc update_MODELPARAM_VALUE.SPRPOSCTLBASE_REG { MODELPARAM_VALUE.SPRPOSCTLBASE_REG PARAM_VALUE.SPRPOSCTLBASE_REG } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SPRPOSCTLBASE_REG}] ${MODELPARAM_VALUE.SPRPOSCTLBASE_REG}
}

proc update_MODELPARAM_VALUE.FMODE_REG { MODELPARAM_VALUE.FMODE_REG PARAM_VALUE.FMODE_REG } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FMODE_REG}] ${MODELPARAM_VALUE.FMODE_REG}
}

