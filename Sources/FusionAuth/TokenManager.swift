import AppAuth

enum TokenManagerError: Error {
    case noStorage
}

/// TokenManager is responsible for managing the authorization tokens.
/// It provides methods to get, save, and clear the access, refresh, and ID tokens.
/// The tokens are stored using a configured Storage implementation.
public class TokenManager {
    private var storage: Storage?

    /// Configures the TokenManager with a specific storage implementation.
    /// - Parameter storage: The storage implementation to be used by the TokenManager.
    /// - Returns: The TokenManager instance configured with the provided storage.
    func withStorage(storage: Storage) -> TokenManager {
        self.storage = storage
        return self
    }

    /// Retrieves the current authorization state from the storage.
    /// - Returns: The FusionAuthStateData object representing the current authorization state, or nil if not found.
    func getAuthState() -> FusionAuthStateData? {
        guard let authState = self.storage?.get(key: "authState") else {
            return nil
        }

        guard let jsonAuthState = authState as String? else {
            return nil
        }

        do {
            return try JSONDecoder().decode(FusionAuthStateData.self, from: jsonAuthState.data(using: .utf8)!)
        } catch {
            print("Error decoding auth state: \(error)")
            return nil
        }
    }

    /// Saves the provided authorization state to the storage.
    /// - Parameter authState: The FusionAuthStateData object representing the authorization state to be saved.
    /// - Throws: TokenManagerError.noStorage if no storage is configured.
    func saveAuthState(_ authState: FusionAuthStateData) throws {
        guard let storage else {
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
        } catch {
            print("Error encoding auth state: \(error)")
        }
    }

    /// Clears the current authorization state from the storage.
    /// - Throws: TokenManagerError.noStorage if no storage is configured.
    func clearAuthState() throws {
        guard let storage else {
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
