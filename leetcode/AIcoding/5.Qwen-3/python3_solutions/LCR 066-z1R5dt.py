class MapSum:

    def __init__(self):
        self.root = {}

    def insert(self, key: str, val: int) -> None:
        node = self.root
        for c in key:
            if c not in node:
                node[c] = {}
            node = node[c]
        node['#'] = val

    def sum(self, prefix: str) -> int:
        node = self.root
        for c in prefix:
            if c not in node:
                return 0
            node = node[c]
        return self._dfs(node)

    def _dfs(self, node):
        total = 0
        for key in node:
            if key == '#':
                total += node[key]
            else:
                total += self._dfs(node[key])
        return total