# InstaSearchView
[패스트캠퍼스] UIKit 강의

### 하단 탭바 스크롤 방향에 따른 숨기기/보이기 방법
```swift
var isTabBarHidden: Bool = false // class 내부에 선언

func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }

            // 스크롤이 위로 발생했거나, 현재 탭바가 숨겨져 있는 상태에서 약간의 스크롤이 발생한 경우
            if velocity.y < 0 || (velocity.y == 0 && self.isTabBarHidden) {
                let height = self.tabBarController?.tabBar.frame.height ?? 0.0
                self.tabBarController?.tabBar.alpha = 1.0
                self.tabBarController?.tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.maxY - height)
                self.isTabBarHidden = false
            } else if velocity.y > 0 || (velocity.y == 0 && !self.isTabBarHidden) {
                // 스크롤이 아래로 발생했거나, 현재 탭바가 보이는 상태에서 약간의 스크롤이 발생한 경우
                self.tabBarController?.tabBar.alpha = 0.0
                self.tabBarController?.tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.maxY)
                self.isTabBarHidden = true
            }
        }
    }
```
