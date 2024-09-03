import SwiftUI
import AVFoundation
import Combine

struct ContentView: View {
    @StateObject private var viewModel = AudioPlayerViewModel()
    var body: some View {
        VStack {
            Button(action: {
                if viewModel.isPlaying {
                    viewModel.pauseAudio()
                } else if viewModel.isReadyToPlay {
                    viewModel.playAudio()
                }
            }) {
                Text(viewModel.isPlaying ? "Pause Audio" : viewModel.isReadyToPlay ? "Play Audio" : "Loading...")
            }
        }
            .onAppear {
            viewModel.prepareAudio()
        }
    }
}


#Preview {
    ContentView()
}
