/*
##### Vial
Copy Vial Firmware vial.uf2 to PR2040
Config met vial configurator https://vial.rocks/

#### common layout
Left thumb Ctrl Alt Shift
Right thumb Enter Space Tab(?)
lower prio ,./ 


#### Special tricks
double press two keybords e.g. 
	momentary layer double thumb pres
	single shot layer double thumb pres

Special keys
print screen
Tab	
Del Left Thumb cluster with Backspace subst ;
Backspace -> subst ;

### Ctrl
Ctrl+c
Ctrl+x
Ctrl+v

Solution
tabdance
momentary layer
NO Double Thumb one hand on mouse no double press action two keybaords

### Navigation/quick edit
Del Left Thumb cluster with Backspace subst ;
Arrows
Pgup
PgDn
home 
end
copy 
cut 
paste
Select extend Ctrl+Shift+Arrows
Select end of line

Solution


Windows management
Move window screen Win+shift+Left-Right Default
max window Ctrl+Alt+Up AHK
min window
close window

#### Ctrl+Alt
Quick launch

Ctrl+Alt+Q-P 

Solution
Ctrl-Alt-Shift left -> thunb conbo
tabdance to stick Ctrl+Al




























##### hardware soldering
https://scottokeebs.com/blogs/keyboards/scottoergo-handwired-keyboard

	1  "GP0"        40
	2  "GP1"        39
	3               38
	4  "GP2"        37
	5  "GP3"        36
	6  "GP4"        35
	7               34
	8               33
	9               32
	10              31
	11              30
	12              29"GP22"
	13              28
	14              27"GP21"
	15              26"GP20"
	16 "GP12"r      25"GP19"
	17 "GP13"r      24"GP18"
	18              23 
	19 "GP14"r      22
	20 "GP15"r      21

constFilePath=C:\user\job\data\setting\openscad\easy_dactyl\easyDactyl.scad
Autohotkey plugin
strOffset=2
*/

/*
https://openscad.org/cheatsheet/
Todo

Make thumb cluster

thumb inner down
Thum mid slightly out
Thum outer slightly in

clamp bottom top
connect top rows

*/
$fn=64;
hook_w = 3.5;
hook_t = 1.5;
hook_h = 10;

beak_l = 1; // overhang
beak_h = 2;
beak_w = hook_w;

stem_b = hook_w; // overhang
stem_h = hook_h;
stem_t = hook_t;

/*
12 pins
battery=3
*/
draad_dia=2;

//pro micro controler
pm_pin_w = 15.24;
pm_w = 18;
pm_l = 33;
pm_h = 3.2; //solder included
//pm_l = 9;

pin_dist=2.54;
//Header Sandwitch
hs_plate_h = 6;
hs_plate_w = pm_w+6;
hs_plate_l = pm_l;
hs_shift_back=hs_plate_l/2;
// hs_shift_lower=(hs_plate_h/2);
hs_shift_lower=3;
// Reinforcement strips on top of the sides
//reinforcement_strip_h=2;
dropSideWireHole=1.5; // height to to center wire pierce
// cut top and bottom
cutPlate_w = 30;
cutPlate_l = 40;
cutPlate_h = 20;
// battery compartment
//bc_h = hs_plate_h+4;
//bc_w = hs_plate_w-11;
bc_l = hs_plate_l+2;
bed_h                 = 1;
bc_h                  = 3.5;
//bc_h                  = 7;
bc_w                  = 13;
pin_supp_h            = 1.5;
reinforcement_strip_h = 2 ;

//#hs_top();
module hs_top()
{
    difference()
    {
        header_body();
        translate([0, 0, bed_h + bc_h + -(cutPlate_h/2)]){cube([cutPlate_l, cutPlate_w, cutPlate_h], true);}
    }
}

//hs_bottom();
module hs_bottom()
{

// Hooks
/*
    #translate([5.2, -(hook_t/2)-(hs_plate_w/2), hook_h/2])rotate([0, 0, 90]){hook();}
    #translate([5.2, (hook_t/2)+(hs_plate_w/2), hook_h/2])rotate([0, 0, -90]){hook();}
    #translate([-14.75, -(hook_t/2)-(hs_plate_w/2), hook_h/2])rotate([0, 0, 90]){hook();}
    #translate([-14.75, (hook_t/2)+(hs_plate_w/2), hook_h/2])rotate([0, 0, -90]){hook();}
*/

