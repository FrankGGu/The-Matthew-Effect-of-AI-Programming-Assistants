impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn max_energy(mut energy: Vec<i32>, k: i32) -> i32 {
        let n = energy.len();
        let k = k as usize;
        let mut dq = VecDeque::new();

        for i in 0..n {
            while let Some(&j) = dq.back() {
                if energy[j] <= energy[i] {
                    dq.pop_back();
                } else {
                    break;
                }
            }
            dq.push_back(i);

            while dq.front().unwrap() <= &i - k {
                dq.pop_front();
            }

            if i >= k - 1 {
                energy[i] += energy[*dq.front().unwrap()];
            }
        }

        *energy.iter().max().unwrap()
    }
}
}