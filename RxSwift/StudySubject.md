# Subject

Subject: Observable이자 Observer

### Subject의 종류

- PublishSubject
빈 상태로 시작하여 새로운 값만을 subscriber에 방출한다
- BehaviorSubject
하나의 초기값을 가진 상태로 시작하여, 새로운 subscriber에게 초기값 또는 최신값을 방출한다
- ReplaySubject
버퍼를 두고 초기화하며, 버퍼 사이즈 만큼의 값들을 유지하면서 새로운 subscriber에게 방출한다

```swift
import RxSwift

let disposeBag = DisposeBag()

print("------publishSubject------")
let publishSubject = PublishSubject<String>()

publishSubject.onNext("1. 여러분 안녕하세요")

let 구독자1 = publishSubject
    .subscribe(onNext: {
        print("첫 번째 구독: ", $0)
    })
    
    
publishSubject.onNext("2. 들리세요?")
publishSubject.on(.next("3. 안들리시나요?"))

구독자1.dispose()

//구독자 1이 구독하기 전에 생성된 이벤트 1는 무시되고, 구독이후에 생성된 이벤트인 2, 3은 print된다.

let 구독자2 = publishSubject
    .subscribe(onNext: {
        print("두 번째 구독: ",$0)
    })

    
publishSubject.onNext("4. 여보세요?")
publishSubject.onCompleted()

publishSubject.onNext("5. 끝났어요?")

구독자2.dispose()
//구독자 2가 구독하기 전에 생성된 1,2,3은 무시되고, 구독이후에 생성된 이벤트인 4는 print된다. 5는 subject가 completed된 이후에 생성되었으므로 읽을 수 없다.

publishSubject
    .subscribe {
    print("세 번째 구독: ", $0.element ?? $0)
    } //$0 -> completed로 출력
    .disposed(by: disposeBag)

publishSubject.onNext("6. 끝난건가요")
//세 번째 구독:  completed 만 추가 로 찍힘
//이미 위에서 completed되었기때문

print("------behaviorSubject-----")
enum SubjectError: Error {
    case error1
}

let behaviorSubject = BehaviorSubject<String>(value: "초기값")

behaviorSubject.onNext("1. 첫번째값")
behaviorSubject.subscribe {
    print("첫 번째 구독: ", $0.element ?? $0) //element가 없다면 어떠한 이벤트를 받았는지 표현해
}
.disposed(by: disposeBag)
//첫번째 구독은 초기값을 출력하지 못하고 "첫 번째 구독:  1. 첫번째값"를 출력한다.
//직전의 값을 프린트하므로 초기값이 아닌 1. 첫번째값이 출력된다

behaviorSubject.onError(SubjectError.error1)

behaviorSubject.subscribe {
    print("두 번째 구독: ", $0.element ?? $0)
}
.disposed(by: disposeBag)
//두번째 구독자는 구독 이후에 아무 이벤트도 없다.
//직전에 에러가 발생했으므로 에러가 출력된다.

let value = try? behaviorSubject.value()
print(value) //65의 에러 발생 라인을 주석처리 하고 보면 "1. 첫번째값"이 출력된다.

print("------replaySubject-----")
let replaySubject = ReplaySubject<String>.create(bufferSize: 2)

replaySubject.onNext("1. 안녕")
replaySubject.onNext("2. 하세")
replaySubject.onNext("3.  요")

replaySubject.subscribe {
    print("첫 번째 구독: ", $0.element ?? $0)
}
.disposed(by: disposeBag)

replaySubject.subscribe {
    print("두 번째 구독: ", $0.element ?? $0)
}.disposed(by: disposeBag)

replaySubject.onNext("4. HI")
replaySubject.onError(SubjectError.error1)
replaySubject.dispose()

replaySubject.subscribe {
    print("세 번째 구독: ", $0.element ?? $0)
}.disposed(by: disposeBag)
```
