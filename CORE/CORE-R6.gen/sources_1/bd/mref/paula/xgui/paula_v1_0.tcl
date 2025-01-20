# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "ADKCON" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ADKCONR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DMACON" -parent ${Page_0}


}

proc update_PARAM_VALUE.ADKCON { PARAM_VALUE.ADKCON } {
	# Procedure called to update ADKCON when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ADKCON { PARAM_VALUE.ADKCON } {
	# Procedure called to validate ADKCON
	return true
}

proc update_PARAM_VALUE.ADKCONR { PARAM_VALUE.ADKCONR } {
	# Procedure called to update ADKCONR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ADKCONR { PARAM_VALUE.ADKCONR } {
	# Procedure called to validate ADKCONR
	return true
}

proc update_PARAM_VALUE.DMACON { PARAM_VALUE.DMACON } {
	# Procedure called to update DMACON when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DMACON { PARAM_VALUE.DMACON } {
	# Procedure called to validate DMACON
	return true
}


proc update_MODELPARAM_VALUE.DMACON { MODELPARAM_VALUE.DMACON PARAM_VALUE.DMACON } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DMACON}] ${MODELPARAM_VALUE.DMACON}
}

proc update_MODELPARAM_VALUE.ADKCON { MODELPARAM_VALUE.ADKCON PARAM_VALUE.ADKCON } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ADKCON}] ${MODELPARAM_VALUE.ADKCON}
}

proc update_MODELPARAM_VALUE.ADKCONR { MODELPARAM_VALUE.ADKCONR PARAM_VALUE.ADKCONR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ADKCONR}] ${MODELPARAM_VALUE.ADKCONR}
}

