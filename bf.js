const fs = require("fs");

if (process.argv.length < 3) {
  console.log("Usage: node run.bf file.bf");
  process.exit(1);
}

const code = fs.readFileSync(process.argv[2], "utf-8").replace(/[^\[\]\+\-\.<>\,]/g, '');
let tape = new Uint8Array(30000), ptr = 0, stack = [];

for (let i = 0; i < code.length; i++) {
  let c = code[i];
  switch (c) {
    case '>': ptr++; break;
    case '<': ptr--; break;
    case '+': tape[ptr]++; break;
    case '-': tape[ptr]--; break;
    case '.': process.stdout.write(String.fromCharCode(tape[ptr])); break;
    case ',': tape[ptr] = 0; break;
    case '[':
      if (tape[ptr] === 0) {
        let loop = 1;
        while (loop > 0) {
          i++;
          if (code[i] === '[') loop++;
          if (code[i] === ']') loop--;
        }
      } else stack.push(i);
      break;
    case ']':
      if (tape[ptr] !== 0) i = stack[stack.length - 1] - 1;
      else stack.pop();
      break;
  }
}

