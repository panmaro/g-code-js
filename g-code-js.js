var vm = require('vm');
var fs = require('fs');

let parser = require("./CgiNodeParser");

let response = {
    output: '',
    write: function(s){ 
        this.output += s
    }
}

let path = process.argv[2];

if (!path) {
	console.log('Usage: node g-code-js.js <file.gcode>');
	process.exit();
}

let content = fs.readFileSync(path, {encoding: 'utf-8'});
let script = parser.script(0, path, content);

let __vmContext = vm.createContext({
    response,
    __scripts: [script]
});

vm.runInContext(script.code, __vmContext, script.path);

console.log(response.output);
