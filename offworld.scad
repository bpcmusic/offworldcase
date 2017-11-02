
$fn = 50;

pcbX = 25.48;
pcbY = 27.96;
pcbZ = 1.68;

holeRadius = 1.4;
holeFromTop = 6.2;
holeFromSide = 1.2;
holeZ = 3.5;

holeCutoutX = .33;
holeCutoutZ = 1.75; // 1.5

usb1X = 13.13;
usb1Y = 14.04;
usb1Z = 6.45;

usb1Drop = usb1Z - 5.6;
usb1Opening = 14.52;

usb1SolderStretch = 4;
usb1SolderY = 4.75;

usb1TopHole = .2;
    
usb2X = 7.72;
usb2Y = 8.7;
usb2Z = 4;

usb2Inset = 10.2 - usb2X; // 10.3

usb2PlugWAdjust = (10.5 - usb2X) / 2; // 10.3
usb2PlugZAdjust = (7.3 - usb2Z) / 2; // 7.2

// printertime

 // translate([ 0, 0, -5 ]) 
 //   color([1, 0, 0]) board();
// bottom();
color([0, 1 ,0]) top();

caseRounding = .64;
caseWall = 1.2;
caseGap = .125;
caseWG = caseWall + caseGap;

caseBottomZ = pcbZ + usb1Drop + caseWG + (usb1Z / 4);

bottomTopZ = caseBottomZ - (caseWG + usb1Drop);
topZ = usb2Z + pcbZ + caseWG - bottomTopZ;

module top() {
   
    difference(){

        translate([ -caseWG , -caseWG, bottomTopZ ])
            roundedRect( [ pcbX + (caseWG * 2), pcbY + (caseWG * 2), topZ ], caseRounding );   
        
        translate([-caseGap, -caseGap, -caseGap])
            union(){
                 // USB 1
                translate([ (pcbX - usb1X) / 2, (pcbY - usb1Y) + .67 - caseWG, -usb1Drop ])
                    cube([ usb1X + (caseGap * 2), (usb1Y * 2) + (caseGap * 2), usb1Z + (caseGap * 2) ]);
            
                 // USB 1 Hole
                translate([ (pcbX - usb1Opening) / 2, (pcbY - usb1TopHole) + .67 , -usb1Drop ])
                    cube([ usb1Opening + (caseGap * 2), (usb1Y * 2) + (caseGap * 2), usb1Z + (caseGap * 2) + usb2PlugZAdjust ]);

                // USB 2
                translate([ usb2Inset, -caseWG * 2, pcbZ ])
                    cube([ usb2X + (caseGap * 2), usb2Y + (caseGap * 3) + (caseWG * 3), usb2Z + (caseGap * 2) ]);

                translate([ pcbX - usb2Inset - usb2X, -caseWG * 2, pcbZ ])
                    cube([ usb2X + (caseGap * 2), usb2Y + (caseGap * 3) + (caseWG * 3), usb2Z + (caseGap * 2) ]);   
                
                // USB 2 Hole
                translate([ usb2Inset - usb2PlugWAdjust, -caseWG * 2, pcbZ - usb2PlugZAdjust ])
                    cube([ usb2X + (caseGap * 2) + (usb2PlugWAdjust * 2), caseWG + (caseGap * 2), usb2Z + (caseGap * 2) + (usb2PlugZAdjust * 2) ]);

                translate([ pcbX - usb2Inset - usb2X - usb2PlugWAdjust, -caseWG * 2, pcbZ - usb2PlugZAdjust ])
                    cube([ usb2X + (caseGap * 2) + (usb2PlugWAdjust * 2), caseWG + (caseGap * 2), usb2Z + (caseGap * 2) + (usb2PlugZAdjust * 2) ]);   
         
                // posts
                translate([+caseGap, +caseGap, +caseGap])
                    union() {
                        translate([ holeFromSide + holeRadius, pcbY - holeRadius - holeFromTop, -pcbZ / 2 ])
                            cylinder(pcbZ * holeZ, holeRadius - caseGap, holeRadius - caseGap);

                        translate([pcbX - ( holeFromSide + holeRadius), pcbY - holeRadius - holeFromTop, -pcbZ / 2 ])
                            cylinder(pcbZ * holeZ, holeRadius - caseGap, holeRadius - caseGap);
                    }

         
            }
        
        // designators
        translate([ pcbX - usb2Inset - (usb2X / 2), caseWG * 1.25, topZ + pcbZ ]) 
            cylinder(3, 1.25, 1.25);
        translate([ pcbX / 2, pcbY - (caseWG * 4), topZ + pcbZ ]) 
            rotate(45)
                triangle(4);
        translate([ usb2Inset + (usb2X / 2), caseWG / 2, topZ + pcbZ ]) 
            rotate(45)
                triangle(3);
        
    }
    
    // protruding post guides   
    translate([ holeFromSide + holeRadius, pcbY - holeRadius - holeFromTop, pcbZ + caseGap ])
        difference(){
            cylinder(topZ - pcbZ - caseGap, holeRadius + (caseGap * 8), holeRadius + (caseGap * 8));
            cylinder(topZ - pcbZ - caseGap, holeRadius + caseGap, holeRadius - caseGap);
        }

