function analyzeOrganizationHierarchy(org) {
    const map = {};
    for (const [id, manager] of org) {
        if (!map[manager]) map[manager] = [];
        map[manager].push(id);
    }

    const result = [];

    function dfs(manager) {
        if (!map[manager]) return;
        for (const id of map[manager]) {
            result.push([manager, id]);
            dfs(id);
        }
    }

    for (const manager in map) {
        dfs(manager);
    }

    return result;
}