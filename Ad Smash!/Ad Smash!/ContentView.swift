import SwiftUI
import UIKit

struct ContentView: View {
    @AppStorage("adSmashEnabled") private var adSmashEnabled = false
    @AppStorage("hasSeenEnablePrompt") private var hasSeenEnablePrompt = false
    @State private var showEnablePrompt = false
    @State private var adsBlocked = 1842

    let features = [
        FeatureItem(title: "Tracker Shield", subtitle: "Blocks ad networks and tracking scripts", icon: "shield.fill"),
        FeatureItem(title: "Safari Filter", subtitle: "Stops ad domains in Safari pages", icon: "safari.fill"),
        FeatureItem(title: "Fast Load", subtitle: "Fewer banners, scripts, and popups", icon: "bolt.fill"),
        FeatureItem(title: "Private Browsing", subtitle: "Reduces tracking across known ad sources", icon: "lock.shield.fill")
    ]

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color(red: 0.09, green: 0.10, blue: 0.18)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 18) {
                HStack {
                    Text("Ad Smash!")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)

                    Spacer()

                    Button(action: {
                        adSmashEnabled.toggle()
                    }) {
                        Text(adSmashEnabled ? "ON" : "OFF")
                            .font(.headline)
                            .frame(width: 68, height: 34)
                            .foregroundColor(.white)
                            .background(adSmashEnabled ? Color.green : Color.gray)
                            .cornerRadius(17)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 18)

                VStack(spacing: 8) {
                    Text("Ads Blocked")
                        .font(.caption)
                        .foregroundColor(.gray)

                    Text("\(adsBlocked)")
                        .font(.system(size: 52, weight: .bold))
                        .foregroundColor(.white)

                    Text("this session")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 24)
                .background(Color.white.opacity(0.04))
                .cornerRadius(26)

                HStack(spacing: 12) {
                    ActionButton(title: "Enable", color: .blue) {
                        enableInSafari()
                    }
                    ActionButton(title: "List", color: .purple) {
                        showEnablePrompt = true
                    }
                    ActionButton(title: "Stats", color: .green) {
                        showEnablePrompt = true
                    }
                }
                .padding(.horizontal, 16)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Protection Suite")
                        .font(.headline)
                        .foregroundColor(.white)

                    ForEach(features, id: \.title) { item in
                        FeatureCard(item: item)
                    }
                }

                Spacer()

                Button(action: {
                    toggleProtection()
                }) {
                    Text(adSmashEnabled ? "Disable Ad Smash!" : "Enable Ad Smash!")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .foregroundColor(.white)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: adSmashEnabled ? [Color.red, Color.orange] : [Color.green, Color.blue]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(16)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .onAppear {
            if !hasSeenEnablePrompt {
                showEnablePrompt = true
            }
        }
        .sheet(isPresented: $showEnablePrompt) {
            EnableAdSmashSheet(
                onEnable: {
                    enableInSafari()
                    hasSeenEnablePrompt = true
                },
                onDismiss: {
                    hasSeenEnablePrompt = true
                }
            )
        }
    }

    private func toggleProtection() {
        adSmashEnabled.toggle()
        if adSmashEnabled {
            enableInSafari()
        } else {
            // In a real app you could also deep-link to Safari extension settings here.
        }
    }

    private func enableInSafari() {
        adSmashEnabled = true
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsURL)
        }
    }
}

struct FeatureItem {
    let title: String
    let subtitle: String
    let icon: String
}

struct ActionButton: View {
    let title: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .frame(maxWidth: .infinity, minHeight: 44)
                .foregroundColor(.white)
                .background(color)
                .cornerRadius(12)
        }
    }
}

struct FeatureCard: View {
    let item: FeatureItem

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.08))
                    .frame(width: 42, height: 42)

                Image(systemName: item.icon)
                    .foregroundColor(.white)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(item.title)
                    .foregroundColor(.white)
                    .font(.headline)

                Text(item.subtitle)
                    .foregroundColor(.gray)
                    .font(.caption)
            }

            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(Color.white.opacity(0.04))
        .cornerRadius(16)
    }
}