    //stopper corner plates
    // sp_t = 1.2;
    // sp_w = (hs_plate_w-bc_w)/2;
    // sp_h = 6;
    // translate([-sp_t/2-hs_plate_l/2,   hs_plate_w/2-sp_w/2 , sp_h/2]){cube([sp_t, sp_w, sp_h], true);}
    // translate([-sp_t/2-hs_plate_l/2, -(hs_plate_w/2-sp_w/2), sp_h/2]){cube([sp_t, sp_w, sp_h], true);}
    // translate([ sp_t/2+hs_plate_l/2, -(hs_plate_w/2-sp_w/2), sp_h/2]){cube([sp_t, sp_w, sp_h], true);}
    // translate([ sp_t/2+hs_plate_l/2,   hs_plate_w/2-sp_w/2 , sp_h/2]){cube([sp_t, sp_w, sp_h], true);}

    difference()
    {
        header_body();
        translate([0, 0, bed_h + bc_h + (cutPlate_h/2)]){cube([cutPlate_l, cutPlate_w, cutPlate_h], true);}
    }
}

//Hood
hood_t = 1.8;
hood_h = hood_t + bed_h + bc_h + pin_supp_h + reinforcement_strip_h+ pm_h;
hood_w = hs_plate_w + hood_t*2;
hood_l = hs_plate_l;
//hs_plate_h = bed_h + bc_h + pin_supp_h + reinforcement_strip_h;
beak_bottom_l = 6;
beak_bottom_w = hs_plate_l;
beak_bottom_h = 1.8;
beak_bottom_angle = 25;

// rotate([180, 90, 0]){hood();}
module hood()
{
    difference()
    {
        hood_raw();
        translate([0, 0, (hood_h / 2)                                          ]){cube([hood_l, hood_w - hood_t*2, hood_h - hood_t -1], true);} // inner hood removeal
        sideCableOpeningPierce();
        translate([0, 0, -2+(hood_h / 2)                                          ]){cube([hood_l, -4+hood_w - hood_t*2, hood_h -hood_t], true);} // inner hood removeal
    }
}

module hood_raw()
{
    translate([0, 0, (hood_h / 2)                                          ]){cube([hood_l, hood_w, hood_h], true);}
    hoodBottomBeak();
}

module hoodBottomBeak() //clamp bottom hood
{
    translate([0, -hood_w/2, -beak_bottom_h]){rotate([180, 0, 90]){hook_head(beak_bottom_l, beak_bottom_w, beak_bottom_h, beak_bottom_angle);}}
    translate([0, hood_w/2, -beak_bottom_h]){rotate([180, 0, -90]){hook_head(beak_bottom_l, beak_bottom_w, beak_bottom_h, beak_bottom_angle);}}
}

module sideCableOpeningPierce() //opening all cable outlet
{
    hood_cable_opening_h = beak_bottom_h+bed_h + bc_h + pin_supp_h + reinforcement_strip_h;
    hood_cable_opening_w = 10;
    hood_cable_opening_l = 14;
    moveToSide=(-hood_w/2)-(hood_cable_opening_w/2) + hood_t+2;
    moveToOverCable = -5;
    translate([moveToOverCable, moveToSide, -beak_bottom_h + hood_cable_opening_h/2]){cube([hood_cable_opening_l, hood_cable_opening_w, hood_cable_opening_h], true);}
}

// header_body();
module header_body()
{
    hs_plate_h = bed_h + bc_h + pin_supp_h + reinforcement_strip_h;

