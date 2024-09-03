//
//  ViewModel.swift
//  AVFoundationTutorial
//
//  Created by yimkeul on 9/3/24.
//

import Foundation
import AVFoundation
import Combine
import MediaPlayer

class AudioPlayerViewModel: ObservableObject {
    @Published var isPlaying = false
    @Published var isReadyToPlay = false
    
    private var player: AVPlayer?
    private var playerItemContext = 0
    private var statusObserver: AnyCancellable?
    // URL 입력하기
    let mp3fileURL: String = ""
    
    init() {
        MPNowPlayingInfoCenterSetting()
    }
    
    func prepareAudio() {
        guard let url = URL(string: mp3fileURL) else {
            print("Invalid URL")
            return
        }
        
        let playerItem = AVPlayerItem(url: url)
        
        // AVPlayer 초기화
        player = AVPlayer(playerItem: playerItem)
        
        // Combine을 사용하여 AVPlayerItem의 status를 관찰
        statusObserver = playerItem.publisher(for: \.status)
            .receive(on: RunLoop.main)
            .sink { [weak self] status in
                switch status {
                case .readyToPlay:
                    self?.isReadyToPlay = true
                    self?.updateNowPlayingInfo()
                    print("Audio is ready to play")
                case .failed:
                    print("Failed to load audio")
                default:
                    break
                }
            }
    }
    
    func playAudio() {
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        player?.play()
        isPlaying = true
        updateNowPlayingInfo()
    }
    
    func pauseAudio() {
        player?.pause()
        isPlaying = false
        updateNowPlayingInfo()
    }
    

    func MPNowPlayingInfoCenterSetting() {
            UIApplication.shared.beginReceivingRemoteControlEvents()

            let center = MPRemoteCommandCenter.shared()

            center.skipForwardCommand.isEnabled = true
            center.skipBackwardCommand.isEnabled = true

            center.playCommand.addTarget { [weak self] _ in
                self?.playAudio()
                return .success
            }
            center.pauseCommand.addTarget { [weak self] _ in
                self?.pauseAudio()
                return .success
            }
//            center.skipForwardCommand.addTarget { [weak self] _ in
//                self?.forward()
//                return .success
//            }
//            center.skipBackwardCommand.addTarget { [weak self] _ in
//                self?.backward()
//                return .success
//            }
        }
    
    
    private func updateNowPlayingInfo() {
         let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
         var nowPlayingInfo = [String: Any]()
         
         nowPlayingInfo[MPMediaItemPropertyTitle] = "Audio Title"
         nowPlayingInfo[MPMediaItemPropertyArtist] = "Artist Name"
         nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player?.currentTime().seconds
         nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = player?.currentItem?.duration.seconds
         nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = isPlaying ? 1.0 : 0.0
         
         nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
     }
}



