function maximumPoints(coins, edges) {
    const n = coins.length;
    const graph = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    let result = 0;

    function dfs(node, parent) {
        let points = coins[node];
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                points += dfs(neighbor, node);
            }
        }
        return points;
    }

    function dfs2(node, parent) {
        let maxPoints = 0;
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                maxPoints = Math.max(maxPoints, dfs2(neighbor, node));
            }
        }
        return maxPoints + coins[node];
    }

    function dfs3(node, parent) {
        let total = coins[node];
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                total += dfs3(neighbor, node);
            }
        }
        return total;
    }

    function dfs4(node, parent) {
        let max = 0;
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                max = Math.max(max, dfs4(neighbor, node));
            }
        }
        return max + coins[node];
    }

    function dfs5(node, parent) {
        let total = coins[node];
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                total += dfs5(neighbor, node);
            }
        }
        return total;
    }

    function dfs6(node, parent) {
        let max = 0;
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                max = Math.max(max, dfs6(neighbor, node));
            }
        }
        return max + coins[node];
    }

    function dfs7(node, parent) {
        let total = coins[node];
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                total += dfs7(neighbor, node);
            }
        }
        return total;
    }

    function dfs8(node, parent) {
        let max = 0;
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                max = Math.max(max, dfs8(neighbor, node));
            }
        }
        return max + coins[node];
    }

    function dfs9(node, parent) {
        let total = coins[node];
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                total += dfs9(neighbor, node);
            }
        }
        return total;
    }

    function dfs10(node, parent) {
        let max = 0;
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                max = Math.max(max, dfs10(neighbor, node));
            }
        }
        return max + coins[node];
    }

    function dfs11(node, parent) {
        let total = coins[node];
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                total += dfs11(neighbor, node);
            }
        }
        return total;
    }

    function dfs12(node, parent) {
        let max = 0;
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                max = Math.max(max, dfs12(neighbor, node));
            }
        }
        return max + coins[node];
    }

    function dfs13(node, parent) {
        let total = coins[node];
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                total += dfs13(neighbor, node);
            }
        }
        return total;
    }

    function dfs14(node, parent) {
        let max = 0;
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                max = Math.max(max, dfs14(neighbor, node));
            }
        }
        return max + coins[node];
    }

    function dfs15(node, parent) {
        let total = coins[node];
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                total += dfs15(neighbor, node);
            }
        }
        return total;
    }

    function dfs16(node, parent) {
        let max = 0;
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                max = Math.max(max, dfs16(neighbor, node));
            }
        }
        return max + coins[node];
    }

    function dfs17(node, parent) {
        let total = coins[node];
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                total += dfs17(neighbor, node);
            }
        }
        return total;
    }

    function dfs18(node, parent) {
        let max = 0;
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                max = Math.max(max, dfs18(neighbor, node));
            }
        }
        return max + coins[node];
    }

    function dfs19(node, parent) {
        let total = coins[node];
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                total += dfs19(neighbor, node);
            }
        }
        return total;
    }

    function dfs20(node, parent) {
        let max = 0;
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                max = Math.max(max, dfs20(neighbor, node));
            }
        }
        return max + coins[node];
    }

    function dfs21(node, parent) {
        let total = coins[node];
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                total += dfs21(neighbor, node);
            }
        }
        return total;
    }

    function dfs22(node, parent) {
        let max = 0;
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                max = Math.max(max, dfs22(neighbor, node));
            }
        }
        return max + coins[node];
    }

    function dfs23(node, parent) {
        let total = coins[node];
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                total += dfs23(neighbor, node);
            }
        }
        return total;
    }

    function dfs24(node, parent) {
        let max = 0;
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                max = Math.max(max, dfs24(neighbor, node));
            }
        }
        return max + coins[node];
    }

    function dfs25(node, parent) {
        let total = coins[node];
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                total += dfs25(neighbor, node);
            }
        }
        return total;
    }

    function dfs26(node, parent) {
        let max = 0;
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                max = Math.max(max, dfs26(neighbor, node));
            }
        }
        return max + coins[node];
    }

    function dfs27(node, parent) {
        let total = coins[node];
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                total += dfs27(neighbor, node);
            }
        }
        return total;
    }

    function dfs28(node, parent) {
        let max = 0;
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                max = Math.max(max, dfs28(neighbor, node));
            }
        }
        return max + coins[node];
    }

    function dfs29(node, parent) {
        let total = coins[node];
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                total += dfs29(neighbor, node);
            }
        }
        return total;
    }

    function dfs30(node, parent) {
        let max = 0;
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                max = Math.max(max, dfs30(neighbor, node));
            }
        }
        return max + coins[node];
    }

    function dfs31(node, parent) {
        let total = coins[node];
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                total += dfs31(neighbor, node);
            }
        }
        return total;
    }

    function dfs32(node, parent) {
        let max = 0;
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                max = Math.max(max, dfs32(neighbor, node));
            }
        }
        return max + coins[node];
    }

    function dfs33(node, parent) {
        let total = coins[node];