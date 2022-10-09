settimer(func() {
	props.globals.getNode("instrumentation/comm[0]/serviceable").setBoolValue(0);
	props.globals.getNode("instrumentation/comm[1]/serviceable").setBoolValue(0);
	props.globals.getNode("instrumentation/comm[0]/frequencies/selected-mhz").setDoubleValue(0.0);
	props.globals.getNode("instrumentation/comm[1]/frequencies/selected-mhz").setDoubleValue(0.0);
}, 1);
