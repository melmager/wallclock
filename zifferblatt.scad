//neopixel innen 144mm aussen 157 höhe 3,15 ;6.5 breite

module neopixel() {
  difference() {
    cylinder(d=160,h=3);
    cylinder(d=144,h=3);  
  } 
  translate([0,0,-1.2]) rotate([0,0,-3]) intersection() { 
    difference() {
      cylinder(d=160,h=1.2);
      cylinder(d=152,h=1.2);  
    }
    union() {
      translate([-80,-5,0]) cube([160,10,1.2]);
      translate([-5,-80,0]) cube([10,160,1.2]);
    }
  }
  //kabelloch
  translate([-2,-78,-2.9]) cylinder(d=4,h=1.79);
}    

module solar() {
  union() {
    cube([100,80,1]);
    translate([50,40,-1.8]) cylinder(d=30,h=1.8);
    translate([50,11,-2.95]) cylinder(d=20,h=2.95);
    translate([40,11,-1.8]) cube([20,30,1.8]);   
  }
}

module e_paper() {
    //pcb
    cube([20,50,3]);
    //anschlüsse
    translate([2.5,2.5,-9]) cube([15,45,10]);
}

module e_aufsatz() {
  breit = 70;
  hoch = 40;  
  difference() {
    //aussen
    cube([breit + 14,hoch + 14,5]);
    //innen
    translate([7,7,0]) cube([breit, hoch, 4]);
    // phase
    translate([0,0,3.5]) rotate([45,0,0]) cube([breit + 14,5,5]);
    translate([0,hoch + 14,3.5]) rotate([45,0,0]) cube([breit + 14,5,5]);
    translate([0,0,3.5]) rotate([0,-45,0]) cube([5,hoch + 14,5]);
    translate([breit + 14,0,3.5]) rotate([0,-45,0]) cube([5,hoch + 14,5]);
    //rand aussen
    difference() {
        cube([breit + 14,hoch + 14,3]);
        translate([5,5,0]) cube([breit+4,hoch+4,3]);
    }
    //display ausschnitt
    translate([10,7,4]) cube([50,25,1]);  
  }
}

module disp_aufsatz() {
    //pcb 80*36 anzeige 23*71 befestigung 75*31 abstand 5mm für schraobe 5mm 2.5 gewinde
    //abdeckung aussen
    difference() {
      cube([90,46,1.5]);
      translate([10,13,0]) cube([71,23,1.5]);  
    }
    //pcb halter
    translate([7.5,7.5,-5]) difference() {
                              cylinder(d=4.5,h=5);
                              cylinder(d=2.5,h=5);
    }
    //translate([82.5,7.5,-5]) difference() {
                            //  cylinder(d=5,h=5);
                            //  cylinder(d=2.5,h=5);
    //}
    //translate([7.5,38.5,-5]) difference() {
                            //  cylinder(d=5,h=5);
                            //  cylinder(d=2.5,h=5);
    //}
    translate([82.5,38.5,-5]) difference() {
                              cylinder(d=4.5,h=5);
                              cylinder(d=2.5,h=5);    
    }
}

module test() {
  difference() {
   cube([70,40,5]);   
   difference() {
        cube([70,40,3]);
        translate([5,5,0]) cube([60,30,3]);
    }  
  } 
}    

module ziffernblatt() {
 difference() { 
  intersection() {
    union(){
      difference() {
        cylinder(d=163,h=3);
        cylinder(d=141,h=3);
      }
    //linear_extrude(2) text("12"); 
    translate([-3,55.5,0]) cube([6,33,3]); 
    //11
    rotate([0,0,30]) translate([-3,62.5,0]) cube([6,18,3]);
    //1
    rotate([0,0,-30]) translate([-3,62.5,0]) cube([6,18,3]);
    }
    //ausschnitt viertelkreis
    rotate([0,0,42]) cube([100,100,3]);
    }
   translate([0,0,-1.8]) neopixel();
 } 
}

module front() {
    difference() {
      cube([210,297,3]);
      translate([105,90,1.8]) neopixel();
      translate([95,183,3]) rotate([0,0,90]) solar();
      translate([115,283,3]) rotate([0,0,270]) solar();
      //led ausschnitt
      translate([69.6,78.4,0.1]) cube([71.2,23.2,2.9]);
      //löcher befestigung
      translate([64.6,73.4,0.1]) cylinder(d=5,h=2.9);  
    }
} 

module seite_l() {
    difference() {
    cube([13,297,40]);
    //nute
    translate([8,0,30]) cube([5,297,5]);
    //schräge
    rotate([0,0,-45]) cube([40,40,40]); 
    translate([0,297,0]) rotate([0,0,-45]) cube([40,40,40]);     
        
    }
}

