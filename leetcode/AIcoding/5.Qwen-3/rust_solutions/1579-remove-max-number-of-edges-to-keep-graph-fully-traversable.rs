struct UnionFind {
    parent: Vec<usize>,
    rank: Vec<usize>,
}

impl UnionFind {
    fn new(n: usize) -> Self {
        Self {
            parent: (0..n).collect(),
            rank: vec![1; n],
        }
    }

    fn find(&mut self, x: usize) -> usize {
        if self.parent[x] != x {
            self.parent[x] = self.find(self.parent[x]);
        }
        self.parent[x]
    }

    fn union(&mut self, x: usize, y: usize) -> bool {
        let root_x = self.find(x);
        let root_y = self.find(y);
        if root_x == root_y {
            return false;
        }
        if self.rank[root_x] < self.rank[root_y] {
            self.parent[root_x] = root_y;
        } else {
            self.parent[root_y] = root_x;
            if self.rank[root_x] == self.rank[root_y] {
                self.rank[root_x] += 1;
            }
        }
        true
    }
}

impl Solution {
    pub fn max_num_edges_to_remove(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut uf1 = UnionFind::new(n);
        let mut uf2 = UnionFind::new(n);
        let mut count = 0;

        for edge in &edges {
            let u = edge[1] as usize;
            let v = edge[2] as usize;
            if edge[0] == 2 {
                if uf1.union(u, v) {
                    count += 1;
                }
                if uf2.union(u, v) {
                    count += 1;
                }
            }
        }

        for edge in &edges {
            let u = edge[1] as usize;
            let v = edge[2] as usize;
            if edge[0] == 1 {
                if uf1.union(u, v) {
                    count += 1;
                }
            }
        }

        for edge in &edges {
            let u = edge[1] as usize;
            let v = edge[2] as usize;
            if edge[0] == 2 {
                if uf2.union(u, v) {
                    count += 1;
                }
            }
        }

        let mut root1 = uf1.find(0);
        let mut root2 = uf2.find(0);

        for i in 1..n {
            if uf1.find(i) != root1 || uf2.find(i) != root2 {
                return -1;
            }
        }

        (edges.len() as i32 - count)
    }
}