# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "AUDDAT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "AUDIO_STATE_0" -parent ${Page_0}
  ipgui::add_param $IPINST -name "AUDIO_STATE_1" -parent ${Page_0}
  ipgui::add_param $IPINST -name "AUDIO_STATE_2" -parent ${Page_0}
  ipgui::add_param $IPINST -name "AUDIO_STATE_3" -parent ${Page_0}
  ipgui::add_param $IPINST -name "AUDIO_STATE_4" -parent ${Page_0}
  ipgui::add_param $IPINST -name "AUDLEN" -parent ${Page_0}
  ipgui::add_param $IPINST -name "AUDPER" -parent ${Page_0}
  ipgui::add_param $IPINST -name "AUDVOL" -parent ${Page_0}


}

proc update_PARAM_VALUE.AUDDAT { PARAM_VALUE.AUDDAT } {
	# Procedure called to update AUDDAT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AUDDAT { PARAM_VALUE.AUDDAT } {
	# Procedure called to validate AUDDAT
	return true
}

proc update_PARAM_VALUE.AUDIO_STATE_0 { PARAM_VALUE.AUDIO_STATE_0 } {
	# Procedure called to update AUDIO_STATE_0 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AUDIO_STATE_0 { PARAM_VALUE.AUDIO_STATE_0 } {
	# Procedure called to validate AUDIO_STATE_0
	return true
}

proc update_PARAM_VALUE.AUDIO_STATE_1 { PARAM_VALUE.AUDIO_STATE_1 } {
	# Procedure called to update AUDIO_STATE_1 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AUDIO_STATE_1 { PARAM_VALUE.AUDIO_STATE_1 } {
	# Procedure called to validate AUDIO_STATE_1
	return true
}

proc update_PARAM_VALUE.AUDIO_STATE_2 { PARAM_VALUE.AUDIO_STATE_2 } {
	# Procedure called to update AUDIO_STATE_2 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AUDIO_STATE_2 { PARAM_VALUE.AUDIO_STATE_2 } {
	# Procedure called to validate AUDIO_STATE_2
	return true
}

proc update_PARAM_VALUE.AUDIO_STATE_3 { PARAM_VALUE.AUDIO_STATE_3 } {
	# Procedure called to update AUDIO_STATE_3 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AUDIO_STATE_3 { PARAM_VALUE.AUDIO_STATE_3 } {
	# Procedure called to validate AUDIO_STATE_3
	return true
}

proc update_PARAM_VALUE.AUDIO_STATE_4 { PARAM_VALUE.AUDIO_STATE_4 } {
	# Procedure called to update AUDIO_STATE_4 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AUDIO_STATE_4 { PARAM_VALUE.AUDIO_STATE_4 } {
	# Procedure called to validate AUDIO_STATE_4
	return true
}

proc update_PARAM_VALUE.AUDLEN { PARAM_VALUE.AUDLEN } {
	# Procedure called to update AUDLEN when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AUDLEN { PARAM_VALUE.AUDLEN } {
	# Procedure called to validate AUDLEN
	return true
}

proc update_PARAM_VALUE.AUDPER { PARAM_VALUE.AUDPER } {
	# Procedure called to update AUDPER when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AUDPER { PARAM_VALUE.AUDPER } {
	# Procedure called to validate AUDPER
	return true
}

proc update_PARAM_VALUE.AUDVOL { PARAM_VALUE.AUDVOL } {
	# Procedure called to update AUDVOL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AUDVOL { PARAM_VALUE.AUDVOL } {
	# Procedure called to validate AUDVOL
	return true
}


proc update_MODELPARAM_VALUE.AUDLEN { MODELPARAM_VALUE.AUDLEN PARAM_VALUE.AUDLEN } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AUDLEN}] ${MODELPARAM_VALUE.AUDLEN}
}

proc update_MODELPARAM_VALUE.AUDPER { MODELPARAM_VALUE.AUDPER PARAM_VALUE.AUDPER } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AUDPER}] ${MODELPARAM_VALUE.AUDPER}
}

proc update_MODELPARAM_VALUE.AUDVOL { MODELPARAM_VALUE.AUDVOL PARAM_VALUE.AUDVOL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AUDVOL}] ${MODELPARAM_VALUE.AUDVOL}
}

proc update_MODELPARAM_VALUE.AUDDAT { MODELPARAM_VALUE.AUDDAT PARAM_VALUE.AUDDAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AUDDAT}] ${MODELPARAM_VALUE.AUDDAT}
}

proc update_MODELPARAM_VALUE.AUDIO_STATE_0 { MODELPARAM_VALUE.AUDIO_STATE_0 PARAM_VALUE.AUDIO_STATE_0 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AUDIO_STATE_0}] ${MODELPARAM_VALUE.AUDIO_STATE_0}
}

proc update_MODELPARAM_VALUE.AUDIO_STATE_1 { MODELPARAM_VALUE.AUDIO_STATE_1 PARAM_VALUE.AUDIO_STATE_1 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AUDIO_STATE_1}] ${MODELPARAM_VALUE.AUDIO_STATE_1}
}

proc update_MODELPARAM_VALUE.AUDIO_STATE_2 { MODELPARAM_VALUE.AUDIO_STATE_2 PARAM_VALUE.AUDIO_STATE_2 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AUDIO_STATE_2}] ${MODELPARAM_VALUE.AUDIO_STATE_2}
}

proc update_MODELPARAM_VALUE.AUDIO_STATE_3 { MODELPARAM_VALUE.AUDIO_STATE_3 PARAM_VALUE.AUDIO_STATE_3 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AUDIO_STATE_3}] ${MODELPARAM_VALUE.AUDIO_STATE_3}
}

proc update_MODELPARAM_VALUE.AUDIO_STATE_4 { MODELPARAM_VALUE.AUDIO_STATE_4 PARAM_VALUE.AUDIO_STATE_4 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AUDIO_STATE_4}] ${MODELPARAM_VALUE.AUDIO_STATE_4}
}

