# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "DISKDMA_ACTIVE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DISKDMA_IDLE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DISKDMA_INT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DSKBYTR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DSKDAT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DSKDATR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DSKLEN" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DSKSYNC" -parent ${Page_0}


}

proc update_PARAM_VALUE.DISKDMA_ACTIVE { PARAM_VALUE.DISKDMA_ACTIVE } {
	# Procedure called to update DISKDMA_ACTIVE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DISKDMA_ACTIVE { PARAM_VALUE.DISKDMA_ACTIVE } {
	# Procedure called to validate DISKDMA_ACTIVE
	return true
}

proc update_PARAM_VALUE.DISKDMA_IDLE { PARAM_VALUE.DISKDMA_IDLE } {
	# Procedure called to update DISKDMA_IDLE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DISKDMA_IDLE { PARAM_VALUE.DISKDMA_IDLE } {
	# Procedure called to validate DISKDMA_IDLE
	return true
}

proc update_PARAM_VALUE.DISKDMA_INT { PARAM_VALUE.DISKDMA_INT } {
	# Procedure called to update DISKDMA_INT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DISKDMA_INT { PARAM_VALUE.DISKDMA_INT } {
	# Procedure called to validate DISKDMA_INT
	return true
}

proc update_PARAM_VALUE.DSKBYTR { PARAM_VALUE.DSKBYTR } {
	# Procedure called to update DSKBYTR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DSKBYTR { PARAM_VALUE.DSKBYTR } {
	# Procedure called to validate DSKBYTR
	return true
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

proc update_PARAM_VALUE.DSKLEN { PARAM_VALUE.DSKLEN } {
	# Procedure called to update DSKLEN when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DSKLEN { PARAM_VALUE.DSKLEN } {
	# Procedure called to validate DSKLEN
	return true
}

proc update_PARAM_VALUE.DSKSYNC { PARAM_VALUE.DSKSYNC } {
	# Procedure called to update DSKSYNC when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DSKSYNC { PARAM_VALUE.DSKSYNC } {
	# Procedure called to validate DSKSYNC
	return true
}


proc update_MODELPARAM_VALUE.DSKBYTR { MODELPARAM_VALUE.DSKBYTR PARAM_VALUE.DSKBYTR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DSKBYTR}] ${MODELPARAM_VALUE.DSKBYTR}
}

proc update_MODELPARAM_VALUE.DSKDAT { MODELPARAM_VALUE.DSKDAT PARAM_VALUE.DSKDAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DSKDAT}] ${MODELPARAM_VALUE.DSKDAT}
}

proc update_MODELPARAM_VALUE.DSKDATR { MODELPARAM_VALUE.DSKDATR PARAM_VALUE.DSKDATR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DSKDATR}] ${MODELPARAM_VALUE.DSKDATR}
}

proc update_MODELPARAM_VALUE.DSKSYNC { MODELPARAM_VALUE.DSKSYNC PARAM_VALUE.DSKSYNC } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DSKSYNC}] ${MODELPARAM_VALUE.DSKSYNC}
}

proc update_MODELPARAM_VALUE.DSKLEN { MODELPARAM_VALUE.DSKLEN PARAM_VALUE.DSKLEN } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DSKLEN}] ${MODELPARAM_VALUE.DSKLEN}
}

proc update_MODELPARAM_VALUE.DISKDMA_IDLE { MODELPARAM_VALUE.DISKDMA_IDLE PARAM_VALUE.DISKDMA_IDLE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DISKDMA_IDLE}] ${MODELPARAM_VALUE.DISKDMA_IDLE}
}

proc update_MODELPARAM_VALUE.DISKDMA_ACTIVE { MODELPARAM_VALUE.DISKDMA_ACTIVE PARAM_VALUE.DISKDMA_ACTIVE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DISKDMA_ACTIVE}] ${MODELPARAM_VALUE.DISKDMA_ACTIVE}
}

proc update_MODELPARAM_VALUE.DISKDMA_INT { MODELPARAM_VALUE.DISKDMA_INT PARAM_VALUE.DISKDMA_INT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DISKDMA_INT}] ${MODELPARAM_VALUE.DISKDMA_INT}
}

