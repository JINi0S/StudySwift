/* 10026
문제
적록색약은 빨간색과 초록색의 차이를 거의 느끼지 못한다. 따라서, 적록색약인 사람이 보는 그림은 아닌 사람이 보는 그림과는 좀 다를 수 있다.

크기가 N×N인 그리드의 각 칸에 R(빨강), G(초록), B(파랑) 중 하나를 색칠한 그림이 있다. 그림은 몇 개의 구역으로 나뉘어져 있는데, 구역은 같은 색으로 이루어져 있다. 또, 같은 색상이 상하좌우로 인접해 있는 경우에 두 글자는 같은 구역에 속한다. (색상의 차이를 거의 느끼지 못하는 경우도 같은 색상이라 한다)

예를 들어, 그림이 아래와 같은 경우에

RRRBB
GGBBB
BBBRR
BBRRR
RRRRR
적록색약이 아닌 사람이 봤을 때 구역의 수는 총 4개이다. (빨강 2, 파랑 1, 초록 1) 하지만, 적록색약인 사람은 구역을 3개 볼 수 있다. (빨강-초록 2, 파랑 1)

그림이 입력으로 주어졌을 때, 적록색약인 사람이 봤을 때와 아닌 사람이 봤을 때 구역의 수를 구하는 프로그램을 작성하시오.

입력
첫째 줄에 N이 주어진다. (1 ≤ N ≤ 100)

둘째 줄부터 N개 줄에는 그림이 주어진다.

출력
적록색약이 아닌 사람이 봤을 때의 구역의 개수와 적록색약인 사람이 봤을 때의 구역의 수를 공백으로 구분해 출력한다.

예제 입력 1
5
RRRBB
GGBBB
BBBRR
BBRRR
RRRRR
예제 출력 1
4 3
*/
//비교대상을 rg, b로 나누고, rg인 경우 .. --> 수정
//큐를 하나만 써서 할 수 있는 방법은 없을까?!?!!?!?!?!?!?!?!

import Foundation
final class FileIO {
    private var buffer:[UInt8]
    private var index: Int
    
    init(fileHandle: FileHandle = FileHandle.standardInput) {
        buffer = Array(fileHandle.readDataToEndOfFile())+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
        index = 0
    }
    
    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }
        
        return buffer.withUnsafeBufferPointer { $0[index] }
    }
    
    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true
        
        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        if now == 45{ isPositive.toggle(); now = read() } // 음수 처리
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }
        
        return sum * (isPositive ? 1:-1)
    }
    
    @inline(__always) func readString() -> String {
        var str = ""
        var now = read()
        
        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        
        while now != 10
                && now != 32 && now != 0 {
            str += String(bytes: [now], encoding: .ascii)!
            now = read()
        }
        
        return str
    }
}

let file = FileIO()
let num = file.readInt()

// 입력받아 일반 맵과 컬러맵 구현
var paint: [[Character]] = []
var colorPaint: [[Character]] = []
for _ in 0..<num {
    var input = file.readString()
    paint.append(input.map {$0})
    input = input.replacingOccurrences(of: "G", with: "R")
    colorPaint.append(input.map {$0})
}

// 방향 계산할 변수 설정
let dx = [0, 0, 1, -1]
let dy = [1, -1, 0, 0]

// 결과 카운트할 변수 설정
var countNormal: Int = 0
var countColor: Int = 0

// BFS 함수 구현
func BFS(x: Int, y: Int, arr: inout [[Character]]) {
    //큐 선언, 시작값을 큐에 삽입
    var queue: [(Int, Int)] = []
    queue.append((x, y))
   
    //비교할 변수 선언, 시작값 방문처리
    let compare: Character = arr[x][y]
    arr[x][y] = "Z"
    
    //dequeue가능한 경우에만 반복 !
    while let (qX, qY) = queue.isEmpty ? nil : queue.removeFirst() {
        for i in 0..<4 {
            let nX = qX + dx[i]
            let nY = qY + dy[i]
                    
            if nX < 0 || nX >= num || nY < 0 || nY >= num || arr[nX][nY] == "Z" {
                continue
            }
            
            if arr[nX][nY] == compare {
                arr[nX][nY] = "Z" //이놈땜에 오래걸렸다 !! 방문처리하고 넘어가기 앞단의 for반복문에서 계산하는 코드였는데, 큐에 삽입하기 전에 방문처리를 해야 맞는 거였다.,,
                queue.append((nX, nY))
            }
        }
    }
}

// 일반 - (0,0)부터 (num-1, num-1)까지 탐색하며 방문하지 않은 노드인 경우 BFS 실행
for i in 0..<num {
    for j in 0..<num {
        if paint[i][j] != "Z" {
            BFS(x: i, y: j, arr: &paint)
            countNormal += 1
        }
    }
}

// 색맹 - (0,0)부터 (num-1, num-1)까지 탐색하며 방문하지 않은 노드인 경우 BFS 실행
for i in 0..<num {
    for j in 0..<num {
        if colorPaint[i][j] != "Z" {
            BFS(x: i, y: j, arr: &colorPaint)
            countColor += 1
        }
    }
}

print(countNormal, countColor)
