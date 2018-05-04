//
//  AMVEditableMediaViewController.swift
//  AMVEditableMediaView
//
//  Created by admin on 24/4/18.
//

import UIKit
import AVFoundation

public class AMVEditableMediaViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var takedImageView: UIImageView!
    
    var captureSession = AVCaptureSession()
    var sessionOutput = AVCapturePhotoOutput()
    var sessionOutputSetting = AVCapturePhotoSettings(
        format: [AVVideoCodecKey:AVVideoCodecJPEG]
    )
    var previewLayer : AVCaptureVideoPreviewLayer?
    var takedImage: UIImage?
    var currentVideoInput: AVCaptureDeviceInput?

    public init() {
        let bundle = Bundle(for: AMVEditableMediaViewController.self)
        super.init(nibName: "AMVEditableMediaViewController", bundle: bundle)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer?.frame = cameraView.bounds
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setSession()
    }
    
    func setSession() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [
                AVCaptureDevice.DeviceType.builtInDuoCamera,
                AVCaptureDevice.DeviceType.builtInTelephotoCamera,
                AVCaptureDevice.DeviceType.builtInWideAngleCamera
            ], mediaType: AVMediaType.video,
               position: AVCaptureDevice.Position.unspecified
        )
        for device in (deviceDiscoverySession.devices) {
            if device.position == AVCaptureDevice.Position.front {
                do {
                    let input = try AVCaptureDeviceInput(device: device)
                    if captureSession.canAddInput(input) {
                        captureSession.addInput(input)
                        
                        currentVideoInput = input
                        
                        if captureSession.canAddOutput(sessionOutput) {
                            captureSession.addOutput(sessionOutput)
                            previewLayer = AVCaptureVideoPreviewLayer(
                                session: captureSession
                            )
                            previewLayer?.videoGravity =
                                AVLayerVideoGravity.resizeAspectFill
                            previewLayer?.connection?.videoOrientation =
                                AVCaptureVideoOrientation.portrait
                            cameraView.layer.addSublayer(previewLayer!)
                        }
                    }
                } catch {
                    print("Error")
                }
            }
        }
        captureSession.startRunning()
    }
    
    func getDesiredCameraPosition(by videoInput:AVCaptureDeviceInput?) -> AVCaptureDevice.Position {
        let currentCameraPosition = videoInput?.device.position
        var desiredCameraPosition = AVCaptureDevice.Position.back
        
        if currentCameraPosition == .front {
            desiredCameraPosition = .back
        } else if currentCameraPosition == .back {
            desiredCameraPosition = .front
        }
        
        return desiredCameraPosition
    }
    
    func setCamera(with camera: AVCaptureDevice?) {
        if let cameraAvailable = camera {
            let videoInput = try? AVCaptureDeviceInput(device: cameraAvailable)
            
            if let videoInput = videoInput {
                self.captureSession.beginConfiguration()
                self.captureSession.removeInput(self.currentVideoInput!)
                
                if self.captureSession.canAddInput(videoInput) {
                    self.captureSession.addInput(videoInput)
                    self.currentVideoInput = videoInput
                } else {
                    self.captureSession.addInput(self.currentVideoInput!)
                }
                
                self.captureSession.commitConfiguration()
            }
        }
    }
}

extension AMVEditableMediaViewController: AVCapturePhotoCaptureDelegate {
    
    func captureImage(){
        let connection = self.sessionOutput.connection(with: AVMediaType.video)
        
        if let connection = connection, connection.isVideoOrientationSupported {
            connection.videoOrientation = .portrait
        }
        
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
                             kCVPixelBufferWidthKey as String: 160,
                             kCVPixelBufferHeightKey as String: 160]
        settings.previewPhotoFormat = previewFormat
        
        self.sessionOutput.capturePhoto(with: settings, delegate: self)
    }
    
    public func photoOutput(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        if
            let sampleBuffer = photoSampleBuffer,
            let previewBuffer = previewPhotoSampleBuffer,
            let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer) {
            
            var capturedImage = UIImage(data: dataImage)
            let cameraPosition = currentVideoInput?.device.position
            
            if let image = capturedImage,
                cameraPosition == .front {
                
                capturedImage = UIImage(
                    cgImage: image.cgImage!,
                    scale: image.scale,
                    orientation: UIImageOrientation.right
                )
            }
            
            DispatchQueue.main.async {
                self.captureSession.stopRunning()
                self.takedImage = capturedImage
                self.takedImageView.image = self.takedImage
                self.takedImageView.isHidden = false
            }
        }
    }
}
