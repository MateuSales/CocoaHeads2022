//
//  CocoaHeads2022Tests.swift
//  CocoaHeads2022Tests
//
//  Created by user on 24/10/22.
//

import XCTest
@testable import CocoaHeads2022

final class PresenterTests: XCTestCase {
    
    func test_loadInitialState_whenServiceIsSuccess_shouldShowName() {
        let (sut, loaderSpy, viewSpy) = makeSUT()
        
        sut.loadInitialState()
        loaderSpy.complete(with: .success("Jones"))
        
        XCTAssertEqual(viewSpy.receivedMessages, [.startLoading, .stopLoading, .display(makeViewModel())])
    }
    
    func test_loadInitialState_whenServiceFails_shouldShowError() {
        let (sut, loaderSpy, viewSpy) = makeSUT()
        
        sut.loadInitialState()
        loaderSpy.complete(with: .failure(anyError()))
        
        XCTAssertEqual(viewSpy.receivedMessages, [.startLoading, .stopLoading, .displayError(makeAlertViewModel())])
    }
}


// MARK: - Helpers

private extension PresenterTests {
    func makeSUT() -> (Presenter, NameLoaderSpy, ViewSpy) {
        let loaderSpy = NameLoaderSpy()
        let viewSpy = ViewSpy()
        let sut = Presenter(loader: loaderSpy)
        sut.view = viewSpy
        return (sut, loaderSpy, viewSpy)
    }
    
    func makeViewModel() -> ViewModel {
        .init(description: "Olá, Jones")
    }
    
    func makeAlertViewModel() -> AlertViewModel {
        .init(title: "Tivemos um problema", message: "Tente novamente mais tarde", actionTitle: "OK")
    }
    
    func anyError() -> NSError {
        NSError(domain: "", code: 1)
    }
}

final class NameLoaderSpy: NameLoader {
    private var completions: [(Result<String, Error>) -> Void] = []

    func load(completion: @escaping (Result<String, Error>) -> Void) {
        completions.append(completion)
    }
    
    func complete(with result: Result<String, Error>, at index: Int = 0) {
        completions[index](result)
    }
}

final class ViewSpy: PresenterOutput {
    enum Message: Equatable {
        case startLoading
        case stopLoading
        case display(ViewModel)
        case displayError(AlertViewModel)
        
        static func == (lhs: ViewSpy.Message, rhs: ViewSpy.Message) -> Bool {
            String(describing: lhs) == String(describing: rhs)
        }
    }
    
    private(set) var receivedMessages: [Message] = []

    func startLoading() {
        receivedMessages.append(.startLoading)
    }
    
    func stopLoading() {
        receivedMessages.append(.stopLoading)
    }
    
    func display(with viewModel: ViewModel) {
        receivedMessages.append(.display(viewModel))
    }
    
    func displayError(with viewModel: AlertViewModel) {
        receivedMessages.append(.displayError(viewModel))
    }
}
