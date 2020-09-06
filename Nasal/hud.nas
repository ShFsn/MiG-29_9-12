##################################################################################################################
#                                                 Canvas HUD:                                                    #
##################################################################################################################

#HUD distance from aircraft center = -3.89562
#HUD height = 1.13514 - 0.92343 = 0.21171
#HUD width = 0.08794 - -0.08795 = 0.17589
#HUD aspect ratio = 0.17589 / 0.21171 = 0.83081 (just say 5:6)
#center is 150, 152

HUDHoriz = -3.89562;
var sx = 300;
var sy = 360;
HUD_FONT = "LiberationFonts/LiberationMono-Bold.ttf";
var defaultHeadHeight = getprop("sim/view[0]/config/y-offset-m");
pixelPerMeterX = sx/0.17589;
pixelPerMeterY = sy/0.21171;
var defaultHeadDistance = getprop("sim/view[0]/config/z-offset-m") - HUDHoriz;

var hud_obj = canvas.new({
        "name": "Mig-29 HUD",
        "size": [1024,1024],
        "view": [sx,sy],
        "mipmapping": 0
});

hud_obj.addPlacement({"node": "ILSHud"});
hud_obj.setColorBackground(1, 1, 1, 0);

var hud_group = hud_obj.createGroup();

# var testing = hud_group.createChild("text")
#         .setTranslation(sx*0.5, sy*0.5)
#         .setAlignment("center-center")
#         .setColor(0,1,0,1)
#         .setFont(HUD_FONT)
#         .setFontSize(13, 1.4)
#         .setText("Testing");

# var centerCanvas = hud_group.createChild("path")
#         .moveTo(sx*0.5-1, sy*0.5)
#         .horiz(2)
#         .setColor(0,1,0,1);

#stuff for the hud
var data = {
        viewX:                  "sim/current-view/x-offset-m",
        viewY:                  "sim/current-view/y-offset-m",
        viewZ:                  "sim/current-view/z-offset-m",
        hudOn:                  "mig29/systems/SEI-31/ind-on",
        hudKnob:                "mig29/systems/ILS-31/setka",
        rotation:               "mig29/instrumentation/KPP/roll-indicated-deg",
        currentSpeed:           "mig29/instrumentation/SEI-31/indicated_airspeed",
        currentAlt:             "mig29/instrumentation/SEI-31/indicated_altitude",
        currentAltType:         "mig29/instrumentation/SEI-31/R",
        currentAccel:           "mig29/instrumentation/SEI-31/RIS",
        currentPitch:           "mig29/instrumentation/KPP/pitch-indicated-deg",
        currentHorizon:         "mig29/instrumentation/SEI-31/indicated_tangage_L",
        currentHeading:         "mig29/instrumentation/PNP-72-12/heading-indicated-deg",
};
foreach(var name; keys(data)) {
         data[name] = props.globals.getNode(data[name], 1);
}

#fixed elements
var bore = hud_group.createChild("path")
        .moveTo(sx*0.5-4, sy*0.5-28)
        .horiz(-11)
        .moveTo(sx*0.5+4, sy*0.5-28)
        .horiz(11)
        .moveTo(sx*0.5, sy*0.5-32)
        .vert(-11)
        .moveTo(sx*0.5, sy*0.5-24)
        .vert(11)
        .setColor(0,1,0,1);

var bankLines = hud_group.createChild("path")
        .moveTo(sx*0.5-55, sy*0.5-28)
        .horiz(-10)
        .moveTo(sx*0.5-53.13, sy*0.5-13.76)
        .line(-9.66,2.59)
        .moveTo(sx*0.5-47.63, sy*0.5-0.5)
        .line(-8.66,5)
        .moveTo(sx*0.5-27.5, sy*0.5+19.63)
        .line(-5,8.66)
        #-------------------------------
        .moveTo(sx*0.5+55, sy*0.5-28)
        .horiz(10)
        .moveTo(sx*0.5+53.13, sy*0.5-13.76)
        .line(9.66,2.59)
        .moveTo(sx*0.5+47.63, sy*0.5-0.5)
        .line(8.66,5)
        .moveTo(sx*0.5+27.5, sy*0.5+19.63)
        .line(5,8.66)
        .setColor(0,1,0,1);

