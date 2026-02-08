struct Solution;

impl Solution {
    pub fn count_artifacts(cover: i32, artifacts: Vec<Vec<i32>>, parts: Vec<Vec<i32>>) -> i32 {
        let mut covered = vec![vec![false; cover as usize]; cover as usize];

        for part in parts {
            let x = part[0] as usize;
            let y = part[1] as usize;
            if x < cover as usize && y < cover as usize {
                covered[x][y] = true;
            }
        }

        let mut count = 0;

        for artifact in artifacts {
            let x1 = artifact[0] as usize;
            let y1 = artifact[1] as usize;
            let x2 = artifact[2] as usize;
            let y2 = artifact[3] as usize;

            let mut all_covered = true;

            for x in x1..=x2 {
                for y in y1..=y2 {
                    if !covered[x][y] {
                        all_covered = false;
                        break;
                    }
                }
                if !all_covered {
                    break;
                }
            }

            if all_covered {
                count += 1;
            }
        }

        count
    }
}