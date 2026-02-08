struct Solution;

impl Solution {
    pub fn count_beautiful_substrings(s: String, k: i32) -> i32 {
        let mut count = 0;
        let s_chars: Vec<char> = s.chars().collect();
        let vowels = ['a', 'e', 'i', 'o', 'u'];

        for i in 0..s.len() {
            for j in i+1..s.len() {
                let len = j - i + 1;
                if len % k != 0 {
                    continue;
                }
                let mut vowel_count = 0;
                for m in i..=j {
                    if vowels.contains(&s_chars[m]) {
                        vowel_count += 1;
                    }
                }
                if vowel_count * 2 == len {
                    count += 1;
                }
            }
        }

        count
    }
}