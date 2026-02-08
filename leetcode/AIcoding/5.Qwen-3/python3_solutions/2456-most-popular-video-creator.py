class Solution:
    def mostPopular(self, creators: list[str], ids: list[str], views: list[int]) -> list[list[str]]:
        from collections import defaultdict

        popular = defaultdict(lambda: [0, ""])
        max_view = 0

        for i in range(len(creators)):
            creator = creators[i]
            vid = ids[i]
            view = views[i]

            if popular[creator][0] < view or (popular[creator][0] == view and popular[creator][1] > vid):
                popular[creator] = [view, vid]

            max_view = max(max_view, view)

        result = []
        for creator in popular:
            if popular[creator][0] == max_view:
                result.append([creator, popular[creator][1]])

        return result