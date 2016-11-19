import Foundation
import CommonCrypto

public struct HMAC {

    public static func final(value: String, algorithm: HashAlgorithm, key: Data) -> Data {
        let data = value.data(using: String.Encoding.utf8)!
        return final(value: data, algorithm: algorithm, key: key)
    }

    public static func final(value: Data, algorithm: HashAlgorithm, key: Data) -> Data {
        var result = Data(count: algorithm.digestLength)
        _ = value.withUnsafeRawPointer { v in
            result.withUnsafeMutableBytes { res in
                key.withUnsafeRawPointer { k in
                CCHmac(algorithm.HMACAlgorithm, k, key.count, v, value.count, res)
                }
            }
        }

        return result
    }
}
