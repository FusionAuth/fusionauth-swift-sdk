import AppAuth

/// TODO
/// TokenManager is a singleton object that manages the access tokens.
/// It provides methods to get and set the access, refresh and ID tokens.
/// It uses one of the configured Storage implementations to store the access tokens.
public class TokenManager {
    private var storage: Storage? = nil

    func withStorage(storage: Storage) -> TokenManager {
        self.storage = storage
        return self
    }

    func getAuthState() -> FusionAuthStateData? {
        guard let authState = self.storage?.get(key: "authState") else {
            return nil
        }

        guard let jsonAuthState = authState as String? else {
            return nil
        }

        do {
            return try JSONDecoder().decode(FusionAuthStateData.self, from: jsonAuthState.data(using: .utf8)!)
        } catch let error {
            print("Error decoding auth state: \(error)")
            return nil
        }
    }

    func setAuthState(authState: OIDAuthState) {
        let fusionAuthState = FusionAuthStateData(
            accessToken: authState.lastTokenResponse?.accessToken ?? "",
            accessTokenExpirationTime: authState.lastTokenResponse?.accessTokenExpirationDate ?? Date(),
            idToken: authState.lastTokenResponse?.idToken ?? "",
            refreshToken: authState.refreshToken ?? ""
        )

        do {
            let jsonAuthState = try JSONEncoder().encode(fusionAuthState)
            self.storage?.set(key: "authState", content: jsonAuthState)
        } catch let error {
            print("Error encoding auth state: \(error)")
        }
    }
}

public struct FusionAuthStateData: Codable {
    var accessToken: String
    var accessTokenExpirationTime: Date
    var idToken: String
    var refreshToken: String
}
