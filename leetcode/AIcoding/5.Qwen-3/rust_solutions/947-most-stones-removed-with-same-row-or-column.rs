impl Solution {

use std::collections::{HashMap, HashSet};

struct Solution {}

impl Solution {
    pub fn remove_stones(stones: Vec<Vec<i32>>) -> i32 {
        let mut row_map = HashMap::new();
        let mut col_map = HashMap::new();
        let mut visited = HashSet::new();

        for stone in &stones {
            let (r, c) = (stone[0], stone[1]);
            row_map.entry(r).or_insert(HashSet::new()).insert(c);
            col_map.entry(c).or_insert(HashSet::new()).insert(r);
        }

        let mut count = 0;

        for stone in &stones {
            let (r, c) = (stone[0], stone[1]);
            if !visited.contains(&r) && !visited.contains(&c) {
                Self::dfs(r, c, &mut visited, &row_map, &col_map);
                count += 1;
            }
        }

        (stones.len() as i32 - count)
    }

    fn dfs(r: i32, c: i32, visited: &mut HashSet<i32>, row_map: &HashMap<i32, HashSet<i32>>, col_map: &HashMap<i32, HashSet<i32>>) {
        visited.insert(r);
        visited.insert(c);

        for &nc in row_map.get(&r).unwrap() {
            if !visited.contains(&nc) {
                Self::dfs(r, nc, visited, row_map, col_map);
            }
        }

        for &nr in col_map.get(&c).unwrap() {
            if !visited.contains(&nr) {
                Self::dfs(nr, c, visited, row_map, col_map);
            }
        }
    }
}
}