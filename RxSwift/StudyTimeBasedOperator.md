```swift
import RxSwift
import RxCocoa
import UIKit
import PlaygroundSupport

let disposeBag = DisposeBag()

//언제 어떻게 과거와 새로운 요소들을 전달할 건지 컨트롤 할 수 있게 해줌
print("------replay------")
let 인사말 = PublishSubject<String>()
let 반복하는앵무새 = 인사말.replay(1) //지나간 이벤트중 한개를 내보냄
반복하는앵무새.connect()

인사말.onNext("1. hello")
인사말.onNext("2. hi")

반복하는앵무새
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
//2. hi

인사말.onNext("3. 안녕하세요")
//구독시점 이후에 발생한 이벤트이기 때문에 버퍼사이즈와 상관없이 무조건 나타나게됨
//2. hi
//3. 안녕하세요

print("------replayAll------") //구독 시점 이전에 발생한 어떠한 값이라도 개수 제한 없이 나타냄 //지나간 이벤트 방출에 대해서 그 이후에 구독을 하더라도 그전의 값들을 볼 수 있게하는 연산자
let 닥터스트레인지 = PublishSubject<String>()
let 타임스톤 = 닥터스트레인지.replayAll()
타임스톤.connect()

닥터스트레인지.onNext("도르마무")
닥터스트레인지.onNext("거래를 하러왔다")

타임스톤
    .subscribe(onNext: {
        print($0)
        
    })
    .disposed(by: disposeBag)

//도르마무
//거래를 하러왔다

print("------buffer------")
//let source = PublishSubject<String>()
//
//var count = 0
//let timer = DispatchSource.makeTimerSource() //시간 흐름에 따라 작동시킬 예정
//
//timer.schedule(deadline: .now() + 2, repeating: .seconds(1))
//timer.setEventHandler {
//    count += 1
//    source.onNext("\(count)")
//}
//timer.resume()
//
//source
//    .buffer(timeSpan: .seconds(2), count: 2, scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

//[]
//["1", "2"]
//["3", "4"]
//["5"]
//["6", "7"]
//["8", "9"]
//["10", "11"]

print("------window------") //버퍼와 유사, 버퍼는 어래이를 방출하는 반면 윈도우는 Observable을 방출
//let 만들어낼최대Observable수 = 3
//let 만들시간 = RxTimeInterval.seconds(2)
//
//let window = PublishSubject<String>()
//
//var windowCount = 0
//let windowTimerSource = DispatchSource.makeTimerSource()
//
//windowTimerSource.schedule(deadline: .now() + 2, repeating: .seconds(1))
//windowTimerSource.setEventHandler {
//    windowCount += 1
//    window.onNext("\(windowCount)")
//}
//windowTimerSource.resume()
//
//window
//    .window(
//        timeSpan: 만들시간,
//        count: 만들어낼최대Observable수,
//        scheduler: MainScheduler.instance
//    )
//    .flatMap { windowObservable -> Observable<(index: Int, element: String)> in
//        return windowObservable.enumerated()
//    }
//    .subscribe(onNext: {
//        print("\($0.index)번째 Observable의 요소 \($0.element)")
//    })
//    .disposed(by: disposeBag)

//0번째 Observable의 요소 1
//0번째 Observable의 요소 2
//1번째 Observable의 요소 3
//0번째 Observable의 요소 4
//1번째 Observable의 요소 5
//0번째 Observable의 요소 6
//1번째 Observable의 요소 7

//구독을 지연시키는 옵져버블
print("------delaySubscription------")
//let delaySource = PublishSubject<String>()
//
//var delayCount = 0
//let delayTimeSource = DispatchSource.makeTimerSource() //타임소스를 만들어서 일정시간 간격으로 이벤트를 방출해주는 코드
//delayTimeSource.schedule(deadline: .now() + 2, repeating: .seconds(1)) //매 1초마다 반복
//delayTimeSource.setEventHandler {
//    delayCount += 1
//    delaySource.onNext("\(delayCount)")
//}
//delayTimeSource.resume()
//
//delaySource
//    .delaySubscription(.seconds(3), scheduler: MainScheduler.instance) //구독 3초 지연
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

//2
//3
//4
//5
//6
//7

//전체 시퀀스 자체를 뒤로 미루는 작업
print("------delay------")
//let delaySubject = PublishSubject<Int>()
//
//var delayCount = 0
//let delayTimerSource = DispatchSource.makeTimerSource()
//delayTimerSource.schedule(deadline: .now(), repeating: .seconds(1))
//delayTimerSource.setEventHandler {
//    delayCount += 1
//    delaySubject.onNext(delayCount)
//}
//delayTimerSource.resume()
//
//delaySubject
//    .delay(.seconds(3), scheduler: MainScheduler.instance //3초뒤부터 이벤트 방출
//    )
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

//2
//3
//4
//5
//6

print("------interval------") //
//Observable<Int>
//    .interval(.seconds(3), scheduler: MainScheduler.instance) //3초간격으로 Int에 해당하는 값들을 내뱉음
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

//0
//1
//2
//3

print("------timer------") //첫번째값과 구독하고 첫번째값을 방출하는 사이에 마감일(간격)을 설정할 수 있음 //구독성이 좋다는 이점//직관적인 코드
//Observable<Int>
//    .timer(.seconds(5),
//           period: .seconds(2),
//           scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

//0
//1
//2
//3

print("------timeout------")
let 누르지않으면에러 = UIButton(type: .system)
누르지않으면에러.setTitle("눌러주세요", for: .normal)
누르지않으면에러.sizeToFit()

PlaygroundPage.current.liveView = 누르지않으면에러

누르지않으면에러.rx.tap
    .do(onNext: {
        print("tap")
    })
    .timeout(.seconds(4), scheduler: MainScheduler.instance)
    .subscribe{
        print($0)
    }
    .disposed(by: disposeBag)

//tap
//next(())
//tap
//next(())
//error(Sequence timeout.)
```
