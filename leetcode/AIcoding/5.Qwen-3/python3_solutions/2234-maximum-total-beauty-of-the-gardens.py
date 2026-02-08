class Solution:
    def maximumTotalBeauty(self, flowers: List[int], newFlowers: int, cost: int, minBloom: int, maxBloom: int) -> int:
        from collections import defaultdict

        def count_flowers(flower_counts):
            total = 0
            for c in flower_counts.values():
                total += c
            return total

        def get_max_beauty(flower_counts):
            beauty = 0
            for f in flower_counts:
                if f >= minBloom and f <= maxBloom:
                    beauty += f
            return beauty

        flower_counts = defaultdict(int)
        for f in flowers:
            if f >= minBloom and f <= maxBloom:
                flower_counts[f] += 1

        sorted_flowers = sorted(flower_counts.keys())
        n = len(sorted_flowers)

        i = 0
        while i < n and sorted_flowers[i] < minBloom:
            i += 1

        j = n - 1
        while j >= 0 and sorted_flowers[j] > maxBloom:
            j -= 1

        if i > j:
            return 0

        total_flowers = count_flowers(flower_counts)
        remaining = newFlowers

        res = 0

        for i in range(n):
            if sorted_flowers[i] < minBloom:
                continue
            if sorted_flowers[i] > maxBloom:
                continue
            current = sorted_flowers[i]
            needed = (current - minBloom) * flower_counts[current]
            if needed <= remaining:
                remaining -= needed
                flower_counts[current] -= 1
                if flower_counts[current] == 0:
                    del flower_counts[current]
                flower_counts[minBloom] += 1
                res = max(res, get_max_beauty(flower_counts))
                flower_counts[minBloom] -= 1
                if flower_counts[minBloom] == 0:
                    del flower_counts[minBloom]
                flower_counts[current] += 1
                remaining += needed

        for i in range(n):
            if sorted_flowers[i] < minBloom:
                continue
            if sorted_flowers[i] > maxBloom:
                continue
            current = sorted_flowers[i]
            needed = (maxBloom - current) * flower_counts[current]
            if needed <= remaining:
                remaining -= needed
                flower_counts[current] -= 1
                if flower_counts[current] == 0:
                    del flower_counts[current]
                flower_counts[maxBloom] += 1
                res = max(res, get_max_beauty(flower_counts))
                flower_counts[maxBloom] -= 1
                if flower_counts[maxBloom] == 0:
                    del flower_counts[maxBloom]
                flower_counts[current] += 1
                remaining += needed

        for i in range(n):
            if sorted_flowers[i] < minBloom:
                continue
            if sorted_flowers[i] > maxBloom:
                continue
            current = sorted_flowers[i]
            if flower_counts[current] > 0:
                flower_counts[current] -= 1
                if flower_counts[current] == 0:
                    del flower_counts[current]
                flower_counts[minBloom] += 1
                res = max(res, get_max_beauty(flower_counts))
                flower_counts[minBloom] -= 1
                if flower_counts[minBloom] == 0:
                    del flower_counts[minBloom]
                flower_counts[current] += 1

        return res