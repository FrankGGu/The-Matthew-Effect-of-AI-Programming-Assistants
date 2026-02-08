struct UnionFind {
    parent: Vec<usize>,
}

impl UnionFind {
    fn new(size: usize) -> Self {
        Self {
            parent: (0..size).collect(),
        }
    }

    fn find(&mut self, x: usize) -> usize {
        if self.parent[x] != x {
            self.parent[x] = self.find(self.parent[x]);
        }
        self.parent[x]
    }

    fn union(&mut self, x: usize, y: usize) {
        let root_x = self.find(x);
        let root_y = self.find(y);
        if root_x != root_y {
            self.parent[root_y] = root_x;
        }
    }
}

fn smallest_equivalent_string(lex_order: &str, s1: &str, s2: &str) -> String {
    let mut uf = UnionFind::new(26);
    for (&c1, &c2) in s1.bytes().zip(s2.bytes()) {
        let a = (c1 - b'a') as usize;
        let b = (c2 - b'a') as usize;
        uf.union(a, b);
    }

    let mut result = Vec::with_capacity(s1.len());
    for c in s1.bytes() {
        let idx = (c - b'a') as usize;
        let root = uf.find(idx);
        result.push((b'a' + root as u8) as char);
    }

    result.into_iter().collect()
}

pub fn main() {
    let lex_order = "abcdefghijklmnopqrstuvwxyz";
    let s1 = "abc";
    let s2 = "cba";
    println!("{}", smallest_equivalent_string(lex_order, s1, s2));
}