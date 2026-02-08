impl Solution {
    pub fn special_binary_string(s: String) -> String {
        fn helper(s: &str) -> String {
            let mut res = String::new();
            let mut count = 0;
            let mut start = 0;
            for (i, c) in s.chars().enumerate() {
                if c == '0' {
                    count -= 1;
                } else {
                    count += 1;
                }
                if count == 0 {
                    let sub = &s[start..i + 1];
                    res.push('1');
                    res.push_str(&helper(sub[1..i].to_string()));
                    res.push('0');
                    start = i + 1;
                }
            }
            res
        }
        helper(&s)
    }
}