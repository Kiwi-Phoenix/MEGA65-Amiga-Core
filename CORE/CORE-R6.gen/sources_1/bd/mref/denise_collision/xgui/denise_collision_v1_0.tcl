# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "CLXCON" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CLXCON2" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CLXDAT" -parent ${Page_0}


}

proc update_PARAM_VALUE.CLXCON { PARAM_VALUE.CLXCON } {
	# Procedure called to update CLXCON when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CLXCON { PARAM_VALUE.CLXCON } {
	# Procedure called to validate CLXCON
	return true
}

proc update_PARAM_VALUE.CLXCON2 { PARAM_VALUE.CLXCON2 } {
	# Procedure called to update CLXCON2 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CLXCON2 { PARAM_VALUE.CLXCON2 } {
	# Procedure called to validate CLXCON2
	return true
}

proc update_PARAM_VALUE.CLXDAT { PARAM_VALUE.CLXDAT } {
	# Procedure called to update CLXDAT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CLXDAT { PARAM_VALUE.CLXDAT } {
	# Procedure called to validate CLXDAT
	return true
}


proc update_MODELPARAM_VALUE.CLXCON { MODELPARAM_VALUE.CLXCON PARAM_VALUE.CLXCON } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CLXCON}] ${MODELPARAM_VALUE.CLXCON}
}

proc update_MODELPARAM_VALUE.CLXCON2 { MODELPARAM_VALUE.CLXCON2 PARAM_VALUE.CLXCON2 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CLXCON2}] ${MODELPARAM_VALUE.CLXCON2}
}

proc update_MODELPARAM_VALUE.CLXDAT { MODELPARAM_VALUE.CLXDAT PARAM_VALUE.CLXDAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CLXDAT}] ${MODELPARAM_VALUE.CLXDAT}
}