var headingPointer = hud_group.createChild("path")
        .moveTo(sx*0.5, 52)
        .line(6,10.39)
        .line(-12,0)
        .line(6,-10.39)
        .setColor(0,1,0,1);

var speedRefBar = hud_group.createChild("path")
        .moveTo(51,54)
        .horiz(26)
        .setColor(0,1,0,1);

var headingBar = hud_group.createChild("path")
        .moveTo(106,51)
        .horiz(87)
        .setColor(0,1,0,1);

#changing elements
var silhouette = hud_group.createChild("path")
        .moveTo(sx*0.5-17, sy*0.5-28)
        .horiz(-34)
        .moveTo(sx*0.5+17, sy*0.5-28)
        .horiz(34)
        .moveTo(sx*0.5, sy*0.5-45)
        .vert(-24)
        .moveTo(sx*0.5-24, sy*0.5-28)
        .vert(7)
        .moveTo(sx*0.5+24, sy*0.5-28)
        .vert(7)
        .setStrokeLineWidth(2)
        .setCenter(sx*0.5, sy*0.5-28)
        .setColor(0,1,0,1);

var speedIndication = hud_group.createChild("text")
        .setTranslation(87, 53)
        .setAlignment("right-bottom")
        .setColor(0,1,0,1)
        .setFont(HUD_FONT)
        .setFontSize(25, 1.2)
        .setText("0000");

var altIndication = hud_group.createChild("text")
        .setTranslation(216, 50)
        .setAlignment("left-bottom")
        .setColor(0,1,0,1)
        .setFont(HUD_FONT)
        .setFontSize(25, 1.2)
        .setText("0000");

var altType = hud_group.createChild("text")
        .setTranslation(247, 49)
        .setAlignment("center-center")
        .setColor(0,1,0,1)
        .setFont(HUD_FONT)
        .setFontSize(25, 1.2)
        .setText("Р");

var accelPointer = hud_group.createChild("path")
        .moveTo(63, 54)
        .line(3,5.2)
        .line(-6,0)
        .line(3,-5.2)
        .setColor(0,1,0,1);

var horizonLine = hud_group.createChild("path")
        .moveTo(sx*0.5-66, sy*0.5-28)
        .horiz(132)
        .setColor(0,1,0,1);

var pitch_scale_group = hud_group.createChild("group");
#        .set("clip", "rect(82px, 240px, 222px, 210px)");
var pitchElements = [];

for(var pitchDown = 9; pitchDown >= 1; pitchDown = pitchDown - 1) {
        var pitchLine = pitch_scale_group.createChild("path")
                .moveTo(216, sy*0.5 - 28 + 40*pitchDown)
                .horiz(4)
                .move(1,0)
                .horiz(4)
                .move(1, 0)
                .horiz(4)
                .setColor(0,1,0,1);
        append(pitchElements, pitchLine);
        var pitchNumber = pitch_scale_group.createChild("text")
                .setTranslation(216, sy*0.5 - 30 + 40*pitchDown)
                .setAlignment("left-bottom")
                .setColor(0,1,0,1)
                .setFont(HUD_FONT)
                .setFontSize(15, 1.2)
                .setText(sprintf("%02d", pitchDown*10));
        append(pitchElements, pitchNumber);
}

for(var pitchUp = 0; pitchUp <= 9; pitchUp = pitchUp + 1) {
        var pitchLine = pitch_scale_group.createChild("path")
                .moveTo(216, sy*0.5 - 28 - 40*pitchUp)
                .horiz(15)
                .setColor(0,1,0,1);
        append(pitchElements, pitchLine);
        var pitchNumber = pitch_scale_group.createChild("text")
                .setTranslation(216, sy*0.5 - 30 - 40*pitchUp)
                .setAlignment("left-bottom")
                .setColor(0,1,0,1)
                .setFont(HUD_FONT)
                .setFontSize(15, 1.2)
                .setText(sprintf("%02d", pitchUp*10));
        append(pitchElements, pitchNumber);
}

