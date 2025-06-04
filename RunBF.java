import java.nio.file.*;
import java.util.*;

public class RunBF {
    public static void main(String[] args) throws Exception {
        if (args.length == 0) return;
        String code = Files.readString(Path.of(args[0])).replaceAll("[^<>+\\-\\.,\\[\\]]", "");
        byte[] tape = new byte[30000];
        int ptr = 0;
        Stack<Integer> stack = new Stack<>();
        for (int i = 0; i < code.length(); i++) {
            char c = code.charAt(i);
            switch (c) {
                case '>': ptr++; break;
                case '<': ptr--; break;
                case '+': tape[ptr]++; break;
                case '-': tape[ptr]--; break;
                case '.': System.out.print((char)tape[ptr]); break;
                case ',': tape[ptr] = 0; break;
                case '[':
                    if (tape[ptr] == 0) {
                        int loop = 1;
                        while (loop > 0) {
                            i++;
                            if (code.charAt(i) == '[') loop++;
                            if (code.charAt(i) == ']') loop--;
                        }
                    } else stack.push(i);
                    break;
                case ']':
                    if (tape[ptr] != 0) i = stack.peek() - 1;
                    else stack.pop();
                    break;
            }
        }
    }
}

