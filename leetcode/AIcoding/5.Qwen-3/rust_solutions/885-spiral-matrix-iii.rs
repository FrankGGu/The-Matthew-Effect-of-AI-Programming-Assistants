impl Solution {
    pub fn spiral_matrix_iii(mut m: i32, mut n: i32, mut k: i32) -> Vec<Vec<i32>> {
        let mut result = vec![vec![0; 2]; k as usize];
        let (mut r, mut c) = (0, 0);
        let (mut dr, mut dc) = (0, 1);
        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];
        let mut step = 1;
        let mut dir = 0;

        for i in 0..k {
            result[i as usize][0] = r;
            result[i as usize][1] = c;

            if i == k - 1 {
                break;
            }

            if step == 0 {
                dir = (dir + 1) % 4;
                step = if dir % 2 == 0 { step + 1 } else { step };
            }

            let (d_r, d_c) = directions[dir];
            r += d_r;
            c += d_c;
            step -= 1;
        }

        result
    }
}