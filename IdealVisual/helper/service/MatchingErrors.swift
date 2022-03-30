//
//  MatchingErrors.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 18.12.2021.
//

func matchingErrors(error: ServiceErrors) -> String {
    switch error {
    case .noData, .notFound:
        return ErrorStrings.emptyData.localized
    case .noConnection:
        return ErrorStrings.noInternetConnection.localized
    case .forbidden:
        return ErrorStrings.access.localized
    case .unauthorized:
        return ErrorStrings.unauthorized.localized
    case .invalidURL:
        return ErrorStrings.unavailable.localized
    case .unknown:
        return ErrorStrings.unknown.localized
    default:
        return ErrorStrings.unknown.localized
    }
}
