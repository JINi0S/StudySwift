*200226 OperationQueue
# OperationQueue

# 목표

- 연산객체
- 대기열과 연산의 관리

# Operation Queue

Operation Queue: 연산(Operation)의 실행을 관리하고 대기열의 동작관리를 함

Operation은 태스크(작업)와 관련된 코드와 데이터를 나타내는 추상 클래스입니다.

Operation Queue는 연산(Operation)의 실행을 관리합니다.

대기열(Queue)에 추가한 동작은 직접 제거할 수 없습니다.

연산은 작업이 끝날 때까지 대기열에 남아있습니다.

연산을 대기열에서 제거하는 방법은 연산을 취소하는 방법뿐입니다.

취소하는 방법은 연산객체( Operation Object) 의 cancel() 매서드를 호출하거나 Operation Queue의 cancelAllOperations() 매서드를 호출하여 대기열에 있는 모든 연산을 취소하는 방법이 있습니다.

실행 중인 연산의 경우 연산 객체의 취소 상태를 확인하고 실행 중인 연산을 중지하고 완료 상태로 변경됩니다.

Operation Queue는 Objective-C 기반

# 연산 객체( Operation Object)

연산 객체는 애플리케이션에서 수행하려는 연산을 캡슐화하는 데 사용하는 Foundation 프레임워크의 Operation 클래스 인스턴스입니다

# OperationQueue의 주요 매서드/프로퍼티

## 특정 Operation Queue 가져오기

- current: 현재 작업을 시작한 Operations Queue를 반환합니다.
class var current: OperationQueue? { get }
- main: 메인 스레드와 연결된 Operation Queue를 반환합니다.
class var main: OperationQueue { get }

## 대기열(Queue)에서 동작(Operation) 관리

- addOperation(*:): 연산 객체(Operation Object)를 대기열(Queue)에 추가합니다.
func addOperation(* op: Operation)
- addOperations(_:waitUntilFInished:) : 연산객체 배열을 대기열에 추가합니다
func addOperations( ops: [Operation], waitUntilFinished wait: Bool)
- addOperation(*:) : 전달한 클로저를 연산 객체에 감싸서 대기열에 추가합니다
func addOperation(* block: @escaping () → Void)
- cancelAllOperations(): 대기 중이거나 실행 중인 모든 연산을 취소합니다
func cancelAllOperations()
- waitUntilAllOperationsAreFinished(): 대기 중인 모든 연산과 실행 중인 연산이 모두 완료될 때까지 현재 스레드로의 접근을 차단합니다.
func waitUntilAllOperationsAreFinished()

## 연산(Operation) 실행 관리

- maxConcurrentOperationCount: 동시에 실행할 수 있는 연산(operation)의 최대 수입니다.
var maxConcurrentOperationCount: Int { get set }
- qualityOfService: 대기열 작업을 효율적으로 수행할 수 있도록 여러 우선순위 옵션을 제공합니다.
var qualityOfService: QualityOfService { get set }

## 연산(Operation) 중단

- isSuspended: 대기열(Queue)의 연산(Operation) 여부를 나타내기 위한 부울 값입니다. 
false 인 경우 대기열에 있는 연산을 실행하고, true인 경우 대기열에 대기 중인 연산을 실행하진 않지만 이미 실행중인 연산은 계속 실행됩니다.

## 대기열(Queue)의 구성

- name: Operaton Queue의 이름
var name: String? { get set }
