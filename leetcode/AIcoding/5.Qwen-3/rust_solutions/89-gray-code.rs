struct Solution {}

impl Solution {
    pub fn gray_code(n: i32) -> Vec<i32> {
        let mut result = vec![0];
        for i in 0..n {
            let mut add = 1 << i;
            for j in (0..result.len()).rev() {
                result.push(result[j] + add);
            }
        }
        result
    }
}