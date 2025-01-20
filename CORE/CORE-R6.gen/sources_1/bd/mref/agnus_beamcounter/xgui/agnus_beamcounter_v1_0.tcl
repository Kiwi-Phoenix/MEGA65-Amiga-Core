# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "BEAMCON0" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BPLCON0" -parent ${Page_0}
  ipgui::add_param $IPINST -name "HBSTOP" -parent ${Page_0}
  ipgui::add_param $IPINST -name "HBSTOP_VAL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "HBSTRT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "HBSTRT_VAL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "HCENTER" -parent ${Page_0}
  ipgui::add_param $IPINST -name "HCENTER_VAL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "HSSTOP" -parent ${Page_0}
  ipgui::add_param $IPINST -name "HSSTOP_VAL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "HSSTRT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "HSSTRT_VAL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "HTOTAL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "HTOTAL_VAL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VBSTOP" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VBSTOP_NTSC_VAL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VBSTOP_PAL_VAL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VBSTRT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VBSTRT_VAL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VHPOSR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VHPOSW" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VPOSR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VPOSW" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VSSTOP" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VSSTOP_VAL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VSSTRT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VSSTRT_VAL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VTOTAL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VTOTAL_NTSC_VAL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VTOTAL_PAL_VAL" -parent ${Page_0}


}

proc update_PARAM_VALUE.BEAMCON0 { PARAM_VALUE.BEAMCON0 } {
	# Procedure called to update BEAMCON0 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BEAMCON0 { PARAM_VALUE.BEAMCON0 } {
	# Procedure called to validate BEAMCON0
	return true
}

proc update_PARAM_VALUE.BPLCON0 { PARAM_VALUE.BPLCON0 } {
	# Procedure called to update BPLCON0 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BPLCON0 { PARAM_VALUE.BPLCON0 } {
	# Procedure called to validate BPLCON0
	return true
}

proc update_PARAM_VALUE.HBSTOP { PARAM_VALUE.HBSTOP } {
	# Procedure called to update HBSTOP when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.HBSTOP { PARAM_VALUE.HBSTOP } {
	# Procedure called to validate HBSTOP
	return true
}

proc update_PARAM_VALUE.HBSTOP_VAL { PARAM_VALUE.HBSTOP_VAL } {
	# Procedure called to update HBSTOP_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.HBSTOP_VAL { PARAM_VALUE.HBSTOP_VAL } {
	# Procedure called to validate HBSTOP_VAL
	return true
}

proc update_PARAM_VALUE.HBSTRT { PARAM_VALUE.HBSTRT } {
	# Procedure called to update HBSTRT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.HBSTRT { PARAM_VALUE.HBSTRT } {
	# Procedure called to validate HBSTRT
	return true
}

proc update_PARAM_VALUE.HBSTRT_VAL { PARAM_VALUE.HBSTRT_VAL } {
	# Procedure called to update HBSTRT_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.HBSTRT_VAL { PARAM_VALUE.HBSTRT_VAL } {
	# Procedure called to validate HBSTRT_VAL
	return true
}

proc update_PARAM_VALUE.HCENTER { PARAM_VALUE.HCENTER } {
	# Procedure called to update HCENTER when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.HCENTER { PARAM_VALUE.HCENTER } {
	# Procedure called to validate HCENTER
	return true
}

proc update_PARAM_VALUE.HCENTER_VAL { PARAM_VALUE.HCENTER_VAL } {
	# Procedure called to update HCENTER_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.HCENTER_VAL { PARAM_VALUE.HCENTER_VAL } {
	# Procedure called to validate HCENTER_VAL
	return true
}

proc update_PARAM_VALUE.HSSTOP { PARAM_VALUE.HSSTOP } {
	# Procedure called to update HSSTOP when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.HSSTOP { PARAM_VALUE.HSSTOP } {
	# Procedure called to validate HSSTOP
	return true
}

proc update_PARAM_VALUE.HSSTOP_VAL { PARAM_VALUE.HSSTOP_VAL } {
	# Procedure called to update HSSTOP_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.HSSTOP_VAL { PARAM_VALUE.HSSTOP_VAL } {
	# Procedure called to validate HSSTOP_VAL
	return true
}

proc update_PARAM_VALUE.HSSTRT { PARAM_VALUE.HSSTRT } {
	# Procedure called to update HSSTRT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.HSSTRT { PARAM_VALUE.HSSTRT } {
	# Procedure called to validate HSSTRT
	return true
}

