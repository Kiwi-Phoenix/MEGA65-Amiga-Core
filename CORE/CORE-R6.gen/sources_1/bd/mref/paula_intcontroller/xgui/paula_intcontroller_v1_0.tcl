# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "INTENA" -parent ${Page_0}
  ipgui::add_param $IPINST -name "INTENAR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "INTREQ" -parent ${Page_0}
  ipgui::add_param $IPINST -name "INTREQR" -parent ${Page_0}


}

proc update_PARAM_VALUE.INTENA { PARAM_VALUE.INTENA } {
	# Procedure called to update INTENA when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INTENA { PARAM_VALUE.INTENA } {
	# Procedure called to validate INTENA
	return true
}

proc update_PARAM_VALUE.INTENAR { PARAM_VALUE.INTENAR } {
	# Procedure called to update INTENAR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INTENAR { PARAM_VALUE.INTENAR } {
	# Procedure called to validate INTENAR
	return true
}

proc update_PARAM_VALUE.INTREQ { PARAM_VALUE.INTREQ } {
	# Procedure called to update INTREQ when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INTREQ { PARAM_VALUE.INTREQ } {
	# Procedure called to validate INTREQ
	return true
}

proc update_PARAM_VALUE.INTREQR { PARAM_VALUE.INTREQR } {
	# Procedure called to update INTREQR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INTREQR { PARAM_VALUE.INTREQR } {
	# Procedure called to validate INTREQR
	return true
}


proc update_MODELPARAM_VALUE.INTENAR { MODELPARAM_VALUE.INTENAR PARAM_VALUE.INTENAR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INTENAR}] ${MODELPARAM_VALUE.INTENAR}
}

proc update_MODELPARAM_VALUE.INTREQR { MODELPARAM_VALUE.INTREQR PARAM_VALUE.INTREQR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INTREQR}] ${MODELPARAM_VALUE.INTREQR}
}

proc update_MODELPARAM_VALUE.INTENA { MODELPARAM_VALUE.INTENA PARAM_VALUE.INTENA } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INTENA}] ${MODELPARAM_VALUE.INTENA}
}

proc update_MODELPARAM_VALUE.INTREQ { MODELPARAM_VALUE.INTREQ PARAM_VALUE.INTREQ } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INTREQ}] ${MODELPARAM_VALUE.INTREQ}
}

