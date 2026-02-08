class ThroneInheritance:

    def __init__(self, kingName: str):
        self.king = kingName
        self.children = {}
        self.dead = set()

    def birth(self, parentName: str, childName: str) -> None:
        if parentName not in self.children:
            self.children[parentName] = []
        self.children[parentName].append(childName)

    def death(self, name: str) -> None:
        self.dead.add(name)

    def getInheritanceOrder(self) -> List[str]:
        result = []
        self.dfs(self.king, result)
        return result

    def dfs(self, name: str, result: List[str]) -> None:
        if name not in self.dead:
            result.append(name)
        if name in self.children:
            for child in self.children[name]:
                self.dfs(child, result)