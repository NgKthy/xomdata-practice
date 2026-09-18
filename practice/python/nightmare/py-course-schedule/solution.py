# Xom Data · Finish all courses (course schedule)
# Problem: https://xomdata.com/practice/py-course-schedule
# Solved: 2026-09-18

from collections import deque

def can_finish(n, prerequisites):
    graph = [[] for _ in range(n)]
    indegree = [0] * n

    for a, b in prerequisites:
        graph[b].append(a)
        indegree[a] += 1

    queue = deque([i for i in range(n) if indegree[i] == 0])
    learned = 0

    while queue:
        course = queue.popleft()
        learned += 1

        for next_course in graph[course]:
            indegree[next_course] -= 1
            if indegree[next_course] == 0:
                queue.append(next_course)

    return learned == n
