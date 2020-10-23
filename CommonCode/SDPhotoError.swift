/* ---------------------- */
/* unknown implementation */
import Foundation
public enum SDPhotoError: Error {
    case wrongStatusError(status: Int)
    case urlSessionError(Error)
    case parseError(Error)
}
