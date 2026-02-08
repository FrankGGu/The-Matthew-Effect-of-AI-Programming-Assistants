struct Solution;

impl Solution {
    pub fn find_redundant_connection(mut edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n = edges.len();
        let mut parent = (0..n as i32).collect::<Vec<_>>();

        fn find(parent: &mut Vec<i32>, x: i32) -> i32 {
            if parent[x as usize] != x {
                parent[x as usize] = find(parent, parent[x as usize]);
            }
            parent[x as usize]
        }

        fn union(parent: &mut Vec<i32>, x: i32, y: i32) -> bool {
            let root_x = find(parent, x);
            let root_y = find(parent, y);
            if root_x == root_y {
                return false;
            }
            parent[root_y as usize] = root_x;
            true
        }

        for edge in edges.iter() {
            let x = edge[0];
            let y = edge[1];
            if !union(&mut parent, x, y) {
                return edge.clone();
            }
        }

        vec![]
    }
}