/*1926 그림
어떤 큰 도화지에 그림이 그려져 있을 때, 그 그림의 개수와, 그 그림 중 넓이가 가장 넓은 것의 넓이를 출력하여라. 단, 그림이라는 것은 1로 연결된 것을 한 그림이라고 정의하자. 가로나 세로로 연결된 것은 연결이 된 것이고 대각선으로 연결이 된 것은 떨어진 그림이다. 그림의 넓이란 그림에 포함된 1의 개수이다.

입력
첫째 줄에 도화지의 세로 크기 n(1 ≤ n ≤ 500)과 가로 크기 m(1 ≤ m ≤ 500)이 차례로 주어진다. 두 번째 줄부터 n+1 줄 까지 그림의 정보가 주어진다. (단 그림의 정보는 0과 1이 공백을 두고 주어지며, 0은 색칠이 안된 부분, 1은 색칠이 된 부분을 의미한다)

출력
첫째 줄에는 그림의 개수, 둘째 줄에는 그 중 가장 넓은 그림의 넓이를 출력하여라. 단, 그림이 하나도 없는 경우에는 가장 넓은 그림의 넓이는 0이다.

예제 입력 1
6 5
1 1 0 1 1
0 1 1 0 0
0 0 0 0 0
1 0 1 1 1
0 0 1 1 1
0 0 1 1 1

예제 출력 1
4
9


풀이: 1인거 탐색할 때에 count변수에 +1 하여 넓이 저장
다 탐색하면 그림 배열에 count 추가, 마지막엔 그림배열.count, 그림배열.max 출력
(다 탐색하면 넓이 max값과 현재 count값을 비교해서 최댓값 수정)
*/

// 입력 받기 !
let nm = readLine()!.split(separator: " ").map { Int($0)! }
var image :[[Int]] = []

for _ in 0..<nm[0] {
    image.append(readLine()!.split(separator: " ").map { Int($0)! })
}

let dx: [Int] = [0, 0, 1, -1]
let dy: [Int] = [1, -1, 0, 0]


//BFS 탐색 함수 !
func BFS(_ a: Int, _ b: Int) -> Int {
    var count = 1
    var queue: [(Int, Int)] = []
    queue.append((a, b))
    image[a][b] = 0
    
    while let (x, y) = queue.isEmpty ? nil : queue.removeFirst() { //dequeue할 게 있을 경우에 반복
        for i in 0..<4 { //상하좌우 비교하여 큐 배열에 추가할 예정
            var nx = x + dx[i]
            var ny = y + dy[i]
            
            if nx < 0 || nx >= nm[0] || ny < 0 || ny >= nm[1] {
                continue
            }
            
            if image[nx][ny] == 1 { //해당 좌표의 값이 1일 경우에만 큐 배열에 추가
                image[nx][ny] = 0
                queue.append((nx, ny))
                count += 1
            }
        }
    }
    return count
}


// BFS 실행 ! - (0,0)부터 (n, m)까지 탐색
var imagesArr: [Int] = []
for i in 0..<nm[0] {
    for j in 0..<nm[1] {
        if image[i][j] == 1 {
            imagesArr.append(BFS(i, j))
        }
    }
}


// 결과 출력 !
print(imagesArr.count)
print(imagesArr.max() ?? 0)
