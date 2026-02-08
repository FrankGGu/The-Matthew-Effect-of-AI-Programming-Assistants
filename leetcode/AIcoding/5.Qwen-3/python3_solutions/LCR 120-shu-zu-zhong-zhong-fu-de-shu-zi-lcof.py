class Solution:
    def findDuplicates(self, paths: List[str]) -> List[str]:
        from collections import defaultdict

        content_map = defaultdict(list)

        for path in paths:
            parts = path.split()
            directory = parts[0]
            for file in parts[1:]:
                file_name, content = file.split('(')
                content = content.rstrip(')')
                content_map[content].append(directory + '/' + file_name)

        result = []
        for files in content_map.values():
            if len(files) >= 2:
                result.extend(files)

        return result