import SwiftUI
import UIKit

struct GuidedSetupView: View {
    @State private var step = 1

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color(red: 0.10, green: 0.12, blue: 0.20)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                if step == 1 {
                    welcomeStep()
                } else if step == 2 {
                    settingsStep()
                } else if step == 3 {
                    safariStep()
                } else {
                    completeStep()
                }
            }
            .padding(24)
            .frame(maxWidth: 420)
        }
    }

    private func welcomeStep() -> some View {
        VStack(spacing: 18) {
            Image(systemName: "shield.fill")
                .font(.system(size: 54))
                .foregroundColor(.green)

            Text("Welcome to Ad Smash!")
                .font(.title2)
                .bold()
                .foregroundColor(.white)

            Text("We need to turn on one Safari setting so Ad Smash! can block ads on websites.")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)

            Button(action: {
                step = 2
            }) {
                Text("Continue")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .foregroundColor(.white)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.green, Color.blue]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(16)
            }
        }
    }

    private func settingsStep() -> some View {
        VStack(spacing: 18) {
            Text("Step 1")
                .font(.caption)
                .foregroundColor(.gray)

            Text("Open Settings")
                .font(.title2)
                .bold()
                .foregroundColor(.white)

            Text("Tap the Settings app on your iPhone.")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)

            Button(action: {
                openSettings()
            }) {
                Text("Open Settings")
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
                step = 3
            }) {
                Text("I opened Settings")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.9))
            }
        }
    }

    private func safariStep() -> some View {
        VStack(spacing: 18) {
            Text("Step 2")
                .font(.caption)
                .foregroundColor(.gray)

            Text("Tap Safari")
                .font(.title2)
                .bold()
                .foregroundColor(.white)

            Text("Then tap Extensions. Then turn on Ad Smash! Safari.")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)

            VStack(alignment: .leading, spacing: 8) {
                Text("1. Tap Safari")
                    .foregroundColor(.white)
                Text("2. Tap Extensions")
                    .foregroundColor(.white)
                Text("3. Turn on Ad Smash! Safari")
                    .foregroundColor(.white)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.04))
            .cornerRadius(16)

            Button(action: {
                step = 4
            }) {
                Text("I turned it on")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .foregroundColor(.white)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.green, Color.blue]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(16)
            }
        }
    }

    private func completeStep() -> some View {
        VStack(spacing: 18) {
            Image(systemName: "checkmark.shield.fill")
                .font(.system(size: 54))
                .foregroundColor(.green)

            Text("You’re all set")
                .font(.title2)
                .bold()
                .foregroundColor(.white)

            Text("Ad Smash! is enabled in Safari and will block known ad domains on websites.")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)

            Button(action: {
                // You can leave this blank or make it do something else
            }) {
                Text("Done")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(16)
            }
        }
    }

    private func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
}
