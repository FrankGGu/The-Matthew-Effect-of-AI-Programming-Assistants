struct Solution;

impl Solution {
    pub fn find_first_almost_equal_substring(s: String, t: String, k: i32) -> i32 {
        let k = k as usize;
        let s_len = s.len();
        let t_len = t.len();

        for i in 0..=s_len - t_len {
            let mut diff = 0;
            for j in 0..t_len {
                if s.as_bytes()[i + j] != t.as_bytes()[j] {
                    diff += 1;
                    if diff > k {
                        break;
                    }
                }
            }
            if diff <= k {
                return i as i32;
            }
        }

        -1
    }
}