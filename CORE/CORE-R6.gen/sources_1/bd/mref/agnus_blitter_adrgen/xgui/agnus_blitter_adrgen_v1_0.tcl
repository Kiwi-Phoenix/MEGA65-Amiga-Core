# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "BLTAMOD" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLTAPTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLTAPTL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLTBMOD" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLTBPTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLTBPTL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLTCMOD" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLTCPTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLTCPTL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLTDMOD" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLTDPTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BLTDPTL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CHA" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CHB" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CHC" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CHD" -parent ${Page_0}


}

proc update_PARAM_VALUE.BLTAMOD { PARAM_VALUE.BLTAMOD } {
	# Procedure called to update BLTAMOD when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLTAMOD { PARAM_VALUE.BLTAMOD } {
	# Procedure called to validate BLTAMOD
	return true
}

proc update_PARAM_VALUE.BLTAPTH { PARAM_VALUE.BLTAPTH } {
	# Procedure called to update BLTAPTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLTAPTH { PARAM_VALUE.BLTAPTH } {
	# Procedure called to validate BLTAPTH
	return true
}

proc update_PARAM_VALUE.BLTAPTL { PARAM_VALUE.BLTAPTL } {
	# Procedure called to update BLTAPTL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLTAPTL { PARAM_VALUE.BLTAPTL } {
	# Procedure called to validate BLTAPTL
	return true
}

proc update_PARAM_VALUE.BLTBMOD { PARAM_VALUE.BLTBMOD } {
	# Procedure called to update BLTBMOD when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLTBMOD { PARAM_VALUE.BLTBMOD } {
	# Procedure called to validate BLTBMOD
	return true
}

proc update_PARAM_VALUE.BLTBPTH { PARAM_VALUE.BLTBPTH } {
	# Procedure called to update BLTBPTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLTBPTH { PARAM_VALUE.BLTBPTH } {
	# Procedure called to validate BLTBPTH
	return true
}

proc update_PARAM_VALUE.BLTBPTL { PARAM_VALUE.BLTBPTL } {
	# Procedure called to update BLTBPTL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLTBPTL { PARAM_VALUE.BLTBPTL } {
	# Procedure called to validate BLTBPTL
	return true
}

proc update_PARAM_VALUE.BLTCMOD { PARAM_VALUE.BLTCMOD } {
	# Procedure called to update BLTCMOD when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLTCMOD { PARAM_VALUE.BLTCMOD } {
	# Procedure called to validate BLTCMOD
	return true
}

proc update_PARAM_VALUE.BLTCPTH { PARAM_VALUE.BLTCPTH } {
	# Procedure called to update BLTCPTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLTCPTH { PARAM_VALUE.BLTCPTH } {
	# Procedure called to validate BLTCPTH
	return true
}

proc update_PARAM_VALUE.BLTCPTL { PARAM_VALUE.BLTCPTL } {
	# Procedure called to update BLTCPTL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLTCPTL { PARAM_VALUE.BLTCPTL } {
	# Procedure called to validate BLTCPTL
	return true
}

proc update_PARAM_VALUE.BLTDMOD { PARAM_VALUE.BLTDMOD } {
	# Procedure called to update BLTDMOD when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLTDMOD { PARAM_VALUE.BLTDMOD } {
	# Procedure called to validate BLTDMOD
	return true
}

proc update_PARAM_VALUE.BLTDPTH { PARAM_VALUE.BLTDPTH } {
	# Procedure called to update BLTDPTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLTDPTH { PARAM_VALUE.BLTDPTH } {
	# Procedure called to validate BLTDPTH
	return true
}

proc update_PARAM_VALUE.BLTDPTL { PARAM_VALUE.BLTDPTL } {
	# Procedure called to update BLTDPTL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLTDPTL { PARAM_VALUE.BLTDPTL } {
	# Procedure called to validate BLTDPTL
	return true
}

proc update_PARAM_VALUE.CHA { PARAM_VALUE.CHA } {
	# Procedure called to update CHA when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CHA { PARAM_VALUE.CHA } {
	# Procedure called to validate CHA
	return true
}

proc update_PARAM_VALUE.CHB { PARAM_VALUE.CHB } {
	# Procedure called to update CHB when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CHB { PARAM_VALUE.CHB } {
	# Procedure called to validate CHB
	return true
}

