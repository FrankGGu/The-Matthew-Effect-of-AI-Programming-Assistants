struct Solution;

impl Solution {
    pub fn reverse_prefix(word: String, ch: char) -> String {
        let mut chars: Vec<char> = word.chars().collect();
        let mut left = 0;
        let mut right = 0;

        while right < chars.len() && chars[right] != ch {
            right += 1;
        }

        if right == chars.len() {
            return word;
        }

        while left < right {
            chars.swap(left, right);
            left += 1;
            right -= 1;
        }

        chars.into_iter().collect()
    }
}