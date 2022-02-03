# g-code-js
This repo contains a PoC's of how to use JavaScript to make work with g-code easier.

Let's say I have a g-code milling a rectangle

```gcode
G00 Z0.5 (raise the tool to the clearance height)
G00 X0 Y0 (the movement of the tool to the start point of the milling)
G01 Z-1 F50 (lower the tool to the desired cutting depth)
G01 X0 Y20 F50 (milling side a)
G01 X30 Y20 (milling side b)
G01 X30 Y0 (milling side a)
G01 X0 Y0 (milling side b, return to the start point for milling) 
G00 Z0.5 F70 (raise the tool to the clearance height) 
```

... and I want to cut this rectangle not in one pass, but step by step, lowering the tool by 0.5mm in one step.

It would be nice to have a loops (control flow) in g-code...
So the first idea was to use PHP and it's open tag short syntax to generate g-code files. But I didn't use PHP in a long time, and now I would rather use JS.

The code could look like this:
```js
G00 Z0.5 //(raise the tool to the clearance height)
G00 X0 Y0 //(the movement of the tool to the start point of the milling )
<? for (var z=-1; z>-5; z+=0.2) { ?> 
G01 Z<?=z?> F50 //(lower the tool to the desired cutting depth)
G01 X0 Y20 F50 //(milling side a)
G01 X30 Y20 //(milling side b)
G01 X30 Y0 //(milling side a)
G01 X0 Y0 //(milling side b, return to the start point for milling) 
<? } ?>
G00 Z0.5 //(raise the tool to the clearance height)
```

To parse the <?> short tags, I used a code of CgiNodeParser from [cgi-node](https://github.com/DEDAjs/cgi-node) written by Uei Richo.

--------------------

To check it, just get the repo (install node.js if you haven't yet), and run:
```bash
node g-code-js.js sample.gcode > out.gcode
```
The result code will be written to out.gcode file.

Of course you can use other control flow instructions of JS, like: while, case, if, etc.., also functions, objects and so on...

If you have a questions or ideas how to make it better, feel free to write it in Issues.

*This is only PoC and shouldn't be use in production.
Double verify the generated code before use on real device!*
