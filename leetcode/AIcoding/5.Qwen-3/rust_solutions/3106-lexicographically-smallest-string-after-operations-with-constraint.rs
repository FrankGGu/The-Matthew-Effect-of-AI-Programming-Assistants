struct Solution;

impl Solution {
    pub fn lex_smallest_string(s: String) -> String {
        let mut s: Vec<char> = s.chars().collect();
        let n = s.len();

        for i in 0..n {
            if s[i] != '0' {
                let mut j = i;
                while j < n && s[j] != '0' {
                    j += 1;
                }
                if j - i > 1 {
                    for k in i..j {
                        s[k] = '0';
                    }
                }
                break;
            }
        }

        for i in 0..n {
            if s[i] == '0' {
                continue;
            }
            for j in (i + 1)..n {
                if s[j] == '0' {
                    break;
                }
                if s[j] < s[i] {
                    for k in i..j {
                        s[k] = '0';
                    }
                    break;
                }
            }
        }

        s.iter().collect()
    }
}