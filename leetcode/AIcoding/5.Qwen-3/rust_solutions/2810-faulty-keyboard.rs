struct Solution;

impl Solution {
    pub fn faulty_keyboard(s: String) -> String {
        let mut result = String::new();
        for c in s.chars() {
            if c == 'i' {
                result.push('a');
            } else if c == 'o' {
                result.push('e');
            } else if c == 'p' {
                result.push('i');
            } else if c == 'j' {
                result.push('o');
            } else if c == 'k' {
                result.push('u');
            } else if c == 'l' {
                result.push('y');
            } else if c == 'm' {
                result.push('t');
            } else if c == 'n' {
                result.push('r');
            } else if c == 'b' {
                result.push('s');
            } else if c == 'v' {
                result.push('d');
            } else if c == 'c' {
                result.push('f');
            } else if c == 'x' {
                result.push('g');
            } else if c == 'z' {
                result.push('h');
            } else if c == 'w' {
                result.push('j');
            } else if c == 'e' {
                result.push('k');
            } else if c == 'r' {
                result.push('l');
            } else if c == 't' {
                result.push('m');
            } else if c == 'y' {
                result.push('n');
            } else if c == 'u' {
                result.push('b');
            } else if c == 'i' {
                result.push('a');
            } else if c == 'a' {
                result.push('q');
            } else if c == 's' {
                result.push('w');
            } else if c == 'd' {
                result.push('e');
            } else if c == 'f' {
                result.push('r');
            } else if c == 'g' {
                result.push('t');
            } else if c == 'h' {
                result.push('y');
            } else if c == 'j' {
                result.push('u');
            } else if c == 'k' {
                result.push('i');
            } else if c == 'l' {
                result.push('o');
            } else if c == 'q' {
                result.push('z');
            } else if c == 'x' {
                result.push('c');
            } else if c == 'z' {
                result.push('x');
            } else if c == '1' {
                result.push('!');
            } else if c == '2' {
                result.push('@');
            } else if c == '3' {
                result.push('#');
            } else if c == '4' {
                result.push('$');
            } else if c == '5' {
                result.push('%');
            } else if c == '6' {
                result.push('^');
            } else if c == '7' {
                result.push('&');
            } else if c == '8' {
                result.push('*');
            } else if c == '9' {
                result.push('(');
            } else if c == '0' {
                result.push(')');
            } else if c == '-' {
                result.push('_');
            } else if c == '=' {
                result.push('+');
            } else if c == '[' {
                result.push('{');
            } else if c == ']' {
                result.push('}');
            } else if c == '\\' {
                result.push('|');
            } else if c == ';' {
                result.push(':');
            } else if c == '\'' {
                result.push('"');
            } else if c == ',' {
                result.push('<');
            } else if c == '.' {
                result.push('>');
            } else if c == '/' {
                result.push('?');
            } else {
                result.push(c);
            }
        }
        result
    }
}