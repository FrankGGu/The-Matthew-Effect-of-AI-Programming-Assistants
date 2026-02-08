impl Solution {

use std::collections::{HashSet, VecDeque};

struct Solution;

impl Solution {
    pub fn friend_requests(n: i32, k: i32, restrictions: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut groups = (0..n).collect::<Vec<_>>();
        let mut rank = vec![1; n];

        fn find(parent: &mut Vec<usize>, x: usize) -> usize {
            if parent[x] != x {
                parent[x] = find(parent, parent[x]);
            }
            parent[x]
        }

        fn union(parent: &mut Vec<usize>, rank: &mut Vec<usize>, x: usize, y: usize) {
            let root_x = find(parent, x);
            let root_y = find(parent, y);
            if root_x == root_y {
                return;
            }
            if rank[root_x] < rank[root_y] {
                parent[root_x] = root_y;
            } else {
                parent[root_y] = root_x;
                if rank[root_x] == rank[root_y] {
                    rank[root_x] += 1;
                }
            }
        }

        for pair in restrictions.iter() {
            let a = pair[0] as usize;
            let b = pair[1] as usize;
            union(&mut groups, &mut rank, a, b);
        }

        let mut group_map = std::collections::HashMap::new();
        for i in 0..n {
            let root = find(&mut groups, i);
            group_map.entry(root).or_insert_with(HashSet::new).insert(i);
        }

        let mut result = 0;
        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();

        for (root, members) in group_map {
            if !visited.contains(&root) {
                let mut size = members.len();
                let mut count = 0;
                for member in members {
                    if !visited.contains(&member) {
                        visited.insert(member);
                        queue.push_back(member);
                        count += 1;
                    }
                }
                while let Some(current) = queue.pop_front() {
                    for neighbor in 0..n {
                        if current != neighbor && !visited.contains(&neighbor) {
                            let root_current = find(&mut groups, current);
                            let root_neighbor = find(&mut groups, neighbor);
                            if root_current == root_neighbor {
                                visited.insert(neighbor);
                                queue.push_back(neighbor);
                                count += 1;
                            }
                        }
                    }
                }
                result += (count * (count - 1)) / 2;
            }
        }

        result as i32
    }
}
}