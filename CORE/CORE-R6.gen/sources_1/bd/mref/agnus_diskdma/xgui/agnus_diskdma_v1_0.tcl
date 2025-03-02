# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "DSKDAT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DSKDATR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DSKPTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DSKPTL" -parent ${Page_0}


}

proc update_PARAM_VALUE.DSKDAT { PARAM_VALUE.DSKDAT } {
	# Procedure called to update DSKDAT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DSKDAT { PARAM_VALUE.DSKDAT } {
	# Procedure called to validate DSKDAT
	return true
}

proc update_PARAM_VALUE.DSKDATR { PARAM_VALUE.DSKDATR } {
	# Procedure called to update DSKDATR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DSKDATR { PARAM_VALUE.DSKDATR } {
	# Procedure called to validate DSKDATR
	return true
}

proc update_PARAM_VALUE.DSKPTH { PARAM_VALUE.DSKPTH } {
	# Procedure called to update DSKPTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DSKPTH { PARAM_VALUE.DSKPTH } {
	# Procedure called to validate DSKPTH
	return true
}

proc update_PARAM_VALUE.DSKPTL { PARAM_VALUE.DSKPTL } {
	# Procedure called to update DSKPTL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DSKPTL { PARAM_VALUE.DSKPTL } {
	# Procedure called to validate DSKPTL
	return true
}


proc update_MODELPARAM_VALUE.DSKPTH { MODELPARAM_VALUE.DSKPTH PARAM_VALUE.DSKPTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DSKPTH}] ${MODELPARAM_VALUE.DSKPTH}
}

proc update_MODELPARAM_VALUE.DSKPTL { MODELPARAM_VALUE.DSKPTL PARAM_VALUE.DSKPTL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DSKPTL}] ${MODELPARAM_VALUE.DSKPTL}
}

proc update_MODELPARAM_VALUE.DSKDAT { MODELPARAM_VALUE.DSKDAT PARAM_VALUE.DSKDAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DSKDAT}] ${MODELPARAM_VALUE.DSKDAT}
}

proc update_MODELPARAM_VALUE.DSKDATR { MODELPARAM_VALUE.DSKDATR PARAM_VALUE.DSKDATR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DSKDATR}] ${MODELPARAM_VALUE.DSKDATR}
}

