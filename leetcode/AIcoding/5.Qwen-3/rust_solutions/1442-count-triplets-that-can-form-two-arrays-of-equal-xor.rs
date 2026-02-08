struct Solution;

impl Solution {
    pub fn count_triplets(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut prefix = vec![0; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] ^ arr[i];
        }
        let mut result = 0;
        for i in 0..n {
            for j in i + 1..n {
                if prefix[i] == prefix[j + 1] {
                    result += (n - j) as i32;
                }
            }
        }
        result
    }
}