module unten() {
    difference() {
    cube([210,13,40]);
    //nute
    translate([0,10,30]) cube([210,5,3]);    
    //schräge
    rotate([0,0,45]) cube([40,40,40]); 
    translate([210,0,0]) rotate([0,0,45]) cube([40,40,40]);  
    }
}

//moderne Version

module akku_tasche() {
  difference() {  
    union() {  
      translate([5,0,0]) cube([44,64,10]);
      //kurve aussen  
      translate([5,0,5]) rotate([0,90,90]) cylinder(d=10,h=64);  
      translate([49,0,5]) rotate([0,90,90]) cylinder(d=10,h=64);
      //halter  
      translate([0,2,5]) rotate([90,0,0])  cylinder(d=10,h=2);
      translate([54,2,5]) rotate([90,0,0])  cylinder(d=10,h=2);
      //halter fläche  
      cube([54,2,10]);  
    }
    translate([5,62,5]) rotate([90,0,0]) cylinder(d=7.6,h=62);
    translate([49,62,5]) rotate([90,0,0]) cylinder(d=7.6,h=62);
    translate([5,0,1.2]) cube([43.4,62,7.6]);
  }
}

module pcb_distanz(xl,yl,zh) {
    difference() {
      cylinder(d=5,h=zh);
      cylinder(d=2.5,h=zh);
    }
    translate([xl,0,0]) difference() {
      cylinder(d=5,h=zh);
      cylinder(d=2.5,h=zh);
    }
    translate([xl,yl,0]) difference() {
      cylinder(d=5,h=zh);
      cylinder(d=2.5,h=zh);
    }
    translate([0,yl,0]) difference() {    
      cylinder(d=5,h=zh);
      cylinder(d=2.5,h=zh);
    }
}

module gehause(xl,yl,zl) {
  difference() {
    cube([xl,yl,zl]); 
    translate([1.2,1.2,1.2]) cube([xl-2.4,yl-2.4,zl-1.2]);  
  }  
}

//xb = breite yh = Höhe zd = dicke
module logic_box(xb,yh) { 
  difference() {
      gehause(xb,yh,20);
       //akku aussparung
      agap = (xb - 44.2) / 2;  
      translate([agap,0,1.2]) cube([44.2,1.5,10.2]);
      translate([agap,1.2,6.3]) rotate([90,0,0]) cylinder(d=10.2,h=1.3);
      translate([agap+44.2,1.2,6.3]) rotate([90,0,0]) cylinder(d=10.2,h=1.3);
      // panel aussparung
      translate([((xb-10)/2),0,11.2]) cube([10,1.2,2.5]);
      //ring aussparung
      translate([((xb-8)/2),yh-1.5,15]) cube([8,2,2.5]);
  }
      // LCD 
      //translate([7,yh-37,0]) pcb_distanz(75,31.5,12);
      //lochraster 
      translate([6.5,10,0]) pcb_distanz(82,28,5);
      // aufhänger
      translate([xb/2,yh+13,0]) difference() {
        union() {
          cylinder(d=12,h=2);
          translate([-6,-14,0]) cube([12,14,2]);  
        }
        cylinder(d=4,h=2);
        translate([0,-7,0]) cylinder(d=8,h=2);
        translate([-2,-7,0]) cube([4,7,2]);
      }
      //solar halter
      translate([xb/2,0,11.4]) klemme();
      //neo halter
      translate([xb/2,yh,10]) rotate([0,0,180]) klemme();
}

//xb = breite yh = Höhe
module box_top(xb,yh) {
  union() {
  difference() {
    cube([xb,yh,20]);
    translate([1.2,1.2,0]) cube([xb-2.4,yh-2.4,18.8]);
    //led ausschnitt  
    translate([10,10,18.5]) cube([71.2,23.2,2]); 
  }
  difference() {
      translate([1.2,1.2,-2.5]) cube([xb-2.4,yh-2.4,5]);
      translate([2.4,2.4,-2.5]) cube([xb-4.4,yh-4.4,5]);
  }
  translate([10,10,8]) pcb_distanz(75,31.5,12);
  }   
}

module panel_holder() {
    //cube([5,5,3]);
    difference() {
      union() {
        cylinder(d=22,h=3.2);
        translate([90,0,0]) cylinder(d=22,h=3.2);
        translate([0,-5,0]) cube([90,10,3.2]);
        translate([40,0,0]) cube([10,60,3.2]);
        //oben  
        translate([45,67,0]) fit_it();
      }    
    
      translate([0,0,1.2])  cylinder(d=17,h=2);
      translate([90,0,1.2])  cylinder(d=17,h=2);
      translate([0,-2.5,1.7]) cube([90,5,1.5]);
      translate([41.5,-2.5,0]) cube([7,70,1.7]);
      
    }      
}

