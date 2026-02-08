struct Solution;

impl Solution {
    pub fn is_self_crossing(distance: Vec<i32>) -> bool {
        let n = distance.len();
        for i in 2..n {
            if i >= 3 && distance[i] >= distance[i - 2] && distance[i - 1] <= distance[i - 3] {
                return true;
            }
            if i >= 4 && distance[i - 1] == distance[i - 3] && distance[i] + distance[i - 4] >= distance[i - 2] {
                return true;
            }
            if i >= 5 && distance[i - 2] >= distance[i - 4] && distance[i - 3] >= distance[i - 1] && distance[i] >= distance[i - 2] - distance[i - 4] && distance[i - 1] <= distance[i - 3] {
                return true;
            }
        }
        false
    }
}