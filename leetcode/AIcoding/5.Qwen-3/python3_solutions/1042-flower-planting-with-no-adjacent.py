def gardenNoAdj(n, paths):
    from collections import defaultdict

    graph = defaultdict(list)
    for a, b in paths:
        graph[a].append(b)
        graph[b].append(a)

    result = [0] * n

    for i in range(1, n + 1):
        used = set()
        for neighbor in graph[i]:
            if result[neighbor - 1] != 0:
                used.add(result[neighbor - 1])
        for color in range(1, 5):
            if color not in used:
                result[i - 1] = color
                break

    return result