struct Solution;

impl Solution {
    pub fn find_circle_num(m: Vec<Vec<i32>>) -> i32 {
        let n = m.len();
        let mut visited = vec![false; n];
        let mut count = 0;

        for i in 0..n {
            if !visited[i] {
                Self::dfs(i, &m, &mut visited);
                count += 1;
            }
        }

        count
    }

    fn dfs(i: usize, m: &Vec<Vec<i32>>, visited: &mut Vec<bool>) {
        for j in 0..m[i].len() {
            if m[i][j] == 1 && !visited[j] {
                visited[j] = true;
                Self::dfs(j, m, visited);
            }
        }
    }
}