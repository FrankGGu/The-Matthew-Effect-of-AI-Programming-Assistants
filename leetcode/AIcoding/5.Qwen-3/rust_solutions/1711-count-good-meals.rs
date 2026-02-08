mod solution {
    use std::collections::HashMap;

    pub fn count_pairs(deliciousness: Vec<i32>) -> i32 {
        const MOD: i64 = 1_000_000_007;
        let mut freq = HashMap::new();
        let mut result = 0;

        for &val in &deliciousness {
            for i in 0..22 {
                let target = 1 << i;
                if target >= val {
                    let complement = target - val;
                    if let Some(&count) = freq.get(&complement) {
                        result = (result + count) % MOD;
                    }
                }
            }
            *freq.entry(val).or_insert(0) += 1;
        }

        result as i32
    }
}