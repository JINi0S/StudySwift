# 물마시기 알람 앱

**Local Notification: 로컬 알림**

앱 내부에서 자체적으로 만든 특정 메시지를 전달하는 알림

목적: 사용자의 관심을 끄는데 있음

구성(UN: User Notification의 약자)

- 알림요청: UNNotificationRequest: 
ID - identifier(고유값, 유효 아이디)
Content - UNMutableNotificationContent(알림에 나타날 내용을 정의해야함. 알림에 표시될 타이틀, 내용, 알림 소리, 뱃지에 표시될 내용)
Trigger- (UNCalendarNotificationTrigger, UNTimeIntervalNotificationTrigger, UNLocationNotificationTrigger)(알람을 어떤 기준에서 발생시킬것인지 조건을 설정// 달력,날짜기준의 캘린더, 시간 간격의 타임 트리거,사용자의 위치에따라 쓰는 로케이션 트리거)

이런 알림 요청을 UNNotificationCenter에 저장해둠
