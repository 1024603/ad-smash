import SwiftUI

struct EnableAdSmashSheet: View {
    let onEnable: () -> Void
    let onDismiss: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Enable Ad Smash!")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)

                Text("Turn on Ad Smash! in Safari so it can block known ad domains and trackers while you browse.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)

                Button(action: {
                    onEnable()
                }) {
                    Text("Enable in Safari")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .foregroundColor(.white)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.orange, Color.pink]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(16)
                }

                Button(action: {
                    onDismiss()
                }) {
                    Text("Not now")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            .padding(24)
            .frame(maxWidth: 420)
            .background(Color(red: 0.10, green: 0.11, blue: 0.18))
            .cornerRadius(24)
        }
    }
}
