impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn maximum_transfer_requests(beam_width: i32, requests: Vec<Vec<i32>>) -> i32 {
        let n = requests.len();
        let mut result = 0;

        for mask in 1..(1 << n) {
            let mut balance = vec![0; beam_width as usize];
            let mut valid = true;

            for i in 0..n {
                if (mask >> i) & 1 == 1 {
                    let from = requests[i][0] as usize;
                    let to = requests[i][1] as usize;
                    balance[from] -= 1;
                    balance[to] += 1;
                }
            }

            for b in &balance {
                if *b != 0 {
                    valid = false;
                    break;
                }
            }

            if valid {
                let count = mask.count_ones() as i32;
                result = result.max(count);
            }
        }

        result
    }
}
}