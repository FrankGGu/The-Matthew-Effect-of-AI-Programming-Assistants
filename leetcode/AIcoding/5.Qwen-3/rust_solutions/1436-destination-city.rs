impl Solution {

use std::collections::HashSet;

fn main() {}

fn destination_city(paths: Vec<Vec<String>>) -> String {
    let mut set = HashSet::new();
    for path in &paths {
        set.insert(&path[0]);
    }
    for path in &paths {
        if !set.contains(&path[1]) {
            return path[1].clone();
        }
    }
    unreachable!()
}
}