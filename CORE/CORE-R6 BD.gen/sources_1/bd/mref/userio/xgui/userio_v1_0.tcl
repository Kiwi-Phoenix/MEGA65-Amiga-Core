# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "JOY0DAT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "JOY1DAT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "JOYTEST" -parent ${Page_0}
  ipgui::add_param $IPINST -name "KEY_DOWN" -parent ${Page_0}
  ipgui::add_param $IPINST -name "KEY_ENTER" -parent ${Page_0}
  ipgui::add_param $IPINST -name "KEY_ESC" -parent ${Page_0}
  ipgui::add_param $IPINST -name "KEY_LEFT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "KEY_MENU" -parent ${Page_0}
  ipgui::add_param $IPINST -name "KEY_PGDOWN" -parent ${Page_0}
  ipgui::add_param $IPINST -name "KEY_PGUP" -parent ${Page_0}
  ipgui::add_param $IPINST -name "KEY_RIGHT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "KEY_UP" -parent ${Page_0}
  ipgui::add_param $IPINST -name "POT0DAT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "POT1DAT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "POTGO" -parent ${Page_0}
  ipgui::add_param $IPINST -name "POTINP" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SCRDAT" -parent ${Page_0}


}

proc update_PARAM_VALUE.JOY0DAT { PARAM_VALUE.JOY0DAT } {
	# Procedure called to update JOY0DAT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.JOY0DAT { PARAM_VALUE.JOY0DAT } {
	# Procedure called to validate JOY0DAT
	return true
}

proc update_PARAM_VALUE.JOY1DAT { PARAM_VALUE.JOY1DAT } {
	# Procedure called to update JOY1DAT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.JOY1DAT { PARAM_VALUE.JOY1DAT } {
	# Procedure called to validate JOY1DAT
	return true
}

proc update_PARAM_VALUE.JOYTEST { PARAM_VALUE.JOYTEST } {
	# Procedure called to update JOYTEST when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.JOYTEST { PARAM_VALUE.JOYTEST } {
	# Procedure called to validate JOYTEST
	return true
}

proc update_PARAM_VALUE.KEY_DOWN { PARAM_VALUE.KEY_DOWN } {
	# Procedure called to update KEY_DOWN when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.KEY_DOWN { PARAM_VALUE.KEY_DOWN } {
	# Procedure called to validate KEY_DOWN
	return true
}

proc update_PARAM_VALUE.KEY_ENTER { PARAM_VALUE.KEY_ENTER } {
	# Procedure called to update KEY_ENTER when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.KEY_ENTER { PARAM_VALUE.KEY_ENTER } {
	# Procedure called to validate KEY_ENTER
	return true
}

proc update_PARAM_VALUE.KEY_ESC { PARAM_VALUE.KEY_ESC } {
	# Procedure called to update KEY_ESC when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.KEY_ESC { PARAM_VALUE.KEY_ESC } {
	# Procedure called to validate KEY_ESC
	return true
}

proc update_PARAM_VALUE.KEY_LEFT { PARAM_VALUE.KEY_LEFT } {
	# Procedure called to update KEY_LEFT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.KEY_LEFT { PARAM_VALUE.KEY_LEFT } {
	# Procedure called to validate KEY_LEFT
	return true
}

proc update_PARAM_VALUE.KEY_MENU { PARAM_VALUE.KEY_MENU } {
	# Procedure called to update KEY_MENU when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.KEY_MENU { PARAM_VALUE.KEY_MENU } {
	# Procedure called to validate KEY_MENU
	return true
}

proc update_PARAM_VALUE.KEY_PGDOWN { PARAM_VALUE.KEY_PGDOWN } {
	# Procedure called to update KEY_PGDOWN when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.KEY_PGDOWN { PARAM_VALUE.KEY_PGDOWN } {
	# Procedure called to validate KEY_PGDOWN
	return true
}

proc update_PARAM_VALUE.KEY_PGUP { PARAM_VALUE.KEY_PGUP } {
	# Procedure called to update KEY_PGUP when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.KEY_PGUP { PARAM_VALUE.KEY_PGUP } {
	# Procedure called to validate KEY_PGUP
	return true
}

proc update_PARAM_VALUE.KEY_RIGHT { PARAM_VALUE.KEY_RIGHT } {
	# Procedure called to update KEY_RIGHT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.KEY_RIGHT { PARAM_VALUE.KEY_RIGHT } {
	# Procedure called to validate KEY_RIGHT
	return true
}

proc update_PARAM_VALUE.KEY_UP { PARAM_VALUE.KEY_UP } {
	# Procedure called to update KEY_UP when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.KEY_UP { PARAM_VALUE.KEY_UP } {
	# Procedure called to validate KEY_UP
	return true
}

proc update_PARAM_VALUE.POT0DAT { PARAM_VALUE.POT0DAT } {
	# Procedure called to update POT0DAT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.POT0DAT { PARAM_VALUE.POT0DAT } {
	# Procedure called to validate POT0DAT
	return true
}

