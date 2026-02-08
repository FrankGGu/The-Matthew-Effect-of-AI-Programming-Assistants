class Solution:
    def getFolderNames(self, names: List[str]) -> List[str]:
        from collections import defaultdict

        name_count = defaultdict(int)
        result = []

        for name in names:
            if name_count[name] == 0:
                result.append(name)
            else:
                new_name = f"{name}.{name_count[name]}"
                result.append(new_name)
            name_count[name] += 1

        return result