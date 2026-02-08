struct Solution;

impl Solution {
    pub fn h_index(mut citations: Vec<i32>) -> i32 {
        let n = citations.len();
        citations.sort_by(|a, b| b.cmp(a));
        for i in 0..n {
            if citations[i] < (i as i32 + 1) {
                return i as i32;
            }
        }
        n as i32
    }
}