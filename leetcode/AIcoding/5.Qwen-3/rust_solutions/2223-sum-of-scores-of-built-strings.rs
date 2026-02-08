struct Solution;

impl Solution {
    pub fn sum_of_scores(s: String) -> i32 {
        let n = s.len();
        let mut lps = vec![0; n];
        let s_bytes = s.as_bytes();

        for i in 1..n {
            let mut j = lps[i - 1];
            while j > 0 && s_bytes[i] != s_bytes[j] {
                j = lps[j - 1];
            }
            if s_bytes[i] == s_bytes[j] {
                j += 1;
            }
            lps[i] = j;
        }

        lps.iter().sum::<usize>() as i32
    }
}