    translate([pcbX - ( holeFromSide + holeRadius), pcbY - holeRadius - holeFromTop, pcbZ + caseGap ])
        difference(){
            cylinder(topZ - pcbZ - caseGap, holeRadius + (caseGap * 8), holeRadius + (caseGap * 8));
            cylinder(topZ - pcbZ - caseGap, holeRadius + caseGap, holeRadius - caseGap);
        }


}

module bottom() {
    
    difference() {
        translate([ -caseWG , -caseWG, - (caseWG + usb1Drop) ])
            roundedRect( [ pcbX + (caseWG * 2), pcbY + (caseWG * 2), caseBottomZ ], caseRounding );
        
        translate([-caseGap, -caseGap, -caseGap])
            union(){
                // PCB
                cube([ pcbX + (caseGap * 2), pcbY + (caseGap * 2), (pcbZ * 2) + (caseGap * 2) ]);
                
                 // USB 1
                translate([ (pcbX - usb1Opening) / 2, (pcbY - usb1Y) + .67 , -usb1Drop ])
                    cube([ usb1Opening + (caseGap * 2), (usb1Y * 2) + (caseGap * 2), usb1Z + (caseGap * 2) + usb2PlugZAdjust ]);     
                
                 // USB 1 Solder Pips
                translate([ ((pcbX - usb1Opening) / 2) - ( usb1SolderStretch / 2), (pcbY - usb1Y) + .67 , -usb1Drop ])
                    cube([ usb1Opening + (caseGap * 2) + usb1SolderStretch, usb1SolderY, usb1Z + (caseGap * 2) + usb2PlugZAdjust ]);

                // USB 2
                translate([ usb2Inset - usb2PlugWAdjust, -caseWG * 2, pcbZ - usb2PlugZAdjust ])
                    cube([ usb2X + (caseGap * 2) + (usb2PlugWAdjust * 2), usb2Y + (caseGap * 2), usb2Z + (caseGap * 2) + (usb2PlugZAdjust * 2) ]);

                translate([ pcbX - usb2Inset - usb2X - usb2PlugWAdjust, -caseWG * 2, pcbZ - usb2PlugZAdjust ])
                    cube([ usb2X + (caseGap * 2) + (usb2PlugWAdjust * 2), usb2Y + (caseGap * 2), usb2Z + (caseGap * 2) + (usb2PlugZAdjust * 2) ]);                       
            }
        
    }
    
    // posts
    union(){
        difference() {
            
            translate([ holeFromSide + holeRadius, pcbY - holeRadius - holeFromTop, -pcbZ / 2 ])
                cylinder(pcbZ * holeZ, holeRadius - caseGap, holeRadius - caseGap);
    
            translate([ holeFromSide + holeRadius - (holeCutoutX / 2), pcbY - (holeRadius * 2) - holeFromTop, (-pcbZ / 2) + (pcbZ * holeZ) - holeCutoutZ ])
                cube( [ holeCutoutX, holeRadius * 2, holeCutoutZ] );
            
        }

        difference() {
            translate([pcbX - ( holeFromSide + holeRadius), pcbY - holeRadius - holeFromTop, -pcbZ / 2 ])
                cylinder(pcbZ * holeZ, holeRadius - caseGap, holeRadius - caseGap);

            translate([ pcbX - ( holeFromSide + holeRadius + (holeCutoutX / 2)), pcbY - (holeRadius * 2) - holeFromTop, (-pcbZ / 2) + (pcbZ * holeZ) - holeCutoutZ ])
                cube( [ holeCutoutX, holeRadius * 2, holeCutoutZ] );
        }
    }
}


module board() {

// PCB
    difference(){
        cube([ pcbX, pcbY, pcbZ ]);
        union(){
            translate([ holeFromSide + holeRadius, pcbY - holeRadius - holeFromTop, -pcbZ / 2 ])
                cylinder(pcbZ * 2, holeRadius, holeRadius);
                
            translate([pcbX - ( holeFromSide + holeRadius), pcbY - holeRadius - holeFromTop, -pcbZ / 2 ])
                cylinder(pcbZ * 2, holeRadius, holeRadius);
        }
    }

    // USB 1
    translate([ (pcbX - usb1X) / 2, (pcbY - usb1Y) + .67 , -usb1Drop ])
        cube([ usb1X, usb1Y, usb1Z ]);

    // USB 2
    translate([ usb2Inset, 0, pcbZ ])
        cube([ usb2X, usb2Y, usb2Z ]);

    translate([ pcbX - usb2Inset - usb2X, 0, pcbZ ])
        cube([ usb2X, usb2Y, usb2Z ]);

}

// helpers

module roundedRect(size, radius)
{
	x = size[0];
	y = size[1];
	z = size[2];
    
    translate([ x/2, y/2, 0 ])
        union(){
            linear_extrude(height=z)
            hull()
            {
                // place 4 circles in the corners, with the given radius
                translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
                circle(r=radius);
            
                translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
                circle(r=radius);
            
                translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
                circle(r=radius);
            
                translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
                circle(r=radius);
            }
        }
}

module triangle(l=1, h=2){
    linear_extrude(h)
        polygon(points=[[0,0],[l,0],[0,l]], paths=[[0,1,2]]);
}