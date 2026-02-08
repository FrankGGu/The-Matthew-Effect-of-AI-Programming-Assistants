struct Solution;

impl Solution {
    pub fn execute_instructions(n: i32, startPos: Vec<i32>, s: String) -> Vec<i32> {
        let mut result = Vec::new();
        let directions = vec![vec![-1, 0], vec![1, 0], vec![0, -1], vec![0, 1]];
        let dir_chars = ['U', 'D', 'L', 'R'];

        for i in 0..s.len() {
            let mut steps = 0;
            let mut current_pos = startPos.clone();
            for j in i..s.len() {
                let c = s.chars().nth(j).unwrap();
                let dir_idx = dir_chars.iter().position(|&d| d == c).unwrap();
                let (dx, dy) = (directions[dir_idx][0], directions[dir_idx][1]);
                current_pos[0] += dx;
                current_pos[1] += dy;
                if current_pos[0] < 0 || current_pos[0] >= n || current_pos[1] < 0 || current_pos[1] >= n {
                    break;
                }
                steps += 1;
            }
            result.push(steps);
        }

        result
    }
}