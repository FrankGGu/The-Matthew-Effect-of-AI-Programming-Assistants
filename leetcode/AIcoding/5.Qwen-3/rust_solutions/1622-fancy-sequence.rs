struct Fancy {
    seq: Vec<i64>,
    add: i64,
    mul: i64,
}

impl Fancy {
    fn new() -> Self {
        Fancy {
            seq: Vec::new(),
            add: 0,
            mul: 1,
        }
    }

    fn append(&mut self, val: i64) {
        self.seq.push(val);
    }

    fn add_all(&mut self, inc: i64) {
        self.add += inc;
    }

    fn mult_all(&mut self, m: i64) {
        self.mul *= m;
        self.add *= m;
    }

    fn get_index(&self, idx: i32) -> i64 {
        let idx = idx as usize;
        let mut res = self.seq[idx];
        res = (res - self.add) * pow(self.mul, 1) / self.mul;
        res
    }
}

fn pow(mut base: i64, mut exp: i64) -> i64 {
    let mut result = 1;
    while exp > 0 {
        if exp % 2 == 1 {
            result *= base;
        }
        base *= base;
        exp /= 2;
    }
    result
}