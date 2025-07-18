import Foundation

public enum VirtualMachine: RawRepresentable, Hashable {
    case unknown
    case virtualMachine(String)

    public var rawValue: String {
        switch self {
        case .unknown:
            return Self.rawValueForUnknown
        case .virtualMachine(let name):
            return Self.rawValueForVirtualMachine(named: name)
        }
    }

    public init(named name: String) {
        self = .virtualMachine(name)
    }

    public init(rawValue: String) {
        let prefix = Self.rawValuePrefixForVirtualMachine
        if rawValue.hasPrefix(prefix) {
            let startIndex = rawValue.index(rawValue.startIndex, offsetBy: prefix.count)
            let name = String(rawValue[startIndex ..< rawValue.endIndex])
            self = .virtualMachine(name)
        } else {
            self = .unknown
        }
    }

    public var name: String {
        switch self {
        case .unknown:
            return "Unknown"
        case .virtualMachine(let name):
            return name
        }
    }
}

private extension VirtualMachine {
    private static var rawValueForUnknown: String {
        "unknown"
    }

    private static func rawValueForVirtualMachine(named name: String) -> String {
        rawValuePrefixForVirtualMachine + name
    }

    private static var rawValuePrefixForVirtualMachine: String {
        "virtualMachine="
    }
}
