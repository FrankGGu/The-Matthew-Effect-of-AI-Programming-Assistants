struct Solution;

impl Solution {
    pub fn count_substrings(s: String) -> i32 {
        let mut count = 0;
        let chars: Vec<char> = s.chars().collect();

        for i in 0..chars.len() {
            count += expand_around_center(&chars, i, i);
            count += expand_around_center(&chars, i, i + 1);
        }

        count
    }
}

fn expand_around_center(chars: &[char], left: usize, right: usize) -> i32 {
    let mut count = 0;
    while left >= 0 && right < chars.len() && chars[left] == chars[right] {
        count += 1;
        left -= 1;
        right += 1;
    }
    count
}