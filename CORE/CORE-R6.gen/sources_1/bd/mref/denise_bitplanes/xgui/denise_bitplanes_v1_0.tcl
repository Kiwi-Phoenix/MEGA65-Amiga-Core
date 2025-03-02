# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "BPL1DAT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BPL2DAT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BPL3DAT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BPL4DAT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BPL5DAT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BPL6DAT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BPL7DAT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BPL8DAT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BPLCON1" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FMODE" -parent ${Page_0}


}

proc update_PARAM_VALUE.BPL1DAT { PARAM_VALUE.BPL1DAT } {
	# Procedure called to update BPL1DAT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BPL1DAT { PARAM_VALUE.BPL1DAT } {
	# Procedure called to validate BPL1DAT
	return true
}

proc update_PARAM_VALUE.BPL2DAT { PARAM_VALUE.BPL2DAT } {
	# Procedure called to update BPL2DAT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BPL2DAT { PARAM_VALUE.BPL2DAT } {
	# Procedure called to validate BPL2DAT
	return true
}

proc update_PARAM_VALUE.BPL3DAT { PARAM_VALUE.BPL3DAT } {
	# Procedure called to update BPL3DAT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BPL3DAT { PARAM_VALUE.BPL3DAT } {
	# Procedure called to validate BPL3DAT
	return true
}

proc update_PARAM_VALUE.BPL4DAT { PARAM_VALUE.BPL4DAT } {
	# Procedure called to update BPL4DAT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BPL4DAT { PARAM_VALUE.BPL4DAT } {
	# Procedure called to validate BPL4DAT
	return true
}

proc update_PARAM_VALUE.BPL5DAT { PARAM_VALUE.BPL5DAT } {
	# Procedure called to update BPL5DAT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BPL5DAT { PARAM_VALUE.BPL5DAT } {
	# Procedure called to validate BPL5DAT
	return true
}

proc update_PARAM_VALUE.BPL6DAT { PARAM_VALUE.BPL6DAT } {
	# Procedure called to update BPL6DAT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BPL6DAT { PARAM_VALUE.BPL6DAT } {
	# Procedure called to validate BPL6DAT
	return true
}

proc update_PARAM_VALUE.BPL7DAT { PARAM_VALUE.BPL7DAT } {
	# Procedure called to update BPL7DAT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BPL7DAT { PARAM_VALUE.BPL7DAT } {
	# Procedure called to validate BPL7DAT
	return true
}

proc update_PARAM_VALUE.BPL8DAT { PARAM_VALUE.BPL8DAT } {
	# Procedure called to update BPL8DAT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BPL8DAT { PARAM_VALUE.BPL8DAT } {
	# Procedure called to validate BPL8DAT
	return true
}

proc update_PARAM_VALUE.BPLCON1 { PARAM_VALUE.BPLCON1 } {
	# Procedure called to update BPLCON1 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BPLCON1 { PARAM_VALUE.BPLCON1 } {
	# Procedure called to validate BPLCON1
	return true
}

proc update_PARAM_VALUE.FMODE { PARAM_VALUE.FMODE } {
	# Procedure called to update FMODE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FMODE { PARAM_VALUE.FMODE } {
	# Procedure called to validate FMODE
	return true
}


proc update_MODELPARAM_VALUE.BPLCON1 { MODELPARAM_VALUE.BPLCON1 PARAM_VALUE.BPLCON1 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BPLCON1}] ${MODELPARAM_VALUE.BPLCON1}
}

proc update_MODELPARAM_VALUE.BPL1DAT { MODELPARAM_VALUE.BPL1DAT PARAM_VALUE.BPL1DAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BPL1DAT}] ${MODELPARAM_VALUE.BPL1DAT}
}

proc update_MODELPARAM_VALUE.BPL2DAT { MODELPARAM_VALUE.BPL2DAT PARAM_VALUE.BPL2DAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BPL2DAT}] ${MODELPARAM_VALUE.BPL2DAT}
}

proc update_MODELPARAM_VALUE.BPL3DAT { MODELPARAM_VALUE.BPL3DAT PARAM_VALUE.BPL3DAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BPL3DAT}] ${MODELPARAM_VALUE.BPL3DAT}
}

proc update_MODELPARAM_VALUE.BPL4DAT { MODELPARAM_VALUE.BPL4DAT PARAM_VALUE.BPL4DAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BPL4DAT}] ${MODELPARAM_VALUE.BPL4DAT}
}

proc update_MODELPARAM_VALUE.BPL5DAT { MODELPARAM_VALUE.BPL5DAT PARAM_VALUE.BPL5DAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BPL5DAT}] ${MODELPARAM_VALUE.BPL5DAT}
}

proc update_MODELPARAM_VALUE.BPL6DAT { MODELPARAM_VALUE.BPL6DAT PARAM_VALUE.BPL6DAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BPL6DAT}] ${MODELPARAM_VALUE.BPL6DAT}
}

proc update_MODELPARAM_VALUE.BPL7DAT { MODELPARAM_VALUE.BPL7DAT PARAM_VALUE.BPL7DAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BPL7DAT}] ${MODELPARAM_VALUE.BPL7DAT}
}

proc update_MODELPARAM_VALUE.BPL8DAT { MODELPARAM_VALUE.BPL8DAT PARAM_VALUE.BPL8DAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BPL8DAT}] ${MODELPARAM_VALUE.BPL8DAT}
}

proc update_MODELPARAM_VALUE.FMODE { MODELPARAM_VALUE.FMODE PARAM_VALUE.FMODE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FMODE}] ${MODELPARAM_VALUE.FMODE}
}

