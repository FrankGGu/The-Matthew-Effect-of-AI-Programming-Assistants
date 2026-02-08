struct Solution;

impl Solution {
    pub fn h_index(mut citations: Vec<i32>) -> i32 {
        citations.sort_by(|a, b| b.cmp(a));
        let n = citations.len();
        for i in 0..n {
            if citations[i] < (i + 1) as i32 {
                return i as i32;
            }
        }
        n as i32
    }
}