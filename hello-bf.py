with open("hello.bf") as f:
    code = ''.join(c for c in f.read() if c in '><+-.,[]')
tape, ptr, i, out, stack = [0]*30000, 0, 0, "", []
while i < len(code):
    c = code[i]
    if c == '>': ptr += 1
    elif c == '<': ptr -= 1
    elif c == '+': tape[ptr] = (tape[ptr]+1)%256
    elif c == '-': tape[ptr] = (tape[ptr]-1)%256
    elif c == '.': out += chr(tape[ptr])
    elif c == ',': tape[ptr] = 0  # No input support
    elif c == '[':
        if tape[ptr]: stack.append(i)
        else:
            loop = 1
            while loop:
                i += 1
                if code[i] == '[': loop += 1
                elif code[i] == ']': loop -= 1
    elif c == ']':
        if tape[ptr]: i = stack[-1]
        else: stack.pop()
    i += 1
print(out)

