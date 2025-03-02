# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "GD_HRAM" -parent ${Page_0}
  ipgui::add_param $IPINST -name "GD_PORE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "GD_SWITCHES" -parent ${Page_0}
  ipgui::add_param $IPINST -name "GD_TIL" -parent ${Page_0}


}

proc update_PARAM_VALUE.GD_HRAM { PARAM_VALUE.GD_HRAM } {
	# Procedure called to update GD_HRAM when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.GD_HRAM { PARAM_VALUE.GD_HRAM } {
	# Procedure called to validate GD_HRAM
	return true
}

proc update_PARAM_VALUE.GD_PORE { PARAM_VALUE.GD_PORE } {
	# Procedure called to update GD_PORE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.GD_PORE { PARAM_VALUE.GD_PORE } {
	# Procedure called to validate GD_PORE
	return true
}

proc update_PARAM_VALUE.GD_SWITCHES { PARAM_VALUE.GD_SWITCHES } {
	# Procedure called to update GD_SWITCHES when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.GD_SWITCHES { PARAM_VALUE.GD_SWITCHES } {
	# Procedure called to validate GD_SWITCHES
	return true
}

proc update_PARAM_VALUE.GD_TIL { PARAM_VALUE.GD_TIL } {
	# Procedure called to update GD_TIL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.GD_TIL { PARAM_VALUE.GD_TIL } {
	# Procedure called to validate GD_TIL
	return true
}


proc update_MODELPARAM_VALUE.GD_TIL { MODELPARAM_VALUE.GD_TIL PARAM_VALUE.GD_TIL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.GD_TIL}] ${MODELPARAM_VALUE.GD_TIL}
}

proc update_MODELPARAM_VALUE.GD_SWITCHES { MODELPARAM_VALUE.GD_SWITCHES PARAM_VALUE.GD_SWITCHES } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.GD_SWITCHES}] ${MODELPARAM_VALUE.GD_SWITCHES}
}

proc update_MODELPARAM_VALUE.GD_HRAM { MODELPARAM_VALUE.GD_HRAM PARAM_VALUE.GD_HRAM } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.GD_HRAM}] ${MODELPARAM_VALUE.GD_HRAM}
}

proc update_MODELPARAM_VALUE.GD_PORE { MODELPARAM_VALUE.GD_PORE PARAM_VALUE.GD_PORE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.GD_PORE}] ${MODELPARAM_VALUE.GD_PORE}
}

