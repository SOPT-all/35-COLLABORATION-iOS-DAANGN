//
//  NetworkResult.swift
//  Daangn_iOS
//
//  Created by 김나연 on 11/26/24.
//

import Foundation

enum NetworkResult<T> {
    case success(T)               // 서버 통신 성공했을 때,
    case requestErr               // 요청 에러 발생했을 때,
    case decodedErr               // 디코딩 오류 발생했을 때
    case pathErr                  // 경로 에러 발생했을 때,
    case serverErr                // 서버의 내부적 에러가 발생했을 때,
    case networkFail              // 네트워크 연결 실패했을 때
}
