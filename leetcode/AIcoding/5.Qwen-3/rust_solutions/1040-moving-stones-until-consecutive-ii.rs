struct Solution;

impl Solution {
    pub fn num_moves(stones: Vec<i32>) -> i32 {
        let mut stones = stones;
        stones.sort();
        let n = stones.len();

        if stones[0] + 1 == stones[1] && stones[1] + 1 == stones[2] {
            return 0;
        }

        if stones[0] + 2 == stones[1] || stones[1] + 2 == stones[2] {
            return 1;
        }

        let mut min_moves = i32::MAX;

        for i in 0..n {
            let j = (i + 1) % n;
            let k = (i + 2) % n;

            if stones[j] - stones[i] <= 2 && stones[k] - stones[j] <= 2 {
                min_moves = 0;
                break;
            }
        }

        if min_moves == i32::MAX {
            let mut max_gap = 0;
            for i in 0..n-1 {
                max_gap = std::cmp::max(max_gap, stones[i+1] - stones[i]);
            }
            min_moves = (stones[n-1] - stones[0] + 1 - n) as i32 - max_gap as i32 + 1;
        }

        min_moves
    }
}