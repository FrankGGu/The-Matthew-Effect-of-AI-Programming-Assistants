struct Solution;

impl Solution {
    pub fn count_vowels(word: String) -> i32 {
        let vowels = ['a', 'e', 'i', 'o', 'u'];
        let mut count = 0;
        let word_len = word.len();

        for (i, c) in word.chars().enumerate() {
            if vowels.contains(&c) {
                count += (i as i32 + 1) * (word_len as i32 - i as i32);
            }
        }

        count
    }
}