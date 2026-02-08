impl Solution {
    pub fn lex_smallest_string(s: String) -> String {
        let mut s: Vec<char> = s.chars().collect();
        let n = s.len();

        for i in 0..n {
            if s[i] != '0' {
                for j in i..n {
                    if s[j] == '0' {
                        break;
                    }
                    s[j] = (s[j] as u8 - 1) as char;
                }
                break;
            }
        }

        s.into_iter().collect()
    }
}