struct Solution;

impl Solution {
    pub fn can_transform(original: String, target: String) -> bool {
        if original.len() != target.len() {
            return false;
        }

        let mut o_iter = original.chars().enumerate();
        let mut t_iter = target.chars().enumerate();

        loop {
            let o_char = o_iter.next();
            let t_char = t_iter.next();

            match (o_char, t_char) {
                (Some((o_idx, 'L')), Some((t_idx, 'L'))) => {
                    if o_idx < t_idx {
                        return false;
                    }
                },
                (Some((o_idx, 'R')), Some((t_idx, 'R'))) => {
                    if o_idx > t_idx {
                        return false;
                    }
                },
                (Some((_, 'X')), Some((_, 'X'))) => continue,
                (Some(_), Some(_)) => return false,
                _ => break,
            }
        }

        o_iter.next().is_none() && t_iter.next().is_none()
    }
}