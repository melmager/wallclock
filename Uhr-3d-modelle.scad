module ring(hoch,breit,durchmesser) {
//durchmesser ring mitte    
  $fn=180;
  out = durchmesser + breit;
  innen = durchmesser - breit;  
  difference() {
    cylinder(d=out,h=hoch);
    cylinder(d=innen,h=hoch);  
  }
}

module neopixel_glass() {
//neopixel 151mm
//eine minute = 7.9mm
    ring(2,10,151);
    for (lo = [0:30:360]) 
      rotate([0,0,lo]) translate ([75.5,0,0]) hull() {
        cylinder(d=7.9,h=2);
        translate([-8,0,0]) cylinder(d=7.9,h=2);
     };
}

module neopixel_nut() {
  ring(5,7,151);
  translate([0,0,-2]) ring(2,5,151);  
}    

module m5dial_uhr() {
difference() {
    $fn=90;
    hull() {
      cylinder(h=12,d=170);
      translate([0,125,0]) cylinder(h=12,d=60);
    }    
    translate([0,0,10]) neopixel_glass();
    translate([0,0,5]) neopixel_nut();
    //stack
    translate([0,125,2]) cylinder(h=10,d=45);
    //stack aufsatz
    ring(12,4,64);
    ring(12,4,41);
    // nut kabel
    translate([-4,73,0]) cube([8,33,3]);
    // gauge
    for (lo=[0:18:180]) 
    rotate([0,0,lo]) translate([60,0,10]) cylinder(h=2,d=4);
    for (lo=[180:18:360]) 
    rotate([0,0,lo]) translate([55,0,10]) cylinder(h=2,d=4);
}
}

module m5dial_device() {
    cylinder(h=30,d=45);
    translate([0,0,12]) cylinder(h=20,d=51);
}   

m5dial_uhr();

//projection(cut = true) translate([0,0,-3]) m5dial_uhr();
//projection(cut = true) rotate([0,90,0]) m5dial_uhr();