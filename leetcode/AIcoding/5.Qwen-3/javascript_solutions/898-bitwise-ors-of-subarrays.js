var subarrayBitwiseORs = function(arr) {
    let result = new Set();
    let current = new Set();

    for (let num of arr) {
        let next = new Set();
        next.add(num);
        for (let x of current) {
            next.add(x | num);
        }
        current = next;
        result = new Set([...result, ...current]);
    }

    return result.size;
};