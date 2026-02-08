struct Solution;

impl Solution {
    pub fn min_k_consecutive_bits_flips(mut bits: Vec<i32>, k: i32) -> i32 {
        let n = bits.len();
        let k = k as usize;
        let mut flip = 0;
        let mut result = 0;
        let mut queue = std::collections::VecDeque::new();

        for i in 0..n {
            if let Some(&idx) = queue.front() {
                if idx == i {
                    queue.pop_front();
                    flip ^= 1;
                }
            }

            if bits[i] == 0 {
                if flip == 1 {
                    continue;
                }
                result += 1;
                flip ^= 1;
                queue.push_back(i + k);
            }
        }

        result
    }
}