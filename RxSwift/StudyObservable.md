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

### Single

.success (next와 complete를 합친 느낌)이벤트 또는 .error 이벤트을 한번만 방출하는 옵져버블

### Maybe

싱글과 비슷함. 성공적으로 complete되더라도 아무런 값을 방출하지 않는 complete를 포함

.success또는 .complete 또는 .error 를 방출

### Completable

.completed 또는 .error만 방출

어떠한 값도 방출하지 않는다.

예) 데이터가 자동으로 저당되는 기능을 사용할 때 값이 따로 필요없음