module neo_back() {
 //3.3 + 2.4 = 5.7  
 difference() {
 union() {   
  intersection() {  
    difference() {
      cylinder(d=158.3,h=3);
      cylinder(d=142.7,h=3);
      translate([0,0,1.25]) difference() {
        cylinder(d=157.1,h=1.8);
        cylinder(d=144.1,h=1.8);  
      }  
    }
    rotate([0,0,45]) cube([81,81,3]);
  }
  rotate([0,0,46.5]) translate([0,75.25,0]) cylinder(d=5,h=1.2);
  }
  rotate([0,0,-43.5]) translate([0,75.25,0]) cylinder(d=5.1,h=1.25);
  }
}

module neo_front() {
  intersection() { 
    difference() {
      union() {
        difference() {
          cylinder(d=158.3,h=3);
          cylinder(d=142.7,h=3);
        }
        translate([-4,60,0]) cube([8,30,3]);
        rotate([0,0,30]) translate([-4,65,0]) cube([8,12,3]);
        rotate([0,0,-30]) translate([-4,65,0]) cube([8,12,3]);
      }
      difference() {
        cylinder(d=157.1,h=1.8);
        cylinder(d=144.1,h=1.8);
      } 
    }
    rotate([0,0,52.5]) cube([90,90,3]);
  } 
}

module neo_fuss() {
    //translate([-10,80,0]) 
    difference() {
    union() {  
      cube([20,20,3]);
      //translate([0,17.8,0]) cube([20,3.2,6.4]);
      translate([10,28,0]) fit_it();  
      translate([10,-78.7,0]) neo_back();  
    }
    //platz für leitung
    translate([9.5,-1.3,1.2]) cube([1,23,2]);  
    translate([7.25,-1.3,1.2]) cube([1,23,2]); 
    translate([11.75,-1.3,1.2]) cube([1,23,2]);   
    //translate([18.8,18.7,0]) cube([1.3,1.3,6.4]);
    //translate([0,18.7,0]) cube([1.3,1.3,6.4]);
  }
    
}

module klemme() {
  translate([-8,-4,2.4]) difference() {  
    $fn=20;  
    union() {  
      cylinder(d=5.8,h=3.1);
      translate([-1.6,2,0]) cube([3.2,2.2,3.1]);  
    }
    cylinder(d=3.2,h=3.1);
    translate([-1.45,-2.9,0]) cube([2.9,2.2,3.1]);  
  }    
  translate([8,-4,2.4]) difference() {  
    $fn=20;  
    union() {  
      cylinder(d=5.8,h=3.1);
      translate([-1.6,2,0]) cube([3.2,2.2,3.1]);  
    }
    cylinder(d=3.2,h=3.1);
    translate([-1.45,-2.9,0]) cube([2.9,2.2,3.1]);  
  }    
}

module klemm_hole() {
  $fn=20;
  difference() {
    translate([-4,-4,0]) cube([8,8,6.3]);
    cylinder(d=4.7,h=6.3);
    //phasen
    cylinder(d=5,h=0.5);  
    translate([0,0,5.8])  cylinder(d=5,h=0.5);
  }
}

module fit_it() {
  union(){  
    translate([-12,-8.1,0]) difference() {
      cube([24,8,8]);
      translate([1.1,1.2,1.1]) cube([21.8,6.8,5.7]);  
    }
    $fn = 20;
    translate([-8,-4,0]) cylinder(d=3.1,h=7.8);
    translate([8,-4,0]) cylinder(d=3.1,h=7.8);
  }
}

//test();
//neopixel();
//ziffernblatt();
//solar();
//e_aufsatz();
//disp_aufsatz();
//front();
//seite_l();
//unten();
//neu stylisch

module explode() {
translate([27,-240,0]) rotate([0,0,180]) akku_tasche();
translate([-45,-230,0]) logic_box(95,75);

translate([-55,-310,30]) panel_holder();
translate([0,30,10]) neo_back();

translate([0,30,30]) neo_front();
rotate([0,0,90]) translate([0,30,30]) neo_front();
rotate([0,0,90]) translate([0,30,10]) neo_back();

rotate([0,0,-90]) translate([0,30,30]) neo_front();
rotate([0,0,-90]) translate([0,30,10]) neo_back();

rotate([0,0,180]) translate([0,30,30]) neo_front();
rotate([0,0,180]) translate([-10,95,0]) neo_fuss();
    
translate([-45,-230,30]) box_top(95,75);    
}

//explode();
//klemme();
//fit_it();
//logic_box(95,50);
//box_top(95,50);
//neo_fuss();
//panel_holder();
klemm_hole();