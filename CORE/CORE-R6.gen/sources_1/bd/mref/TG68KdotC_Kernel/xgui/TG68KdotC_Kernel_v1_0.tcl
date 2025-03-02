# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "BarrelShifter" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BitField" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DIV_Mode" -parent ${Page_0}
  ipgui::add_param $IPINST -name "MUL_Hardware" -parent ${Page_0}
  ipgui::add_param $IPINST -name "MUL_Mode" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SR_Read" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VBR_Stackframe" -parent ${Page_0}
  ipgui::add_param $IPINST -name "extAddr_Mode" -parent ${Page_0}


}

proc update_PARAM_VALUE.BarrelShifter { PARAM_VALUE.BarrelShifter } {
	# Procedure called to update BarrelShifter when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BarrelShifter { PARAM_VALUE.BarrelShifter } {
	# Procedure called to validate BarrelShifter
	return true
}

proc update_PARAM_VALUE.BitField { PARAM_VALUE.BitField } {
	# Procedure called to update BitField when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BitField { PARAM_VALUE.BitField } {
	# Procedure called to validate BitField
	return true
}

proc update_PARAM_VALUE.DIV_Mode { PARAM_VALUE.DIV_Mode } {
	# Procedure called to update DIV_Mode when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DIV_Mode { PARAM_VALUE.DIV_Mode } {
	# Procedure called to validate DIV_Mode
	return true
}

proc update_PARAM_VALUE.MUL_Hardware { PARAM_VALUE.MUL_Hardware } {
	# Procedure called to update MUL_Hardware when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MUL_Hardware { PARAM_VALUE.MUL_Hardware } {
	# Procedure called to validate MUL_Hardware
	return true
}

proc update_PARAM_VALUE.MUL_Mode { PARAM_VALUE.MUL_Mode } {
	# Procedure called to update MUL_Mode when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MUL_Mode { PARAM_VALUE.MUL_Mode } {
	# Procedure called to validate MUL_Mode
	return true
}

proc update_PARAM_VALUE.SR_Read { PARAM_VALUE.SR_Read } {
	# Procedure called to update SR_Read when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SR_Read { PARAM_VALUE.SR_Read } {
	# Procedure called to validate SR_Read
	return true
}

proc update_PARAM_VALUE.VBR_Stackframe { PARAM_VALUE.VBR_Stackframe } {
	# Procedure called to update VBR_Stackframe when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VBR_Stackframe { PARAM_VALUE.VBR_Stackframe } {
	# Procedure called to validate VBR_Stackframe
	return true
}

proc update_PARAM_VALUE.extAddr_Mode { PARAM_VALUE.extAddr_Mode } {
	# Procedure called to update extAddr_Mode when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.extAddr_Mode { PARAM_VALUE.extAddr_Mode } {
	# Procedure called to validate extAddr_Mode
	return true
}


proc update_MODELPARAM_VALUE.SR_Read { MODELPARAM_VALUE.SR_Read PARAM_VALUE.SR_Read } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SR_Read}] ${MODELPARAM_VALUE.SR_Read}
}

proc update_MODELPARAM_VALUE.VBR_Stackframe { MODELPARAM_VALUE.VBR_Stackframe PARAM_VALUE.VBR_Stackframe } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VBR_Stackframe}] ${MODELPARAM_VALUE.VBR_Stackframe}
}

proc update_MODELPARAM_VALUE.extAddr_Mode { MODELPARAM_VALUE.extAddr_Mode PARAM_VALUE.extAddr_Mode } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.extAddr_Mode}] ${MODELPARAM_VALUE.extAddr_Mode}
}

proc update_MODELPARAM_VALUE.MUL_Mode { MODELPARAM_VALUE.MUL_Mode PARAM_VALUE.MUL_Mode } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MUL_Mode}] ${MODELPARAM_VALUE.MUL_Mode}
}

proc update_MODELPARAM_VALUE.DIV_Mode { MODELPARAM_VALUE.DIV_Mode PARAM_VALUE.DIV_Mode } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DIV_Mode}] ${MODELPARAM_VALUE.DIV_Mode}
}

proc update_MODELPARAM_VALUE.BitField { MODELPARAM_VALUE.BitField PARAM_VALUE.BitField } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BitField}] ${MODELPARAM_VALUE.BitField}
}

proc update_MODELPARAM_VALUE.BarrelShifter { MODELPARAM_VALUE.BarrelShifter PARAM_VALUE.BarrelShifter } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BarrelShifter}] ${MODELPARAM_VALUE.BarrelShifter}
}

proc update_MODELPARAM_VALUE.MUL_Hardware { MODELPARAM_VALUE.MUL_Hardware PARAM_VALUE.MUL_Hardware } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MUL_Hardware}] ${MODELPARAM_VALUE.MUL_Hardware}
}

