```swift
import RxSwift
import Foundation
let disposeBag = DisposeBag()

print("------toArray------") //싱글로 만들어지고 Array로 내뱉어짐
Observable.of("A","B","C")
    .toArray()
    .subscribe(onSuccess: {
        print($0)
    })
    .disposed(by: disposeBag)

print("------map------")
Observable.of(Date())
    .map{date -> String in
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: date)
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag )

print("------flatMap------")
//Observable<Observable<String>>
protocol 선수 {
    var 점수: BehaviorSubject<Int> { get }
}

struct 양궁선수: 선수 {
    var 점수: BehaviorSubject<Int>
}

let 한국국가대표 = 양궁선수(점수: BehaviorSubject<Int>(value: 10 ))
let 미국국가대표 = 양궁선수(점수: BehaviorSubject<Int>(value: 8 ))

let 올림픽경기 = PublishSubject<선수>()
올림픽경기
    .flatMap{ 선수 in
    선수.점수
    }.subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

올림픽경기.onNext(한국국가대표)
한국국가대표.점수.onNext(10)

올림픽경기.onNext(미국국가대표)
한국국가대표.점수.onNext(10)
미국국가대표.점수.onNext(9)

print("------flatMapLatest------")
struct 높이뛰기선수: 선수 {
    var 점수: BehaviorSubject<Int>
}

let 서울선수 = 높이뛰기선수(점수: BehaviorSubject<Int>(value: 7))
let 제주선수 = 높이뛰기선수(점수: BehaviorSubject<Int>(value: 6))

let 전국체전 = PublishSubject<선수>()

전국체전
    .flatMapLatest { 선수 in
        선수.점수
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

전국체전.onNext(서울선수)
서울선수.점수.onNext(9)

전국체전.onNext(제주선수)
서울선수.점수.onNext(10)
서울선수.점수.onNext(13)
제주선수.점수.onNext(9)
제주선수.점수.onNext(11)

// 7 / 9 / 6 / 9 -->>가장 최신의 값 1개만 유효하고 다음이벤트들은 무시>>처음에 전국체전의 onNext(서울선수)이후에 새로 제주선수를 onNext하면 이후엔 서울 선수의 OnNext가 아무리 새로 생겨도 무시
    //네트워킹 동작에서 유용하게 사용됨
    //사전에 검색하는 경우 "swift"를 검색하는데 "s" "sw" "swi"를 새로 검색하는 느낌

print("------materialize and dematerialize------") //Observable을 ObservableEvent로 변환해야하는 경우//외부적으로 Observable이 종료되는 것을 방지하는 경우 에러 이벤트 처리
enum 반칙: Error {
    case 부정출발
}

struct 달리기선수: 선수 {
    var 점수: BehaviorSubject<Int>
}

let 김토끼 = 달리기선수(점수: BehaviorSubject<Int>(value: 0))
let 박치타 = 달리기선수(점수: BehaviorSubject<Int>(value: 1))

let 달리기100M = BehaviorSubject<선수>(value: 김토끼)
달리기100M
    .flatMapLatest{ 선수 in
        선수.점수
            .materialize() //단순히 점수만 출력하는 것이 아니라 이벤트를 같이 출력
    }
    .filter {
        guard let error = $0.error else {
            return true
        }//에러가 발생했을 때는 에러를 표시하기만 하고 필터를 벗어나지 않도록// 에러가 없으면 true이기때문에 통과
        print(error)
        return false
    }
    .dematerialize()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

김토끼.점수.onNext(1)
김토끼.점수.onError(반칙.부정출발)

김토끼.점수.onNext(2)

달리기100M.onNext(박치타)
//0
//1
//Unhandled error happened: 부정출발

//--materialize하면 아래로 바뀜
//next(0)
//next(1)
//error(부정출발)
//next(1)

//--filter와 dematerialize추가한 경우 아래로 바뀜
//0
//1
//부정출발
//1

print("------예시) 전화번호 11자리------")
let input = PublishSubject<Int?>()

let list: [Int] = [1]

input
    .flatMap {
        $0 == nil
            ? Observable.empty()
            : Observable.just($0)
    }.map { $0! }
    .skip(while: { $0 != 0 }) //0이 아니라면 스킵한다
    .take(11)
    .toArray()
    .asObservable()
    .map {
        $0.map { "\($0)" } //str타입으로 변환
    }
    .map { numbers in
        var numberList = numbers
        numberList.insert("-", at: 3)
        numberList.insert("-", at: 8)
        let number = numberList.reduce(" ", +)
        return number
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

input.onNext(10)
input.onNext(0)
input.onNext(nil)
input.onNext(1)
input.onNext(0)
input.onNext(4)
input.onNext(3)
input.onNext(nil)
input.onNext(1)
input.onNext(8)
input.onNext(9)
input.onNext(4)
input.onNext(9)
input.onNext(1)
```
