# Observable

### Observable

- Rx의 심장
- Observable = Observable Sequence = Sequence
- 비동기적(asynchronous)
- Observable 들은 일정 기간 동안 계속해서 이벤트를 생성(emit)
- marble diagram: 시간의 흐름에 따라서 값을 표시하는 방식

### Observable 생명 주기

- Observable은 어떤 구성요소를 가지는 next 이벤트를 계속해서 방출할 수 있다
- Observable**은 error** 이벤트를 방출하여 완전 종료될 수 있다
- Observable은 complete이벤트를 방출하여 완전 종료될 수 있다

import RxSwift
import Foundation

print("----Just----")
Observable<Int>.just(1)
    .subscribe(onNext: {
        print($0)
    })

print("----Of1----")
Observable<Int>.of(1, 2, 3, 4, 5)

print("----Of2----")
Observable.of([1, 2, 3, 4, 5])

print("----From----")
Observable.from([1, 2, 3, 4, 5])

print("----subscribe1----")
Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }

print("----subscribe2----")
Observable.of(1, 2, 3)
    .subscribe {
        if let element = $0.element {
            print(element)
        }
    }

print("----subscribe3----")
Observable.of(1, 2, 3)
    .subscribe(onNext: {
        print($0)
    })

print("----empty----")
Observable.empty()
    .subscribe {
        print($0)
    }

print("----emptyVoid----complete된 걸 알 수 있음")
Observable<Void>.empty()
    .subscribe {
        print($0)
    }


print("----never----")
Observable<Void>.never()
    .debug("never")
    .subscribe (
        onNext: {
            print($0)
        },
        onCompleted: {
            print("Completed")
        }
    )

print("----range----")
Observable.range(start: 1, count: 9)
    .subscribe(onNext: {
        print("2*\($0)=\(2*$0)")
    })

print("----dispose----")
Observable.of(1, 2, 3)
    .subscribe{
        print($0)
    }
    .dispose()

print("----disposeBag----")
let disposeBag = DisposeBag()
Observable.of(1, 2, 3)
    .subscribe{
        print($0)
    }
    .disposed(by: disposeBag)


print("----create1----")
Observable.create { observer -> Disposable in
    observer.onNext(1)
    //observer.on(.next(1))
    observer.onCompleted()
    //observer.on(.completed)
    observer.onNext(2)
    return Disposables.create()
}
.subscribe{
    print($0)
}
.disposed(by: disposeBag)


print("----create2----")
enum MyError: Error {
    case anError
}
Observable.create { observer -> Disposable in
    observer.onNext(1)
    observer.onError(MyError.anError)
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe(onNext: {
    print($0)
}, onError: {
    print($0.localizedDescription)
}, onCompleted: {
    print("completed")
}, onDisposed: {
    print("disposed")
})


print("----deferred1----")
Observable.deferred {
    Observable.of(1,2,3)
}
.subscribe {
    print($0)
}
.disposed(by: disposeBag)

print("----deffered2----")
var 뒤집기: Bool = false

let fatory: Observable<String> = Observable.deferred {
    뒤집기 = !뒤집기
    
    if 뒤집기 {
        return Observable.of("🫲🏻")
    } else {
        return Observable.of("🫱🏻")
    }
}

for _ in 0...3 {
    fatory.subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
}
