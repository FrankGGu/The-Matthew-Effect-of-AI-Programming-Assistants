impl Solution {
    pub fn count_k_constraint_substrings(s: String, k: i32) -> i32 {
        let mut result = 0;
        let n = s.len();
        let s_bytes = s.as_bytes();

        for i in 0..n {
            let mut count = [0; 256];
            let mut unique = 0;
            for j in i..n {
                let c = s_bytes[j];
                if count[c as usize] == 0 {
                    unique += 1;
                }
                count[c as usize] += 1;

                if unique <= k as usize {
                    result += 1;
                } else {
                    break;
                }
            }
        }

        result
    }
}