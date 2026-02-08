struct Solution;

impl Solution {
    pub fn maximum_number_of_removable_characters(s: String, p: String) -> i32 {
        let s: Vec<char> = s.chars().collect();
        let p: Vec<char> = p.chars().collect();
        let mut left = 0;
        let mut right = p.len() as i32;

        while left < right {
            let mid = (left + right + 1) / 2;
            if is_subsequence(&s, &p, mid as usize) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }

        left
    }

    fn is_subsequence(s: &[char], p: &[char], k: usize) -> bool {
        let mut i = 0;
        let mut j = 0;
        let mut removed = 0;

        while i < s.len() && j < p.len() {
            if s[i] == p[j] {
                i += 1;
                j += 1;
            } else {
                i += 1;
                removed += 1;
                if removed > k {
                    return false;
                }
            }
        }

        j == p.len()
    }
}