proc update_PARAM_VALUE.HSSTRT_VAL { PARAM_VALUE.HSSTRT_VAL } {
	# Procedure called to update HSSTRT_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.HSSTRT_VAL { PARAM_VALUE.HSSTRT_VAL } {
	# Procedure called to validate HSSTRT_VAL
	return true
}

proc update_PARAM_VALUE.HTOTAL { PARAM_VALUE.HTOTAL } {
	# Procedure called to update HTOTAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.HTOTAL { PARAM_VALUE.HTOTAL } {
	# Procedure called to validate HTOTAL
	return true
}

proc update_PARAM_VALUE.HTOTAL_VAL { PARAM_VALUE.HTOTAL_VAL } {
	# Procedure called to update HTOTAL_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.HTOTAL_VAL { PARAM_VALUE.HTOTAL_VAL } {
	# Procedure called to validate HTOTAL_VAL
	return true
}

proc update_PARAM_VALUE.VBSTOP { PARAM_VALUE.VBSTOP } {
	# Procedure called to update VBSTOP when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VBSTOP { PARAM_VALUE.VBSTOP } {
	# Procedure called to validate VBSTOP
	return true
}

proc update_PARAM_VALUE.VBSTOP_NTSC_VAL { PARAM_VALUE.VBSTOP_NTSC_VAL } {
	# Procedure called to update VBSTOP_NTSC_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VBSTOP_NTSC_VAL { PARAM_VALUE.VBSTOP_NTSC_VAL } {
	# Procedure called to validate VBSTOP_NTSC_VAL
	return true
}

proc update_PARAM_VALUE.VBSTOP_PAL_VAL { PARAM_VALUE.VBSTOP_PAL_VAL } {
	# Procedure called to update VBSTOP_PAL_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VBSTOP_PAL_VAL { PARAM_VALUE.VBSTOP_PAL_VAL } {
	# Procedure called to validate VBSTOP_PAL_VAL
	return true
}

proc update_PARAM_VALUE.VBSTRT { PARAM_VALUE.VBSTRT } {
	# Procedure called to update VBSTRT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VBSTRT { PARAM_VALUE.VBSTRT } {
	# Procedure called to validate VBSTRT
	return true
}

proc update_PARAM_VALUE.VBSTRT_VAL { PARAM_VALUE.VBSTRT_VAL } {
	# Procedure called to update VBSTRT_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VBSTRT_VAL { PARAM_VALUE.VBSTRT_VAL } {
	# Procedure called to validate VBSTRT_VAL
	return true
}

proc update_PARAM_VALUE.VHPOSR { PARAM_VALUE.VHPOSR } {
	# Procedure called to update VHPOSR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VHPOSR { PARAM_VALUE.VHPOSR } {
	# Procedure called to validate VHPOSR
	return true
}

proc update_PARAM_VALUE.VHPOSW { PARAM_VALUE.VHPOSW } {
	# Procedure called to update VHPOSW when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VHPOSW { PARAM_VALUE.VHPOSW } {
	# Procedure called to validate VHPOSW
	return true
}

proc update_PARAM_VALUE.VPOSR { PARAM_VALUE.VPOSR } {
	# Procedure called to update VPOSR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VPOSR { PARAM_VALUE.VPOSR } {
	# Procedure called to validate VPOSR
	return true
}

proc update_PARAM_VALUE.VPOSW { PARAM_VALUE.VPOSW } {
	# Procedure called to update VPOSW when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VPOSW { PARAM_VALUE.VPOSW } {
	# Procedure called to validate VPOSW
	return true
}

proc update_PARAM_VALUE.VSSTOP { PARAM_VALUE.VSSTOP } {
	# Procedure called to update VSSTOP when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VSSTOP { PARAM_VALUE.VSSTOP } {
	# Procedure called to validate VSSTOP
	return true
}

proc update_PARAM_VALUE.VSSTOP_VAL { PARAM_VALUE.VSSTOP_VAL } {
	# Procedure called to update VSSTOP_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VSSTOP_VAL { PARAM_VALUE.VSSTOP_VAL } {
	# Procedure called to validate VSSTOP_VAL
	return true
}

proc update_PARAM_VALUE.VSSTRT { PARAM_VALUE.VSSTRT } {
	# Procedure called to update VSSTRT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VSSTRT { PARAM_VALUE.VSSTRT } {
	# Procedure called to validate VSSTRT
	return true
}

