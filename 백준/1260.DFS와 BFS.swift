/* 1260
DFS와 BFS
시간 제한 메모리 제한    제출    정답    맞힌 사람    정답 비율
2 초    128 MB    238848    90870    53973    36.911%
문제
그래프를 DFS로 탐색한 결과와 BFS로 탐색한 결과를 출력하는 프로그램을 작성하시오.
단, 방문할 수 있는 정점이 여러 개인 경우에는 정점 번호가 작은 것을 먼저 방문하고, 더 이상 방문할 수 있는 점이 없는 경우 종료한다.
정점 번호는 1번부터 N번까지이다.

입력
첫째 줄에 정점의 개수 N(1 ≤ N ≤ 1,000), 간선의 개수 M(1 ≤ M ≤ 10,000), 탐색을 시작할 정점의 번호 V가 주어진다.
다음 M개의 줄에는 간선이 연결하는 두 정점의 번호가 주어진다. 어떤 두 정점 사이에 여러 개의 간선이 있을 수 있다. 입력으로 주어지는 간선은 양방향이다.

출력
첫째 줄에 DFS를 수행한 결과를, 그 다음 줄에는 BFS를 수행한 결과를 출력한다. V부터 방문된 점을 순서대로 출력하면 된다.

예제 입력 1
4 5 1
1 2
1 3
1 4
2 4
3 4
예제 출력 1
1 2 4 3
1 2 3 4
 
예제 입력 2
5 5 3
5 4
5 2
1 2
3 4
3 1
예제 출력 2
3 1 2 5 4
3 1 4 2 5
 
예제 입력 3
1000 1 1000
999 1000
예제 출력 3
1000 999
1000 999
 
풀이
딕셔너리에 키랑 값으로 넣는 걸로 함
break로 빠져나왔었는데 반복문을 빠져 나가는 곳이 내가 생각했던 곳이 아니어서 dfs 정리 코드를 보고 해결
*/
//import Foundation
// n, m, v, 간선 입력 받기
let nmv = readLine()!.split(separator: " ").map { Int($0)! }
var dic: [Int: Set<Int>] = [:]

// 양방향 그래프 만들기
for _ in 0..<nmv[1] {
    let tmp = readLine()!.split(separator: " ").map {Int($0)!}

    if dic[tmp[0]] == nil {
        dic[tmp[0]] = Set([tmp[1]])
    } else {
        dic[tmp[0]]!.insert(tmp[1])
    }
    
    if dic[tmp[1]] == nil {
        dic[tmp[1]] = Set([tmp[0]])
    } else {
        dic[tmp[1]]!.insert(tmp[0])
    }
}
var visited: [Int] = []
var order: [Int] = []

func BFS(_ start: Int) -> [Int] {
    var queue: [Int] = []
    visited = Array(repeating: 0, count: nmv[0]+1)
    order = []
    
    queue.append(start)
    visited[start] = 1 
    order.append(start) 
    
    while let q = queue.isEmpty ? nil : queue.removeFirst() { //TODO: 시간 줄이기 (큐 선언)
        if dic[q] == nil { continue }
        for nx in dic[q]!.sorted() { // [3: (1,3)] // TODO: 시간 줄이기 sort
            if visited[nx] == 1 { continue }
            queue.append(nx)
            visited[nx] = 1
            order.append(nx)
        }
    }
    return order
}

func DFS(_ start: Int) -> [Int] {
    var stack: [Int] = []
    order = []
    visited = Array(repeating: 0, count: nmv[0]+1)
     
    stack.append(start)
    visited[start] = 1
    order.append(start)

    outer: while !stack.isEmpty {
        let top = stack[stack.count-1]
        guard let neighbors = dic[top], !neighbors.isEmpty else { //MARK: 이부분에서 런타임 에러 났었다
            stack.removeLast()
            continue
        }
        for nx in neighbors.sorted() {
            if visited[nx] == 0 {
                visited[nx] = 1
                order.append(nx)
                stack.append(nx)
                continue outer
            }
        }
        stack.removeLast()
    }
    return order
}

print(DFS(nmv[2]).map { String($0) }.joined(separator: " "))
print(BFS(nmv[2]).map { String($0) }.joined(separator: " "))
