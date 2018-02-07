$fn = 80;
mmToIn = 25.4;
one    = 0.75 * mmToIn;
two    = 1.5  * mmToIn;
four   = 3.5  * mmToIn;

module 1x2(length){
     cube([one,two,length*mmToIn],0);
}
module 2x4(length){
     cube([two,four,length*mmToIn],0);
}

module 1x4(length){
     cube([one,four,length*mmToIn],0);
}