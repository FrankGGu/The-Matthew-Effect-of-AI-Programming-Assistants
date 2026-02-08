function accountsMerge(accounts) {
    const parent = {};

    function find(x) {
        if (parent[x] !== x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    function union(x, y) {
        const rootX = find(x);
        const rootY = find(y);
        if (rootX !== rootY) {
            parent[rootY] = rootX;
        }
    }

    const emailToName = {};
    const emailToIndex = {};

    for (let i = 0; i < accounts.length; i++) {
        const account = accounts[i];
        const name = account[0];
        const emails = account.slice(1);

        for (const email of emails) {
            emailToName[email] = name;
            if (!parent[email]) {
                parent[email] = email;
            }
        }

        for (let j = 1; j < emails.length; j++) {
            union(emails[0], emails[j]);
        }
    }

    const result = {};
    for (const email in parent) {
        const root = find(email);
        if (!result[root]) {
            result[root] = [];
        }
        result[root].push(email);
    }

    const merged = [];
    for (const key in result) {
        const emails = result[key].sort();
        merged.push([emailToName[emails[0]], ...emails]);
    }

    return merged;
}