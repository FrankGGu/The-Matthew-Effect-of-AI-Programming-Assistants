struct Solution;

impl Solution {
    pub fn count_substrings(s: String) -> i32 {
        let mut count = 0;
        let chars: Vec<char> = s.chars().collect();
        for i in 0..chars.len() {
            let last_digit = chars[i].to_digit(10).unwrap();
            for j in i+1..chars.len() {
                let substr = &s[i..j+1];
                if let Ok(num) = substr.parse::<i32>() {
                    if num % last_digit == 0 {
                        count += 1;
                    }
                }
            }
        }
        count
    }
}