G00 Z0.5 (raise the tool to the clearance height)
G00 X0 Y0 (the movement of the tool to the start point of the milling)
<? for (var z=-1; z.toFixed(2)>=-3; z-=0.2) { ?> 
G01 Z<?=z.toFixed(2)?> F50 (lower the tool to the desired cutting depth)
G01 X0 Y20 F50 (milling side a)
G01 X30 Y20 (milling side b)
G01 X30 Y0 (milling side a)
G01 X0 Y0 (milling side b, return to the start point for milling)
<? } ?>
G00 Z0.5 (raise the tool to the clearance height)
