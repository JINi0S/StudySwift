/* 
주어진 n개의 로프로 들 수 있는 최대 중량(각각의 로프에는 모두 고르게 w/k만큼의 중량이 걸리게 됨
2
10
15
*/
let num = Int(readLine()!)!
var arr : [Double] = []
for _ in 0..<num {
    arr.append(Double(readLine()!)!)
}
arr = arr.sorted(by: >)

var result: Double = 0
var sum: Double = 0
for i in 0..<arr.count {
    sum += arr[i]
    if (sum / Double(Double(i)+1)) <= arr[i] {
        result = max(result, (sum / (Double(i)+1.0)) * (Double(i)+1.0))
    } else {
        result = max(result, arr[i] * (Double(i)+1.0))
    }
}

print(Int(result))
