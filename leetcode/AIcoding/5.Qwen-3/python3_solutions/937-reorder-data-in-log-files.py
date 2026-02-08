class Solution:
    def reorderLogFiles(self, logs: List[str]) -> List[str]:
        def custom_sort(log):
            identifier, content = log.split(' ', 1)
            if content[0].isalpha():
                return (0, content, identifier)
            else:
                return (1, '', '')

        return sorted(logs, key=custom_sort)