# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "G_ERRATA_ISSI_D_FIX" -parent ${Page_0}


}

proc update_PARAM_VALUE.G_ERRATA_ISSI_D_FIX { PARAM_VALUE.G_ERRATA_ISSI_D_FIX } {
	# Procedure called to update G_ERRATA_ISSI_D_FIX when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.G_ERRATA_ISSI_D_FIX { PARAM_VALUE.G_ERRATA_ISSI_D_FIX } {
	# Procedure called to validate G_ERRATA_ISSI_D_FIX
	return true
}


proc update_MODELPARAM_VALUE.G_ERRATA_ISSI_D_FIX { MODELPARAM_VALUE.G_ERRATA_ISSI_D_FIX PARAM_VALUE.G_ERRATA_ISSI_D_FIX } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G_ERRATA_ISSI_D_FIX}] ${MODELPARAM_VALUE.G_ERRATA_ISSI_D_FIX}
}

