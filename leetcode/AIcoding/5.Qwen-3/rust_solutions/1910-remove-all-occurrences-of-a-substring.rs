impl Solution {
    pub fn remove_substring(s: String, part: String) -> String {
        let mut s = s;
        let part_len = part.len();
        let mut i = 0;
        while i <= s.len() - part_len {
            if &s[i..i + part_len] == part {
                s = [s[..i].to_string(), s[i + part_len..].to_string()].join("");
                i = 0;
            } else {
                i += 1;
            }
        }
        s
    }
}