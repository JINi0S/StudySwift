```swift
import RxSwift

let disposeBag = DisposeBag()

print("------IgnoreElement------")
let 취침모드😴 = PublishSubject<String>()

취침모드😴
    .ignoreElements()
    .subscribe {
        print("☀️", $0)
    }
    .disposed(by: disposeBag)

취침모드😴.onNext("👏🏻")
취침모드😴.onNext("👏🏻")
취침모드😴.onNext("👏🏻")
//여기까진 다 ignore
취침모드😴.onCompleted()
//completed를 해줘야 subscribe의 print해줌

print("------ElementAt------")
let 두번울면깨는사람 = PublishSubject<String>()
두번울면깨는사람.element(at: 2)
    .subscribe(onNext:  {
        print($0)
    })
    .disposed(by: disposeBag)
두번울면깨는사람.onNext("👏🏻") //index0
두번울면깨는사람.onNext("👏🏻") //index1
두번울면깨는사람.onNext("😝") //index2
두번울면깨는사람.onNext("👏🏻") //index3
//특정 인덱스만 방출 = 인덱스 2만 방출

print("------Filter------")
Observable.of(1, 2, 3, 4, 5, 6, 7, 8)
    .filter{ $0 % 2 == 0 } //fileter값이 트루인 값을 방출
    .subscribe(onNext:{
        print($0)
    })

print("------Skip------") //첫번째부터 N개까지 스킵, N+1부터 방출
Observable.of("😘", "😇", "😝", "😡", "🤢", "🤡")
    .skip(4)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
//🤢
//🤡

print("------SkipWhile------") //while로직이 false가 되었을 때부터 방출
Observable.of("😘", "😇", "😝", "😡", "🤢", "🤡", "😺")
    .skip(while: {
        $0 != "😡"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("------SkipUntil------") //다른 Observable에 기반한 요소를 다아나믹하게 필터하고 싶을 때 사용
let 손님 = PublishSubject<String>()
let 문여는시간 = PublishSubject<String>()
손님.skip(until: 문여는시간)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

손님.onNext("😘")
손님.onNext("😇")
손님.onNext("😝")

문여는시간.onNext("땡")

손님.onNext("😡")
손님.onNext("🤢")
//😡
//🤢

print("------Take------") //skip의 반대 개념
Observable.of("🥇", "🥈", "🥉", "🎖", "🏅")
.take(3)
.subscribe(onNext: {
    print($0)
}).disposed(by: disposeBag)

print("------TakeWhile------") //while문에서 트루에 해당하는 값일때까지 방출
Observable.of("🥇", "🥈", "🥉", "🎖", "🏅")
    .take(while: {
        $0 != "🥉"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
//takewhile일때
//🥇
//🥈

//skipwhile이면
//🥉
//🎖
//🏅

print("------Enumerated------")//takeWhile구문이 참인 경우부터 방출 , false되는 순간부터 방출 멈춤, index와 element를 줌 ==>>>>>사용: 방출된 element의 인덱스를 참고하고 싶은 경우 사용한다.
Observable.of("🥇", "🥈", "🥉", "🎖", "🏅")
    .enumerated()
    .takeWhile {
        $0.index < 3
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("------TakeUntil------") //SkipUntil의 반대, trigger가 되는 Observable(신청마감)이 구독되기 전까지의 이벤트 값만 방출
let 수강신청 = PublishSubject<String>()
let 신청마감 = PublishSubject<String>()

수강신청
    .take(until: 신청마감)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
수강신청.onNext("🙋‍♀️")
수강신청.onNext("🙋")

신청마감.onNext("끝")
수강신청.onNext("🙋‍♂️")

print("------DistinctUntilChanged------") //연달아 같은 값이 이어질 때 중복된 값을 앞의 것 한 번만 방출
Observable.of("저는", "저는", "앵무새", "앵무새", "앵무새", "앵무새", "입니다", "입니다", "입니다", "입니다", "저는", "앵무새", "일까요??")
    .distinctUntilChanged()
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
//저는
//앵무새
//입니다
//저는
//앵무새
//일까요??
```
