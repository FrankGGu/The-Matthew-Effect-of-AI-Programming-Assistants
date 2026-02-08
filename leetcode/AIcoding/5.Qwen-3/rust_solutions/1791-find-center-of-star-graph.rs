impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn find_center(edges: Vec<Vec<i32>>) -> i32 {
        let mut set = HashSet::new();
        for edge in edges {
            if set.contains(&edge[0]) {
                return edge[0];
            }
            if set.contains(&edge[1]) {
                return edge[1];
            }
            set.insert(edge[0]);
            set.insert(edge[1]);
        }
        -1
    }
}
}