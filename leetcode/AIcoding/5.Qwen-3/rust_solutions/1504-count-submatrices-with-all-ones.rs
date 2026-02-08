impl Solution {
    pub fn num_submat(mat: Vec<Vec<i32>>) -> i32 {
        let m = mat.len();
        let n = mat[0].len();
        let mut count = 0;

        for i in 0..m {
            for j in 0..n {
                if mat[i][j] == 1 {
                    let mut min_width = n;
                    for k in i..m {
                        min_width = min_width.min(n);
                        for l in j..min_width {
                            if mat[k][l] == 1 {
                                count += 1;
                                min_width = min_width.min(l - j + 1);
                            } else {
                                break;
                            }
                        }
                    }
                }
            }
        }

        count
    }
}