proc update_PARAM_VALUE.POT1DAT { PARAM_VALUE.POT1DAT } {
	# Procedure called to update POT1DAT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.POT1DAT { PARAM_VALUE.POT1DAT } {
	# Procedure called to validate POT1DAT
	return true
}

proc update_PARAM_VALUE.POTGO { PARAM_VALUE.POTGO } {
	# Procedure called to update POTGO when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.POTGO { PARAM_VALUE.POTGO } {
	# Procedure called to validate POTGO
	return true
}

proc update_PARAM_VALUE.POTINP { PARAM_VALUE.POTINP } {
	# Procedure called to update POTINP when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.POTINP { PARAM_VALUE.POTINP } {
	# Procedure called to validate POTINP
	return true
}

proc update_PARAM_VALUE.SCRDAT { PARAM_VALUE.SCRDAT } {
	# Procedure called to update SCRDAT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SCRDAT { PARAM_VALUE.SCRDAT } {
	# Procedure called to validate SCRDAT
	return true
}


proc update_MODELPARAM_VALUE.JOY0DAT { MODELPARAM_VALUE.JOY0DAT PARAM_VALUE.JOY0DAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.JOY0DAT}] ${MODELPARAM_VALUE.JOY0DAT}
}

proc update_MODELPARAM_VALUE.JOY1DAT { MODELPARAM_VALUE.JOY1DAT PARAM_VALUE.JOY1DAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.JOY1DAT}] ${MODELPARAM_VALUE.JOY1DAT}
}

proc update_MODELPARAM_VALUE.SCRDAT { MODELPARAM_VALUE.SCRDAT PARAM_VALUE.SCRDAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SCRDAT}] ${MODELPARAM_VALUE.SCRDAT}
}

proc update_MODELPARAM_VALUE.POT0DAT { MODELPARAM_VALUE.POT0DAT PARAM_VALUE.POT0DAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.POT0DAT}] ${MODELPARAM_VALUE.POT0DAT}
}

proc update_MODELPARAM_VALUE.POT1DAT { MODELPARAM_VALUE.POT1DAT PARAM_VALUE.POT1DAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.POT1DAT}] ${MODELPARAM_VALUE.POT1DAT}
}

proc update_MODELPARAM_VALUE.POTINP { MODELPARAM_VALUE.POTINP PARAM_VALUE.POTINP } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.POTINP}] ${MODELPARAM_VALUE.POTINP}
}

proc update_MODELPARAM_VALUE.POTGO { MODELPARAM_VALUE.POTGO PARAM_VALUE.POTGO } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.POTGO}] ${MODELPARAM_VALUE.POTGO}
}

proc update_MODELPARAM_VALUE.JOYTEST { MODELPARAM_VALUE.JOYTEST PARAM_VALUE.JOYTEST } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.JOYTEST}] ${MODELPARAM_VALUE.JOYTEST}
}

proc update_MODELPARAM_VALUE.KEY_MENU { MODELPARAM_VALUE.KEY_MENU PARAM_VALUE.KEY_MENU } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.KEY_MENU}] ${MODELPARAM_VALUE.KEY_MENU}
}

proc update_MODELPARAM_VALUE.KEY_ESC { MODELPARAM_VALUE.KEY_ESC PARAM_VALUE.KEY_ESC } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.KEY_ESC}] ${MODELPARAM_VALUE.KEY_ESC}
}

proc update_MODELPARAM_VALUE.KEY_ENTER { MODELPARAM_VALUE.KEY_ENTER PARAM_VALUE.KEY_ENTER } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.KEY_ENTER}] ${MODELPARAM_VALUE.KEY_ENTER}
}

proc update_MODELPARAM_VALUE.KEY_UP { MODELPARAM_VALUE.KEY_UP PARAM_VALUE.KEY_UP } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.KEY_UP}] ${MODELPARAM_VALUE.KEY_UP}
}

proc update_MODELPARAM_VALUE.KEY_DOWN { MODELPARAM_VALUE.KEY_DOWN PARAM_VALUE.KEY_DOWN } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.KEY_DOWN}] ${MODELPARAM_VALUE.KEY_DOWN}
}

proc update_MODELPARAM_VALUE.KEY_LEFT { MODELPARAM_VALUE.KEY_LEFT PARAM_VALUE.KEY_LEFT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.KEY_LEFT}] ${MODELPARAM_VALUE.KEY_LEFT}
}

proc update_MODELPARAM_VALUE.KEY_RIGHT { MODELPARAM_VALUE.KEY_RIGHT PARAM_VALUE.KEY_RIGHT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.KEY_RIGHT}] ${MODELPARAM_VALUE.KEY_RIGHT}
}

proc update_MODELPARAM_VALUE.KEY_PGUP { MODELPARAM_VALUE.KEY_PGUP PARAM_VALUE.KEY_PGUP } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.KEY_PGUP}] ${MODELPARAM_VALUE.KEY_PGUP}
}

proc update_MODELPARAM_VALUE.KEY_PGDOWN { MODELPARAM_VALUE.KEY_PGDOWN PARAM_VALUE.KEY_PGDOWN } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.KEY_PGDOWN}] ${MODELPARAM_VALUE.KEY_PGDOWN}
}

