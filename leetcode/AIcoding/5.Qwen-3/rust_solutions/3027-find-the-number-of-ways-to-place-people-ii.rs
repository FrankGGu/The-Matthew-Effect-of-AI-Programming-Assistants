impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn number_of_ways(mut people: Vec<Vec<i32>>) -> i32 {
        people.sort_by(|a, b| {
            if a[0] != b[0] {
                a[0].cmp(&b[0])
            } else {
                a[1].cmp(&b[1])
            }
        });

        let mut dp = vec![0; people.len()];
        let mut pos_map = HashMap::new();

        for (i, p) in people.iter().enumerate() {
            pos_map.entry(p[1]).or_insert(vec![]);
            pos_map.get_mut(&p[1]).unwrap().push(i);
        }

        for i in 0..people.len() {
            let mut count = 0;
            for j in 0..i {
                if people[j][1] < people[i][1] {
                    count += dp[j];
                }
            }
            dp[i] = count + 1;
        }

        let mut result = 0;
        for i in 0..people.len() {
            let mut total = 0;
            for j in 0..i {
                if people[j][1] < people[i][1] {
                    total += dp[j];
                }
            }
            result += total;
        }

        result
    }
}
}