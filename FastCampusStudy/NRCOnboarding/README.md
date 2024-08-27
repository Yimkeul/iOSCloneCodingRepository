# NRCOnboarding
[패스트캠퍼스] UIKit 강의

### PageControl 스크롤 마지막에서 처음으로 가는 방법 (간단버전)
``` swift
var tempIndex = 0

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var index = Int(scrollView.contentOffset.x / self.collectionView.bounds.width)

        if tempIndex >= messages.count {
            index = 0
            // 스크롤을 처음으로 이동
            let indexPath = IndexPath(item: 0, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }

        tempIndex = index
        pageControl.currentPage = index
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = scrollView.contentOffset.x / self.collectionView.bounds.width
        let cnt = messages.count - 1
        if pageIndex > CGFloat(Double(cnt) * 1.1) {
            tempIndex += 1
        }
        
    }
```
