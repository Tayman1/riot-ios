// File created from ScreenTemplate
// $ createScreen.sh DeviceVerification/Loading DeviceVerificationDataLoading
/*
 Copyright 2019 New Vector Ltd
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import Foundation
import UIKit

final class DeviceVerificationDataLoadingCoordinator: DeviceVerificationDataLoadingCoordinatorType {
    
    // MARK: - Properties
    
    // MARK: Private
    
    private var deviceVerificationDataLoadingViewModel: DeviceVerificationDataLoadingViewModelType
    private let deviceVerificationDataLoadingViewController: DeviceVerificationDataLoadingViewController
    
    // MARK: Public

    // Must be used only internally
    var childCoordinators: [Coordinator] = []
    
    weak var delegate: DeviceVerificationDataLoadingCoordinatorDelegate?
    
    // MARK: - Setup
    
    init(session: MXSession, otherUserId: String, otherDeviceId: String) {
        let deviceVerificationDataLoadingViewModel = DeviceVerificationDataLoadingViewModel(session: session, otherUserId: otherUserId, otherDeviceId: otherDeviceId)
        let deviceVerificationDataLoadingViewController = DeviceVerificationDataLoadingViewController.instantiate(with: deviceVerificationDataLoadingViewModel)
        self.deviceVerificationDataLoadingViewModel = deviceVerificationDataLoadingViewModel
        self.deviceVerificationDataLoadingViewController = deviceVerificationDataLoadingViewController
    }
    
    init(incomingKeyVerificationRequest: MXKeyVerificationRequest) {
        let deviceVerificationDataLoadingViewModel = DeviceVerificationDataLoadingViewModel(keyVerificationRequest: incomingKeyVerificationRequest)
        let deviceVerificationDataLoadingViewController = DeviceVerificationDataLoadingViewController.instantiate(with: deviceVerificationDataLoadingViewModel)
        self.deviceVerificationDataLoadingViewModel = deviceVerificationDataLoadingViewModel
        self.deviceVerificationDataLoadingViewController = deviceVerificationDataLoadingViewController
    }
    
    // MARK: - Public methods
    
    func start() {            
        self.deviceVerificationDataLoadingViewModel.coordinatorDelegate = self
    }
    
    func toPresentable() -> UIViewController {
        return self.deviceVerificationDataLoadingViewController
    }
}

// MARK: - DeviceVerificationDataLoadingViewModelCoordinatorDelegate
extension DeviceVerificationDataLoadingCoordinator: DeviceVerificationDataLoadingViewModelCoordinatorDelegate {
    
    func deviceVerificationDataLoadingViewModel(_ viewModel: DeviceVerificationDataLoadingViewModelType, didAcceptKeyVerificationWithTransaction transaction: MXKeyVerificationTransaction) {
        self.delegate?.deviceVerificationDataLoadingCoordinator(self, didAcceptKeyVerificationRequestWithTransaction: transaction)
    }
    
    func deviceVerificationDataLoadingViewModel(_ viewModel: DeviceVerificationDataLoadingViewModelType, didLoadUser user: MXUser, device: MXDeviceInfo) {
        self.delegate?.deviceVerificationDataLoadingCoordinator(self, didLoadUser: user, device: device)
    }

    func deviceVerificationDataLoadingViewModelDidCancel(_ viewModel: DeviceVerificationDataLoadingViewModelType) {
        self.delegate?.deviceVerificationDataLoadingCoordinatorDidCancel(self)
    }
}
