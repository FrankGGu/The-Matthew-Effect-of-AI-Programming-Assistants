class Solution:
    def processTasks(self, tasks: List[str], batchSize: int) -> List[str]:
        result = []
        for i in range(0, len(tasks), batchSize):
            batch = tasks[i:i+batchSize]
            result.extend(batch)
        return result