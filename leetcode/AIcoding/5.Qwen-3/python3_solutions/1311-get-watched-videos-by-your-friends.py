from collections import deque, defaultdict
import heapq

class Solution:
    def watchedVideosByFriends(self, friends: List[List[int]], watchedVideos: List[List[str]], id: int, level: int) -> List[str]:
        visited = set()
        queue = deque()
        queue.append((id, 0))
        visited.add(id)
        result = defaultdict(int)

        while queue:
            current_id, current_level = queue.popleft()
            if current_level == level:
                for video in watchedVideos[current_id]:
                    result[video] += 1
            elif current_level < level:
                for friend in friends[current_id]:
                    if friend not in visited:
                        visited.add(friend)
                        queue.append((friend, current_level + 1))

        return [video for video, count in sorted(result.items(), key=lambda x: (-x[1], x[0]))]