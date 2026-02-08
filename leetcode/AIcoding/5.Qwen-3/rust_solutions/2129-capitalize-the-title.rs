struct Solution;

impl Solution {
    pub fn capitalize_title(s: String) -> String {
        s.split_whitespace()
            .map(|word| {
                let mut chars = word.chars();
                match chars.next() {
                    Some(c) => c.to_ascii_uppercase().to_string() + chars.as_str().to_ascii_lowercase(),
                    None => String::new(),
                }
            })
            .collect::<Vec<String>>()
            .join(" ")
    }
}