proc update_PARAM_VALUE.CHC { PARAM_VALUE.CHC } {
	# Procedure called to update CHC when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CHC { PARAM_VALUE.CHC } {
	# Procedure called to validate CHC
	return true
}

proc update_PARAM_VALUE.CHD { PARAM_VALUE.CHD } {
	# Procedure called to update CHD when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CHD { PARAM_VALUE.CHD } {
	# Procedure called to validate CHD
	return true
}


proc update_MODELPARAM_VALUE.BLTAMOD { MODELPARAM_VALUE.BLTAMOD PARAM_VALUE.BLTAMOD } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLTAMOD}] ${MODELPARAM_VALUE.BLTAMOD}
}

proc update_MODELPARAM_VALUE.BLTBMOD { MODELPARAM_VALUE.BLTBMOD PARAM_VALUE.BLTBMOD } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLTBMOD}] ${MODELPARAM_VALUE.BLTBMOD}
}

proc update_MODELPARAM_VALUE.BLTCMOD { MODELPARAM_VALUE.BLTCMOD PARAM_VALUE.BLTCMOD } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLTCMOD}] ${MODELPARAM_VALUE.BLTCMOD}
}

proc update_MODELPARAM_VALUE.BLTDMOD { MODELPARAM_VALUE.BLTDMOD PARAM_VALUE.BLTDMOD } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLTDMOD}] ${MODELPARAM_VALUE.BLTDMOD}
}

proc update_MODELPARAM_VALUE.BLTAPTH { MODELPARAM_VALUE.BLTAPTH PARAM_VALUE.BLTAPTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLTAPTH}] ${MODELPARAM_VALUE.BLTAPTH}
}

proc update_MODELPARAM_VALUE.BLTAPTL { MODELPARAM_VALUE.BLTAPTL PARAM_VALUE.BLTAPTL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLTAPTL}] ${MODELPARAM_VALUE.BLTAPTL}
}

proc update_MODELPARAM_VALUE.BLTBPTH { MODELPARAM_VALUE.BLTBPTH PARAM_VALUE.BLTBPTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLTBPTH}] ${MODELPARAM_VALUE.BLTBPTH}
}

proc update_MODELPARAM_VALUE.BLTBPTL { MODELPARAM_VALUE.BLTBPTL PARAM_VALUE.BLTBPTL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLTBPTL}] ${MODELPARAM_VALUE.BLTBPTL}
}

proc update_MODELPARAM_VALUE.BLTCPTH { MODELPARAM_VALUE.BLTCPTH PARAM_VALUE.BLTCPTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLTCPTH}] ${MODELPARAM_VALUE.BLTCPTH}
}

proc update_MODELPARAM_VALUE.BLTCPTL { MODELPARAM_VALUE.BLTCPTL PARAM_VALUE.BLTCPTL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLTCPTL}] ${MODELPARAM_VALUE.BLTCPTL}
}

proc update_MODELPARAM_VALUE.BLTDPTH { MODELPARAM_VALUE.BLTDPTH PARAM_VALUE.BLTDPTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLTDPTH}] ${MODELPARAM_VALUE.BLTDPTH}
}

proc update_MODELPARAM_VALUE.BLTDPTL { MODELPARAM_VALUE.BLTDPTL PARAM_VALUE.BLTDPTL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLTDPTL}] ${MODELPARAM_VALUE.BLTDPTL}
}

proc update_MODELPARAM_VALUE.CHA { MODELPARAM_VALUE.CHA PARAM_VALUE.CHA } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CHA}] ${MODELPARAM_VALUE.CHA}
}

proc update_MODELPARAM_VALUE.CHB { MODELPARAM_VALUE.CHB PARAM_VALUE.CHB } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CHB}] ${MODELPARAM_VALUE.CHB}
}

proc update_MODELPARAM_VALUE.CHC { MODELPARAM_VALUE.CHC PARAM_VALUE.CHC } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CHC}] ${MODELPARAM_VALUE.CHC}
}

proc update_MODELPARAM_VALUE.CHD { MODELPARAM_VALUE.CHD PARAM_VALUE.CHD } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CHD}] ${MODELPARAM_VALUE.CHD}
}