var heading_scale_group = hud_group.createChild("group");
var headingElements = [];

for(var headingCounter = 0; headingCounter <= 40; headingCounter = headingCounter + 1) {
        var headingLine = heading_scale_group.createChild("path")
                .moveTo(sx*0.5 - 84 + headingCounter*42, 51)
                .vert(-10)
                .setColor(0,1,0,1);
        append(headingElements, headingLine);
        var headingNumber = heading_scale_group.createChild("text")
                .setTranslation(sx*0.5 - 84 + headingCounter*42, 44)
                .setAlignment("center-bottom")
                .setColor(0,1,0,1)
                .setFont(HUD_FONT)
                .setFontSize(15, 1.2)
                .setText(sprintf("%02d", math.mod(headingCounter - 2, 36)));
        append(headingElements, headingNumber);
}

#update loop
var distr = 0;
var update = func {
        silhouette.setRotation(data.rotation.getValue() * D2R);
        speedIndication.setText(sprintf("%02d", data.currentSpeed.getValue()));
        currentAltitude = data.currentAlt.getValue();
        altIndication.setText(sprintf("%02d", currentAltitude));
        if(data.currentAltType.getValue()) { #There is probably a way better way of doing this
                altType.setText("Р");
                if(currentAltitude > 10) {
                        altType.setTranslation(247 + (math.floor(math.log10(currentAltitude)) - 1)*10, 49);
                }
        }
        else {
                altType.setText("");
        }
        accelPointer.setTranslation(data.currentAccel.getValue() * 15, 0);
        var pitch = data.currentPitch.getValue();
        pitch_scale_group.setTranslation(0, pitch * 4);
        var pitch_offset = pitch/10 + 9;
        horizonLine.setTranslation(0, data.currentHorizon.getValue() * 4);
        var heading = data.currentHeading.getValue();
        heading_scale_group.setTranslation(heading*-4.2, 0);
        var heading_offset = heading/10 + 2;
        if (distr == 0) {
                for(var i = 0; i < 19; i = i + 1) { # taking sugestions for a more efficient implementation
                        if(math.abs(i - pitch_offset) < 1.8) {
                                pitchElements[2*i].show();
                                pitchElements[2*i + 1].show();
                        }
                        else {
                                pitchElements[2*i].hide();
                                pitchElements[2*i + 1].hide();
                        }
                }
                distr = 1;
        }
        else {
                for(var i = 0; i <= 40; i = i + 1) {
                        if(math.abs(i - heading_offset) < 1) {
                                headingElements[2*i].show();
                                headingElements[2*i + 1].show();
                        }
                        else {
                                headingElements[2*i].hide();
                                headingElements[2*i + 1].hide();
                        }
                }
                distr = 0;
        }


        # Head following code:
        var head_x_offset = data.viewX.getValue() * pixelPerMeterX;
        # This one is inverted, because y+ is up in the view coord. system, and down in the HUD coord. system.
        var head_y_offset = (defaultHeadHeight - data.viewY.getValue()) * pixelPerMeterY;
        var head_z_distance = data.viewZ.getValue() - HUDHoriz;
        var scaling_factor = head_z_distance / defaultHeadDistance;
        # On the y axis, scaling is centered on the HUD center,
        # whereas we need it to be centered on the pilot eyes position.
        # This additional vertical offset corrects the error.
        var corrected_x_offset = head_x_offset + (1 - scaling_factor) * (sx*0.5);
        var corrected_y_offset = head_y_offset + (1 - scaling_factor) * (sy*0.5-28);
        
        hud_group.setTranslation(corrected_x_offset, corrected_y_offset);
        hud_group.setScale(scaling_factor);

        
        if(data.hudOn.getValue() == 1 and data.hudKnob.getValue() == 0) {
                hud_group.show();
        }
        else {
                hud_group.hide();
        }
};

var loop_hud = maketimer(0.03, func update());
var init_listener = setlistener("sim/signals/fdm-initialized", func {
        if (getprop("sim/signals/fdm-initialized") == 1) {
                loop_hud.start();
                removelistener(init_listener);
        }
}, 0, 0);