    difference()
    {
        translate([0, 0, hs_plate_h / 2                                         ]){cube([hs_plate_l, hs_plate_w, hs_plate_h], true);}
        translate([0, 0, (reinforcement_strip_h / 2) + bed_h + pin_supp_h + bc_h]){cube([hs_plate_l+1, pm_w, reinforcement_strip_h], true);}
        translate([0, 0, (bc_h/2) + bed_h                                       ]){cube([bc_l, bc_w, bc_h], true);}
        holes_top_pierce = 5; //size cube heigth pushing square holes top
        translate([-5, 0, bc_h + bed_h + holes_top_pierce/2                    ]){cube([17, bc_w, holes_top_pierce], true);}
        translate([12, 0, bc_h + bed_h + holes_top_pierce/2                     ]){cube([10, bc_w, holes_top_pierce], true);}
        StartOffset=14;
        translate([-StartOffset, 0, bed_h + bc_h]){
            translate([pin_dist*0 , 0, 0]){pin_pair(0, 0);}
            translate([pin_dist*1 , 0, 0]){pin_pair(0, 0);}
            translate([pin_dist*2 , 0, 0]){pin_pair(1, 1);}
            translate([pin_dist*3 , 0, 0]){pin_pair(1, 1);}
            translate([pin_dist*4 , 0, 0]){pin_pair(1, 1);}
            translate([pin_dist*5 , 0, 0]){pin_pair(1, 1);} // row 1
            translate([pin_dist*6 , 0, 0]){pin_pair(0, 1);} //        col 1
            translate([pin_dist*7 , 0, 0]){pin_pair(0, 0);}
            translate([pin_dist*8 , 0, 0]){pin_pair(0, 0);}
            translate([pin_dist*9 , 0, 0]){pin_pair(0, 1);} // -
            translate([pin_dist*10, 0, 0]){pin_pair(0, 0);}
            translate([pin_dist*11, 0, 0]){pin_pair(0, 1);} // +
            // row side wire col pass through in between
            translate([pin_dist*6  + (pin_dist/2), 0, 0]){pin_side_row_pass();}
            translate([pin_dist*7  + (pin_dist/2), 0, 0]){pin_side_row_pass();}
            translate([pin_dist*8  + (pin_dist/2), 0, 0]){pin_side_row_pass();}
            translate([pin_dist*9  + (pin_dist/2), 0, 0]){pin_side_row_pass();}
            translate([pin_dist*10 + (pin_dist/2), 0, 0]){pin_side_row_pass();}
        }
        //ColWireCut();
    }
}

// wire cut transport hole row side wide opening replace by routing inbetween pins
module ColWireCut()
{
    wireHole=6;
    wireHolePierce=hs_plate_w/2;
    
    translate([-5, -12, 1]){rotate([90, 0, 0]){cylinder(wireHolePierce, wireHole/2, wireHole/2,true);}}
}

//Totaal
//translate([0, 0, 3]){header_sandwitch();}
module header_sandwitch()
{
    // reinforcement top row holes
    difference()
    {
        translate([hs_shift_back, 0, (hs_plate_h/2)+(reinforcement_strip_h/2)]){cube([hs_plate_l, hs_plate_w, reinforcement_strip_h], true);}
        translate([hs_shift_back, 0, (hs_plate_h/2)+(reinforcement_strip_h/2)]){cube([pm_l+0.5, pm_w+0.5, reinforcement_strip_h+0.5], true);}
    }

    difference()
    {
        //lower body

        translate([hs_shift_back, 0, 0]){cube([hs_plate_l, hs_plate_w, hs_plate_h], true);}
        //cube([hs_plate_l, hs_plate_w, hs_plate_h], true);
        StartOffset=1.5;
        fromTop=(hs_plate_h/2)-dropSideWireHole; // height to center wire pierce so will lower side wire hole descreases pier from mc

        translate([StartOffset, 0, fromTop]){
            translate([pin_dist*0 , 0, 0]){pin_pair(0, 0);}
            translate([pin_dist*1 , 0, 0]){pin_pair(0, 0);}
            translate([pin_dist*2 , 0, 0]){pin_pair(1, 1);}
            translate([pin_dist*3 , 0, 0]){pin_pair(1, 1);}
            translate([pin_dist*4 , 0, 0]){pin_pair(1, 1);}
            translate([pin_dist*5 , 0, 0]){pin_pair(1, 1);} // row 1
            translate([pin_dist*6 , 0, 0]){pin_pair(0, 1);} //        col 1
            translate([pin_dist*7 , 0, 0]){pin_pair(0, 0);}
            translate([pin_dist*8 , 0, 0]){pin_pair(0, 0);}
            translate([pin_dist*9 , 0, 0]){pin_pair(0, 1);} // -
            translate([pin_dist*10, 0, 0]){pin_pair(0, 0);}
            translate([pin_dist*11, 0, 0]){pin_pair(0, 1);} // +
        }

        // battery compartment
        translate([hs_shift_back, 0, hs_shift_lower]){cube([bc_l, bc_w, bc_h], true);}
    }
}

module pin_pair( wire_pierce_row, wire_pierce_col)
{
    pin_side_col(wire_pierce_col);
    pin_side_row(wire_pierce_row);
}

module pin_side_col(wire_pierce_col)
{
    translate([0, pm_pin_w/2, 0])
    {
        pin_pierce();
        if (wire_pierce_col)
            wire_pierce(10);
        else
            wire_pierce(1.8);
    }
}

module pin_side_row(wire_pierce_row)
{
    translate([0, -pm_pin_w/2, 0])
    {
        pin_pierce();
        if (wire_pierce_row)
            wire_pierce(10);
        else
            wire_pierce(1.8);
    }
}

