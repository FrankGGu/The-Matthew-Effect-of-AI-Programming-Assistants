function smallestMissingGrowthValue(root) {
    const result = new Array(100001).fill(0);
    const visited = new Set();
    const allGenes = new Set();

    function dfs(node) {
        if (!node) return;
        allGenes.add(node.val);
        dfs(node.left);
        dfs(node.right);
    }

    dfs(root);

    for (let i = 1; i <= 100000; i++) {
        if (!allGenes.has(i)) {
            result[i] = i;
            break;
        }
    }

    const geneToIndex = {};
    let index = 0;
    for (let i = 1; i <= 100000; i++) {
        if (allGenes.has(i)) {
            geneToIndex[i] = index++;
        }
    }

    const parent = new Array(100001).fill(-1);
    const children = new Array(100001).fill(null).map(() => []);

    function buildTree(node) {
        if (!node) return;
        if (node.left) {
            parent[node.left.val] = node.val;
            children[node.val].push(node.left.val);
        }
        if (node.right) {
            parent[node.right.val] = node.val;
            children[node.val].push(node.right.val);
        }
        buildTree(node.left);
        buildTree(node.right);
    }

    buildTree(root);

    const maxGene = Math.max(...Array.from(allGenes));
    const missing = new Array(maxGene + 2).fill(0);
    for (let i = 1; i <= maxGene + 1; i++) {
        missing[i] = i;
    }

    const seen = new Set();
    const queue = [root.val];
    while (queue.length > 0) {
        const node = queue.shift();
        if (seen.has(node)) continue;
        seen.add(node);
        for (const child of children[node]) {
            queue.push(child);
        }
    }

    const geneSet = new Set([...allGenes]);
    const geneList = [...geneSet].sort((a, b) => a - b);
    const geneIndexMap = {};
    for (let i = 0; i < geneList.length; i++) {
        geneIndexMap[geneList[i]] = i;
    }

    const size = geneList.length;
    const dp = new Array(size).fill(0);
    const pos = new Array(size).fill(0);
    for (let i = 0; i < size; i++) {
        pos[i] = geneIndexMap[geneList[i]];
    }

    for (let i = 0; i < size; i++) {
        dp[i] = i;
    }

    for (let i = 0; i < size; i++) {
        for (let j = i + 1; j < size; j++) {
            if (pos[j] < pos[i]) {
                [dp[i], dp[j]] = [dp[j], dp[i]];
            }
        }
    }

    for (let i = 0; i < size; i++) {
        if (dp[i] !== i) {
            for (let j = i + 1; j < size; j++) {
                if (dp[j] === i) {
                    [dp[i], dp[j]] = [dp[j], dp[i]];
                    break;
                }
            }
        }
    }

    const answer = new Array(100001).fill(0);
    for (let i = 0; i < size; i++) {
        answer[geneList[i]] = missing[dp[i] + 1];
    }

    for (let i = 1; i <= 100000; i++) {
        if (!geneSet.has(i)) {
            answer[i] = i;
        }
    }

    return answer;
}