impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn min_operations(target: Vec<i32>) -> i32 {
        let mut operations = 0;
        let mut bits = vec![0; 32];

        for &num in &target {
            for i in 0..32 {
                if num & (1 << i) != 0 {
                    bits[i] += 1;
                }
            }
        }

        let mut queue = VecDeque::new();
        for i in 0..32 {
            if bits[i] > 0 {
                queue.push_back(i);
            }
        }

        while let Some(i) = queue.pop_front() {
            if bits[i] == 0 {
                continue;
            }

            if bits[i] > 1 {
                operations += bits[i] - 1;
                bits[i + 1] += bits[i] / 2;
                bits[i] %= 2;
            }

            if i + 1 < 32 && bits[i + 1] > 0 {
                queue.push_back(i + 1);
            }
        }

        operations
    }
}
}