module pin_side_row_pass()
{
    translate([0, -pm_pin_w/2, 0])
    {
        wire_pierce(10);
    }
}

module pin_pierce()
{
    //pin pierce
    pin_dia=1.2;
    pin_l=2.8*10;
    cylinder(pin_l, pin_dia/2, pin_dia/2,true);
}

module wire_pierce(w_pierce)
{
    //Wire pierce is length all the way through is 10 only use for easy pin through no clean up 3
    // w_pierce=10;
    rotate([90, 0, 0]){cylinder(w_pierce, draad_dia/2, draad_dia/2,true);}
}

//tempPrintTile();
//tile();
module tempPrintTile()
{
	difference()
	{
		tile();
		translate([0, 0, -0.8])
		{
            cube([100, 100, 5],true);
		}
	}
}

//tile
module tile()
{
    rotate([0, 180, 0])
    {
        difference()
        {
            cube([sw_frame_b,sw_frame_b,sw_frame_h],true);
            cube([sw_l,sw_b, 5 + push_through],true);
            translate([0, 0, -click_ridge_h])
            {
                cube([sw_l+0.3,sw_b,5],true);
            }
        }
    }

	model_addHotSwap = false;
	if (model_addHotSwap)
	{
		//# hotswap house
		moveUp_hotSwap=4.3;
		moveLeft_hotSwap=2.5;
		translate([25.7-sw_frame_b, moveLeft_hotSwap, moveUp_hotSwap])
		{
			hotswap();
		}

		//# DraadKlem Diode
		// moveUp=draad_dia/2+1;
		moveUp=(sw_frame_h/2+(draad_klem_hoogte)/2);
		moveLeft=8.25;
		//movex=-sw_frame_b/2;
		movex=-6.17;
		translate([movex, moveLeft, moveUp])
		{
			draadKlem();
		}
		//#DraadKlem kolom
		// moveUp=draad_dia/2+1;
		moveUp_DraadKlem=(sw_frame_h/2+(draad_klem_hoogte)/2);
		movey__DraadKlemKolom=3.3;
		//movex=-sw_frame_b/2;
		movex_DraadKlemKolom=sw_frame_l/2-frame_dikte/2;
		translate([movex_DraadKlemKolom, -movey__DraadKlemKolom, moveUp_DraadKlem])
		{
			rotate([0, 0, 90])
			{
				draadKlem();
			}
		}
	}
}


//##### Main
/*
WIP Macro translate 
translate([10,0,0]){rotate([0, 0, 0]){thumbCluster();}}
*/

main_easyDactyl();
module main_easyDactyl()
{
    support();
	translate([-40, -19, 0]){rotate([0, 0, 0]){thumbCluster();}}
    col_five();
}

module support()
{
    // upper connection support
    translate([19, 31, 0])      {rotate([0, 0, -45]){cube([frame_dikte+9, frame_dikte, sw_frame_h], true);}}
    // thumb connection support
    translate([ -43.3, -23, 0])  {rotate([0, 0, -90]){cube([frame_dikte+2, frame_dikte, sw_frame_h], true);}}
}

//### thumbCluster()
module thumbCluster()
{
    thumb_inner_rotation=0;
    translate([4.90,20.10,0])   {rotate([0, 0, -thumb_inner_rotation]){tile();}}
    thumb_mid_rotation=10;
    translate([2,0,0]) {rotate([0, 0, -thumb_mid_rotation]){tile();}}
    thumb_center_rotation=15;
    translate([-4, -19, 0])   {rotate([0, 0, -thumb_center_rotation]){tile();}}
}

module col_five()
{
    pinky_drop=7;
    pinky_rotation=7;
    translate([ -pinky_drop, 2*sw_frame_b+2.5, 0]) {rotate([0, 0, pinky_rotation]){tileTripple();}}
    translate([  1         ,    sw_frame_b   , 0]) {tileTripple();}
    translate([  7         ,             0   , 0]) {tileTripple();}
    translate([  3         ,   -sw_frame_b   , 0]) {tileTripple();}
    translate([  0         , -2*sw_frame_b   , 0]) {tileTripple();}
}

//### Finger Col
//tileTripple();
module tileTripple()
{
    // well_curve      =10;
    // well_curve_lift =1.70;
    // Well_curve_gap  =0.2; //after curve gap will grow

    well_curve     =0;
    well_curve_lift=0;
    Well_curve_gap =0;

    translate([-(sw_frame_b + Well_curve_gap), 0, well_curve_lift]){rotate([0, well_curve,0]){tile();}}
    tile();
    translate([ sw_frame_b + Well_curve_gap, 0, well_curve_lift]){rotate([0,-well_curve,0]){tile();}}
}

