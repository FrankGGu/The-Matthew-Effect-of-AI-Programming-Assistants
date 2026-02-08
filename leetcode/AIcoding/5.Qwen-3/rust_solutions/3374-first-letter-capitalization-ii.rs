struct Solution;

impl Solution {
    pub fn capitalize_title(s: String) -> String {
        s.split_whitespace()
            .map(|word| {
                let mut chars = word.chars();
                match chars.next() {
                    Some(c) => {
                        let c = c.to_ascii_uppercase();
                        let rest: String = chars.collect();
                        format!("{}{}", c, rest)
                    }
                    None => String::new(),
                }
            })
            .collect::<Vec<String>>()
            .join(" ")
    }
}