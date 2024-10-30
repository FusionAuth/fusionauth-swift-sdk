import AppAuth

enum TokenManagerError: Error {
    case noStorage
}

/// TODO
/// TokenManager is a singleton object that manages the access tokens.
/// It provides methods to get and set the access, refresh and ID tokens.
/// It uses one of the configured Storage implementations to store the access tokens.
public class TokenManager {
    private var storage: Storage?

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

    func saveAuthState(_ authState: FusionAuthStateData) throws {
        guard let storage = storage else {
            throw TokenManagerError.noStorage
        }

        let fusionAuthState = FusionAuthStateData(
            accessToken: authState.accessToken,
            accessTokenExpirationTime: authState.accessTokenExpirationTime,
            idToken: authState.idToken,
            refreshToken: authState.refreshToken
        )

        do {
            storage.set(key: "authState", content: try fusionAuthState.toJSON() ?? "")
        } catch let error {
            print("Error encoding auth state: \(error)")
        }
    }

    func clearAuthState() throws {
        guard let storage = storage else {
            throw TokenManagerError.noStorage
        }

        storage.remove(key: "authState")
    }
}

/// FusionAuthStateData represents the authorization state data.
public struct FusionAuthStateData: Codable {
    var accessToken: String
    var accessTokenExpirationTime: Date
    var idToken: String
    var refreshToken: String
}
