//
//  QRCodeReaderViewController.swift
//  Gist
//
//  Created by Thiago Lourin on 08/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeReaderViewController: UIViewController {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    private var viewModel: GistCommentViewModel?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
//        viewModel = GistCommentViewModel()
//        viewModel?.fetchGistFrom(id: "2710948")
        //setupCaptureSession()
        found(code: "2710948")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    private func setupCaptureSession() {
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }
    
    private func found(code: String) {
        GistGetService(request: GistGetRequest(gistId: code)).performRequest()        
    }
    
    private func failed() {
        let ac = UIAlertController(title: "Scanning não suportado", message: "Seu device não suporta este tipo de ação. Utilize um device com suporte à câmera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

}

extension QRCodeReaderViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

         if let metadataObject = metadataObjects.first {
             guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
             guard let stringValue = readableObject.stringValue else { return }
             AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
             found(code: stringValue)
         }

         dismiss(animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
