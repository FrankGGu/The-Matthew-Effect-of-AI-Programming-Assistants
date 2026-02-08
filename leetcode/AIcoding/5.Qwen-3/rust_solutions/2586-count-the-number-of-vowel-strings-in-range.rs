struct Solution;

impl Solution {
    pub fn vowel_strings(words: Vec<String>, left: i32, right: i32) -> i32 {
        let vowels = ['a', 'e', 'i', 'o', 'u'];
        let mut count = 0;
        for i in left as usize..=right as usize {
            if let Some(c) = words[i].chars().next() {
                if vowels.contains(&c) {
                    count += 1;
                }
            }
        }
        count
    }
}