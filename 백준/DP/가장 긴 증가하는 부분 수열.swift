/* 11053번 가장 긴 증가하는 부분 수열
시간 제한    메모리 제한    제출    정답    맞힌 사람    정답 비율
1 초    256 MB    143034    56822    37597    37.701%
문제
수열 A가 주어졌을 때, 가장 긴 증가하는 부분 수열을 구하는 프로그램을 작성하시오.
예를 들어, 수열 A = {10, 20, 10, 30, 20, 50} 인 경우에 가장 긴 증가하는 부분 수열은 A = {10, 20, (10), 30, (20), 50} 이고, 길이는 4이다.

입력
첫째 줄에 수열 A의 크기 N (1 ≤ N ≤ 1,000)이 주어진다.
 

출력
첫째 줄에 수열 A의 가장 긴 증가하는 부분 수열의 길이를 출력한다.

예제 입력 1
6
10 20 10 30 20 50
예제 출력 1
4
*/
//i보다 작은 인덱스에서 arr[i-1]보다 작은 값들에 대한 result[]최댓값
//앞에 작은게 있으면 그 값 중 result 최댓값에 +1
//마지막 값이 아닌 맥스값을 출력해야한다 !

let N = Int(readLine()!)!
var arr = readLine()!.split(separator: " ").map {Int($0)!}

var result: [Int] = Array(repeating: 0, count: N)

for i in 0..<N {
    result[i] = findLow(index: i) + 1
}

func findLow(index: Int) -> Int {
    var max = 0
    for i in 0..<index {
        if arr[i] < arr[index] && result[i] > max {
            max = result[i]
        }
    }
    return max
}

print(result.max()!)