proc update_PARAM_VALUE.VSSTRT_VAL { PARAM_VALUE.VSSTRT_VAL } {
	# Procedure called to update VSSTRT_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VSSTRT_VAL { PARAM_VALUE.VSSTRT_VAL } {
	# Procedure called to validate VSSTRT_VAL
	return true
}

proc update_PARAM_VALUE.VTOTAL { PARAM_VALUE.VTOTAL } {
	# Procedure called to update VTOTAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VTOTAL { PARAM_VALUE.VTOTAL } {
	# Procedure called to validate VTOTAL
	return true
}

proc update_PARAM_VALUE.VTOTAL_NTSC_VAL { PARAM_VALUE.VTOTAL_NTSC_VAL } {
	# Procedure called to update VTOTAL_NTSC_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VTOTAL_NTSC_VAL { PARAM_VALUE.VTOTAL_NTSC_VAL } {
	# Procedure called to validate VTOTAL_NTSC_VAL
	return true
}

proc update_PARAM_VALUE.VTOTAL_PAL_VAL { PARAM_VALUE.VTOTAL_PAL_VAL } {
	# Procedure called to update VTOTAL_PAL_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VTOTAL_PAL_VAL { PARAM_VALUE.VTOTAL_PAL_VAL } {
	# Procedure called to validate VTOTAL_PAL_VAL
	return true
}


proc update_MODELPARAM_VALUE.VPOSR { MODELPARAM_VALUE.VPOSR PARAM_VALUE.VPOSR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VPOSR}] ${MODELPARAM_VALUE.VPOSR}
}

proc update_MODELPARAM_VALUE.VPOSW { MODELPARAM_VALUE.VPOSW PARAM_VALUE.VPOSW } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VPOSW}] ${MODELPARAM_VALUE.VPOSW}
}

proc update_MODELPARAM_VALUE.VHPOSR { MODELPARAM_VALUE.VHPOSR PARAM_VALUE.VHPOSR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VHPOSR}] ${MODELPARAM_VALUE.VHPOSR}
}

proc update_MODELPARAM_VALUE.VHPOSW { MODELPARAM_VALUE.VHPOSW PARAM_VALUE.VHPOSW } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VHPOSW}] ${MODELPARAM_VALUE.VHPOSW}
}

proc update_MODELPARAM_VALUE.BPLCON0 { MODELPARAM_VALUE.BPLCON0 PARAM_VALUE.BPLCON0 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BPLCON0}] ${MODELPARAM_VALUE.BPLCON0}
}

proc update_MODELPARAM_VALUE.HTOTAL { MODELPARAM_VALUE.HTOTAL PARAM_VALUE.HTOTAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.HTOTAL}] ${MODELPARAM_VALUE.HTOTAL}
}

proc update_MODELPARAM_VALUE.HSSTOP { MODELPARAM_VALUE.HSSTOP PARAM_VALUE.HSSTOP } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.HSSTOP}] ${MODELPARAM_VALUE.HSSTOP}
}

proc update_MODELPARAM_VALUE.HBSTRT { MODELPARAM_VALUE.HBSTRT PARAM_VALUE.HBSTRT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.HBSTRT}] ${MODELPARAM_VALUE.HBSTRT}
}

proc update_MODELPARAM_VALUE.HBSTOP { MODELPARAM_VALUE.HBSTOP PARAM_VALUE.HBSTOP } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.HBSTOP}] ${MODELPARAM_VALUE.HBSTOP}
}

proc update_MODELPARAM_VALUE.VTOTAL { MODELPARAM_VALUE.VTOTAL PARAM_VALUE.VTOTAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VTOTAL}] ${MODELPARAM_VALUE.VTOTAL}
}

proc update_MODELPARAM_VALUE.VSSTOP { MODELPARAM_VALUE.VSSTOP PARAM_VALUE.VSSTOP } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VSSTOP}] ${MODELPARAM_VALUE.VSSTOP}
}

proc update_MODELPARAM_VALUE.VBSTRT { MODELPARAM_VALUE.VBSTRT PARAM_VALUE.VBSTRT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VBSTRT}] ${MODELPARAM_VALUE.VBSTRT}
}

proc update_MODELPARAM_VALUE.VBSTOP { MODELPARAM_VALUE.VBSTOP PARAM_VALUE.VBSTOP } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VBSTOP}] ${MODELPARAM_VALUE.VBSTOP}
}

proc update_MODELPARAM_VALUE.HSSTRT { MODELPARAM_VALUE.HSSTRT PARAM_VALUE.HSSTRT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.HSSTRT}] ${MODELPARAM_VALUE.HSSTRT}
}

