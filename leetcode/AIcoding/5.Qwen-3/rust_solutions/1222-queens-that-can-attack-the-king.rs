struct Solution;

impl Solution {
    pub fn queens_attack_king(queens: Vec<Vec<i32>>, king: Vec<i32>) -> Vec<Vec<i33> {
        let mut board = [[false; 8]; 8];
        for q in queens {
            let x = q[0] as usize;
            let y = q[1] as usize;
            board[x][y] = true;
        }

        let directions = [
            (-1, -1), (-1, 0), (-1, 1),
            (0, -1),          (0, 1),
            (1, -1),  (1, 0), (1, 1),
        ];

        let mut result = Vec::new();
        let king_x = king[0] as usize;
        let king_y = king[1] as usize;

        for &(dx, dy) in &directions {
            let mut x = king_x;
            let mut y = king_y;
            while x < 8 && y < 8 && x >= 0 && y >= 0 {
                x = x.wrapping_add(dx as usize);
                y = y.wrapping_add(dy as usize);
                if x < 8 && y < 8 && board[x][y] {
                    result.push(vec![x as i32, y as i32]);
                    break;
                }
            }
        }

        result
    }
}