//staggerRow();
module staggerRow()
{

    translate([ -sw_frame_b, sw_frame_b/2, 0]){tileRow();}
    translate([ 0,          0, 0]){tileRow();}
    translate([ sw_frame_b, -sw_frame_b/4, 0]){tileRow();}
}

//tileRow();
module tileRow()
{
    translate([ 0, -sw_frame_b * 2, 0]){tile();}
    translate([ 0, -sw_frame_b, 0]){tile();}
    tile();
    translate([ 0, sw_frame_b, 0]){tile();}
    translate([ 0, sw_frame_b * 2, 0]){tile();}
}

push_through = 2;
add_mm = 1;
 // keycap
kc_l = 18;
kc_b = 18;
kc_space = 1;
// switch
// sw_l = 13.9;
// sw_b = 13.9;
sw_l = 14.1;
sw_b = 14.1;
sw_frame_h = 5; 
sw_frame_l = kc_l + kc_space;
sw_frame_b = kc_b + kc_space;
sw_frame_side_thickness = 1.5;
sw_frame_side_top = 1.5;
click_ridge_h = 1.4;
frame_dikte = (sw_frame_l-sw_l)/2;

//::################## draadKlem                   ##################
diode_dia=0.8;
draad_klem_lengte=2.5; //y richting lengte waarover de draad vast zit
// draad_klem_hoogte= sw_frame_h+draad_dia+1; // hoogte van de sw_houder+draad_dia+1mm
draad_klem_hoogte= draad_dia+1; // hoogte van de sw_houder+draad_dia+1mm
draad_klem_breedte=(draad_dia/1.5)+draad_dia+(draad_dia/1.5)+2;


pin_h=3.6;

// draadKlemHuis();
// draadGat();
// draadSpleet();
// draadKlemHuis(); //y richting draad

// draadNaaldGat();

//draadCutOut();
// draadKlem();
module draadKlem()
{
    difference()
    {
        draadKlemHuis(draad_klem_breedte, frame_dikte, draad_klem_hoogte);
        //draadCutOut();
        translate([0, 0, -0.5])
        {
            draadCutOut();
        }
    }
}
//draadKlemHuis(draad_klem_breedte, frame_dikte, draad_klem_hoogte);
module draadKlemHuis(breedte, lengte, hoogte)
{
    cube([breedte, lengte, hoogte], true);
}

//draadCutOut();
module draadCutOut()
{
    draadGat();
    draadSpleet();
    //draadNaaldGat();
}

module draadGat()
{
    rotate([90,0,0])
    {
      cylinder(draad_klem_lengte+push_through, draad_dia/2, draad_dia/2,true);

    }
}

module draadNaaldGat()
{
    rotate([0,90,0])
    {
      cylinder(20, diode_dia, diode_dia,true);

    }
}

module draadSpleet()
{
    translate([0, 0, (draad_klem_hoogte/4)+1])
    cube([draad_dia/1.5, draad_klem_lengte+push_through, draad_dia+2], true);
}

//hotswap();
module hotswap()
{
    pin_dia=1.8;
    diode_dia_hotplug=1.5;
    hotswop_choke=0.2;
    //hotswop_choke=0.3; //3 look ok might try 2
    difference()
    {
        cube([5.6, 5, pin_h], true);
        translate([-1.2,0,0])
        {
            cylinder(10, pin_dia/2, pin_dia/2, true); //switch pin
            translate([0,hotswop_choke,0])
            {
                rotate([0,90,0])
                {
                    cylinder(10, diode_dia_hotplug/2, diode_dia_hotplug/2,true);
                }
            }
        }
    }
}

//hook();
module hook() //obsolete
{
cube([stem_t, stem_b, stem_h], true);
translate([hook_t/2, 0, hook_h/2]){hook_head();}
}

//translate([hook_t/2, 0, hook_h/2]){hook_head();}
module hook_head(beak_l, beak_w, beak_h, beak_angle)
{
    difference()
    {
        translate([beak_l/2,0,-beak_h/2])
        {
            cube([beak_l, beak_w, beak_h], true);
        }
        slant_cube_l = beak_l + 4;
        slant_cube_h = beak_h * 2;
        slant_cube_w = beak_w + 5;
        slant_cub_angle = beak_angle;

        rotate([0, slant_cub_angle, 0])
        {
            translate([slant_cube_w/2, 0, slant_cube_h/2])
            {
                cube([slant_cube_w, slant_cube_w, slant_cube_h], true);
            }
        }
    }
}