proc update_MODELPARAM_VALUE.BEAMCON0 { MODELPARAM_VALUE.BEAMCON0 PARAM_VALUE.BEAMCON0 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BEAMCON0}] ${MODELPARAM_VALUE.BEAMCON0}
}

proc update_MODELPARAM_VALUE.VSSTRT { MODELPARAM_VALUE.VSSTRT PARAM_VALUE.VSSTRT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VSSTRT}] ${MODELPARAM_VALUE.VSSTRT}
}

proc update_MODELPARAM_VALUE.HCENTER { MODELPARAM_VALUE.HCENTER PARAM_VALUE.HCENTER } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.HCENTER}] ${MODELPARAM_VALUE.HCENTER}
}

proc update_MODELPARAM_VALUE.HBSTRT_VAL { MODELPARAM_VALUE.HBSTRT_VAL PARAM_VALUE.HBSTRT_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.HBSTRT_VAL}] ${MODELPARAM_VALUE.HBSTRT_VAL}
}

proc update_MODELPARAM_VALUE.HSSTRT_VAL { MODELPARAM_VALUE.HSSTRT_VAL PARAM_VALUE.HSSTRT_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.HSSTRT_VAL}] ${MODELPARAM_VALUE.HSSTRT_VAL}
}

proc update_MODELPARAM_VALUE.HSSTOP_VAL { MODELPARAM_VALUE.HSSTOP_VAL PARAM_VALUE.HSSTOP_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.HSSTOP_VAL}] ${MODELPARAM_VALUE.HSSTOP_VAL}
}

proc update_MODELPARAM_VALUE.HBSTOP_VAL { MODELPARAM_VALUE.HBSTOP_VAL PARAM_VALUE.HBSTOP_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.HBSTOP_VAL}] ${MODELPARAM_VALUE.HBSTOP_VAL}
}

proc update_MODELPARAM_VALUE.HCENTER_VAL { MODELPARAM_VALUE.HCENTER_VAL PARAM_VALUE.HCENTER_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.HCENTER_VAL}] ${MODELPARAM_VALUE.HCENTER_VAL}
}

proc update_MODELPARAM_VALUE.VSSTRT_VAL { MODELPARAM_VALUE.VSSTRT_VAL PARAM_VALUE.VSSTRT_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VSSTRT_VAL}] ${MODELPARAM_VALUE.VSSTRT_VAL}
}

proc update_MODELPARAM_VALUE.VSSTOP_VAL { MODELPARAM_VALUE.VSSTOP_VAL PARAM_VALUE.VSSTOP_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VSSTOP_VAL}] ${MODELPARAM_VALUE.VSSTOP_VAL}
}

proc update_MODELPARAM_VALUE.VBSTRT_VAL { MODELPARAM_VALUE.VBSTRT_VAL PARAM_VALUE.VBSTRT_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VBSTRT_VAL}] ${MODELPARAM_VALUE.VBSTRT_VAL}
}

proc update_MODELPARAM_VALUE.HTOTAL_VAL { MODELPARAM_VALUE.HTOTAL_VAL PARAM_VALUE.HTOTAL_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.HTOTAL_VAL}] ${MODELPARAM_VALUE.HTOTAL_VAL}
}

proc update_MODELPARAM_VALUE.VTOTAL_PAL_VAL { MODELPARAM_VALUE.VTOTAL_PAL_VAL PARAM_VALUE.VTOTAL_PAL_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VTOTAL_PAL_VAL}] ${MODELPARAM_VALUE.VTOTAL_PAL_VAL}
}

proc update_MODELPARAM_VALUE.VTOTAL_NTSC_VAL { MODELPARAM_VALUE.VTOTAL_NTSC_VAL PARAM_VALUE.VTOTAL_NTSC_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VTOTAL_NTSC_VAL}] ${MODELPARAM_VALUE.VTOTAL_NTSC_VAL}
}

proc update_MODELPARAM_VALUE.VBSTOP_PAL_VAL { MODELPARAM_VALUE.VBSTOP_PAL_VAL PARAM_VALUE.VBSTOP_PAL_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VBSTOP_PAL_VAL}] ${MODELPARAM_VALUE.VBSTOP_PAL_VAL}
}

proc update_MODELPARAM_VALUE.VBSTOP_NTSC_VAL { MODELPARAM_VALUE.VBSTOP_NTSC_VAL PARAM_VALUE.VBSTOP_NTSC_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VBSTOP_NTSC_VAL}] ${MODELPARAM_VALUE.VBSTOP_NTSC_VAL}
}

