struct Solution;

impl Solution {
    pub fn regions_cut_by_slashes(grid: Vec<String>) -> i32 {
        let n = grid.len();
        let mut parent = vec![0; n * n * 4];
        for i in 0..n * n * 4 {
            parent[i] = i;
        }

        fn find(parent: &mut Vec<i32>, x: i32) -> i32 {
            if parent[x as usize] != x {
                parent[x as usize] = find(parent, parent[x as usize]);
            }
            parent[x as usize]
        }

        fn union(parent: &mut Vec<i32>, x: i32, y: i32) {
            let root_x = find(parent, x);
            let root_y = find(parent, y);
            if root_x != root_y {
                parent[root_x as usize] = root_y;
            }
        }

        for i in 0..n {
            for j in 0..n {
                let idx = (i * n + j) * 4;
                if i > 0 {
                    let up_idx = ((i - 1) * n + j) * 4;
                    union(&mut parent, idx as i32, up_idx + 2);
                }
                if j > 0 {
                    let left_idx = (i * n + (j - 1)) * 4;
                    union(&mut parent, idx as i32, left_idx + 3);
                }
                let c = grid[i][j..j + 1].chars().next().unwrap();
                if c == '/' {
                    union(&mut parent, idx as i32, idx as i32 + 1);
                    union(&mut parent, idx as i32 + 2, idx as i32 + 3);
                } else if c == '\\' {
                    union(&mut parent, idx as i32, idx as i32 + 2);
                    union(&mut parent, idx as i32 + 1, idx as i32 + 3);
                } else {
                    union(&mut parent, idx as i32, idx as i32 + 1);
                    union(&mut parent, idx as i32, idx as i32 + 2);
                    union(&mut parent, idx as i32, idx as i32 + 3);
                }
            }
        }

        let mut roots = std::collections::HashSet::new();
        for i in 0..n * n * 4 {
            roots.insert(find(&mut parent, i as i32));
        }
        roots.len() as i32
    }
}