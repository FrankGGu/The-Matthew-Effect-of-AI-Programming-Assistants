struct Solution;

impl Solution {
    pub fn find_latest_group_size_m(arr: Vec<i32>, m: i32) -> i32 {
        let n = arr.len();
        let mut parent = vec![0; n];
        let mut size = vec![1; n];

        for i in 0..n {
            parent[i] = i as i32;
        }

        let mut result = -1;

        for (i, &pos) in arr.iter().enumerate() {
            let p = pos as usize;
            let mut left = p;
            let mut right = p;

            if p > 0 && parent[p - 1] != 0 {
                left = find(&mut parent, p - 1);
            }

            if p < n - 1 && parent[p + 1] != 0 {
                right = find(&mut parent, p + 1);
            }

            union(&mut parent, &mut size, left, p);
            union(&mut parent, &mut size, p, right);

            let root = find(&mut parent, p);
            if size[root] == m {
                result = i as i32 + 1;
            }
        }

        result
    }

    fn find(parent: &mut Vec<i32>, x: usize) -> usize {
        if parent[x] != x as i32 {
            parent[x] = Solution::find(parent, parent[x] as usize);
        }
        parent[x] as usize
    }

    fn union(parent: &mut Vec<i32>, size: &mut Vec<i32>, x: usize, y: usize) {
        let root_x = Solution::find(parent, x);
        let root_y = Solution::find(parent, y);

        if root_x != root_y {
            if size[root_x] < size[root_y] {
                std::mem::swap(&mut parent[root_x], &mut parent[root_y]);
                std::mem::swap(&mut size[root_x], &mut size[root_y]);
            }
            parent[root_y] = root_x as i32;
            size[root_x] += size[root_y];
        }
    }
}