impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn max_fruits(fruits: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = fruits.len();
        let mut positions = vec![];
        let mut fruit_count = vec![];
        for i in 0..n {
            if fruits[i][1] > 0 {
                positions.push(fruits[i][0]);
                fruit_count.push(fruits[i][1]);
            }
        }
        let m = positions.len();
        if m == 0 {
            return 0;
        }

        let mut max_fruits = 0;
        let mut left = 0;
        let mut total = 0;
        let mut set = HashSet::new();

        for right in 0..m {
            let pos = positions[right];
            set.insert(pos);
            total += fruit_count[right];

            while set.len() > k as usize {
                let left_pos = positions[left];
                set.remove(&left_pos);
                total -= fruit_count[left];
                left += 1;
            }

            max_fruits = max_fruits.max(total);
        }

        max_fruits
    }
}

struct Solution {}
}