```swift
import RxSwift

let disposeBag = DisposeBag()

print("------startWith------") //startWith에 작성한 엘리먼트를 특정 시퀀스의 맨 앞에 추가해버리는 것이다.
let 노랑반 = Observable<String>.of("👧🏼", "🧒🏻", "👶🏽")

노랑반
    .enumerated()
    .map { index, element in
        element + "어린이" + "\(index)"
        
    }
    .startWith("🎅선생님")
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

//🎅선생님
//👧🏼어린이0
//🧒🏻어린이1
//👶🏽어린이2

print("------concat1------") // 두 가지 이상의 시퀀스를 하나로 합치고 싶을 때 사용한다.
let 노랑반어린이들 = Observable<String>.of("👧🏼", "🧒🏻", "👶🏽")
let 선생님 = Observable<String>.of("🎅선생님")

let 줄서서걷기 = Observable
    .concat([선생님, 노랑반어린이들])

줄서서걷기
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
"""
🎅선생님
👧🏼
🧒🏻
👶🏽
"""

print("------concat2------")
선생님
    .concat(노랑반어린이들)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
"""
🎅선생님
👧🏼
🧒🏻
👶🏽
"""

print("------concatMap------")//flatMap과 유사. 각각의 시퀀스가 다음 시퀀스가 구독되기 전에 합쳐진다.
let 어린이집: [String: Observable<String>] = [
    "노랑반": Observable.of("👧🏼", "🧒🏻", "👶🏽"),
    "파랑반": Observable.of("👦🏼", "👶🏻")
]

Observable.of("노랑반", "파랑반")
    .concatMap { 반 in
        어린이집[반] ?? .empty()
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
//👧🏼
//🧒🏻
//👶🏽
//👦🏼
//👶🏻

print("------merge1------")//순서를 지켜가면서 두 가지 요소를 합친다.
let 강북 = Observable.from(["강북구", "성북구", "동대문구", "종로구"])
let 강남 = Observable.from(["강남구", "강동구", "영등포구", "양천구"])

Observable.of(강북, 강남)
    .merge()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
"""
강북구
성북구
강남구
동대문구
강동구
종로구
영등포구
양천구
"""

print("------merge2------") //maxConcurrent: 한번에 받아낼 옵져버의 수
Observable.of(강북, 강남)
    .merge(maxConcurrent: 1)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
"""
강북구
성북구
동대문구
종로구
강남구
강동구
영등포구
양천구
"""

print("------combineLatest1------") //최신의 값들로 조합, 어떤 두 시퀀스를 합치되 두 가지 시퀀스 모두에서 최소 하나의 값이 들어왔을 때 가장 최신의 값을 가져오는 것이다.
let 성 = PublishSubject<String>()
let 이름 = PublishSubject<String>()

let 성명 = Observable
    .combineLatest(성, 이름) { 성, 이름 in
        성 + 이름
    }
    
성명
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

성.onNext("김")
이름.onNext("똘똘") //김똘똘
이름.onNext("영수") //김영수
이름.onNext("은영") //김은영
성.onNext("박") //박은영
성.onNext("이") //이은영
성.onNext("조") //조은영

print("------combineLatest2------") //combineLatest의 소스를 여러개 받을 수 있다.
let 날짜표시형식 = Observable<DateFormatter.Style>.of(.short, .long)
let 현재날짜 = Observable<Date>.of(Date())

let 현재날짜표시 = Observable
    .combineLatest(
        날짜표시형식,
        현재날짜,
        resultSelector:  {형식, 날짜 -> String in //첫번째로 들어올 형식, 두번째로 들어올 날짜를 스트링타입으로 내뱉는다
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = 형식
            return dateFormatter.string(from: 날짜)
        }
    )
현재날짜표시
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
//9/5/22
//September 5, 2022

print("------combineLatest3------")//어레이 내에 최종값을 받는 형태로 나타나지는 연산자도 있다 //????
let lastName = PublishSubject<String>() //성
let firstName = PublishSubject<String>() //이름

let fullName = Observable
    .combineLatest([firstName, lastName]) { name in
        name.joined(separator: " ")
    }

fullName
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

lastName.onNext("Kim")
firstName.onNext("Paul")
firstName.onNext("Stella")
firstName.onNext("Lily")
//Paul Kim
//Stella Kim
//Lily Kim

print("------zip------")
enum 승패 {
    case 승
    case 패
}

let 승부 = Observable<승패>.of(.승, .승, .패, .승, .패)
let 선수 = Observable<String>.of("🇰🇷", "🇳🇺", "🇱🇷", "🇷🇴", "🇲🇨", "🇳🇮")
//승부는 옵져버블인데 타입이 승패야, 승승패승패의 결과로 나타는 옵져버블이다.
//선수는 옵져버블타입의 스트링, 각각의 국가라고 가정, 여섯개의 나라가 출전

let 시합결과 = Observable //시합결과로 승부를 합칠 것
    .zip(승부, 선수) { 결과, 대표선수 in
        return 대표선수 + "선수" + "\(결과)"
    }

시합결과
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
//둘 중 하나의 옵져버블이 완료되면 zip전체가 완료됨
//🇰🇷선수승
//🇳🇺선수승
//🇱🇷선수패
//🇷🇴선수승
//🇲🇨선수패

print("------withLatestFrom1------") //가장 최신값을 가져오는 것 //첫번째 옵져버블이 방아쇠역할을 함//방아쇠에 해당하는 첫번째 옵져버블의 이벤트가 발생해야만 두번째의 옵져버블의 이벤트들이 나타날 수 있다. 이전의 것들은 무시
let 💥🔫 = PublishSubject<Void>()
let 달리기선수 = PublishSubject<String>()

💥🔫
    .withLatestFrom(달리기선수)
    //.distinctUntilChanged() //이 라인을 추가하면 withLatestFrom로 sample처럼 작동하게 할 수 있다 //한줄만 뜸
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

달리기선수.onNext("🏃‍♀️")
달리기선수.onNext("🏃‍♀️ 🏃🏽")

달리기선수.onNext("🏃‍♀️ 🏃🏽 🏃🏻‍♂️")
💥🔫.onNext(Void())
💥🔫.onNext(Void())
//🏃‍♀️ 🏃🏽 🏃🏻‍♂️
//🏃‍♀️ 🏃🏽 🏃🏻‍♂️

print("------sample------") //위에것과 유사하지만 단 한번만 방출한다는 차이가 있다.
let 🏁출발 = PublishSubject<Void>()
let F1선수 = PublishSubject<String>()

F1선수
    .sample(🏁출발)
    .subscribe(onNext:{
        print($0)
    })
    .disposed(by: disposeBag)

F1선수.onNext("🏎")
F1선수.onNext("🏎   🚗")
F1선수.onNext("🏎      🚗   🚙")
🏁출발.onNext(Void())
🏁출발.onNext(Void())
🏁출발.onNext(Void())
//🏎      🚗   🚙

//switch역할을 함
print("------amb------") //모호함의 약자//두가지 시퀀스를 받을 때 어떤것을 구독할 지 애매모호할 때 사용하는 방식
let 버스1 = PublishSubject<String>()
let 버스2 = PublishSubject<String>()

let 버스정류장 = 버스1.amb(버스2) //두개 다 지켜보겠단 뜻

버스정류장
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

버스2.onNext("버스2-승객0: 👨‍💼")
버스1.onNext("버스1-승객0: 👷🏼‍♀️")
버스1.onNext("버스1-승객1: 🧑🏻‍🔧")
버스2.onNext("버스2-승객1: 🤵🏽‍♂️")
버스1.onNext("버스1-승객1: 🧝🏾")
버스2.onNext("버스2-승객2: 👩🏻‍⚕️")
//요소를 먼저 방출하는 옵져버블이 생기면 나머지 하나는 무시하겠다.
//버스2-승객0: 👨‍💼
//버스2-승객1: 🤵🏽‍♂️
//버스2-승객2: 👩🏻‍⚕️

print("------switchLatest------") //switchLatest연산자의 목적은 소스옵져버블(손들기)로 들어온 마지막 시퀀스 아이템만 구독
let 학생1 = PublishSubject<String>()
let 학생2 = PublishSubject<String>()
let 학생3 = PublishSubject<String>()

let 손들기 = PublishSubject<Observable<String>>() //손들기는 이벤트로 옵져버블을 내뱉는다

let 손든사람만말할수있는교실 = 손들기.switchLatest()

손든사람만말할수있는교실
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

손들기.onNext(학생1)
학생1.onNext("학생1: 저는 1번 학생입니다")
학생2.onNext("학생2: 저요!!")

손들기.onNext(학생2)
학생2.onNext("학생2: 전 2번 입니다")
학생1.onNext("학생1: 아.. 제 차례입니다")

손들기.onNext(학생3)
학생2.onNext("학생2: 아니 잠깐! 내가!!")
학생1.onNext("학생1: 언제 말할 수 있는 건가요")
학생3.onNext("학생3: 제가 3번입니다. 제가 말 해도 될까요")

//학생1: 저는 1번 학생입니다
//학생2: 전 2번 입니다
//학생3: 제가 3번입니다. 제가 말 해도 될까요

//위에는 시퀀스의 합 연산자들
//아래부터는 시퀀스 내의 요소들간의 결합을 해주는 연산자들//------------

print("------reduce------") //결과값을 방출
Observable.from((1...10))
    //.reduce(0, accumulator: {summary, newValue in
    //    return summary + newValue
    //})
    //.reduce(0) { summary, newValue in
    //    return summary + newValue
    //}
    .reduce(0, accumulator: +) //위에 셋 다 동일한 코드
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
//55

print("------scan------") //매번 값이 들어올때마다 변화되는 값을 방출
Observable.from((1...10))
    .scan(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
```
