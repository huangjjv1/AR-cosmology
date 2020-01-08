# AR-cosmology
--Created by AR group-- 

## About AR Cosmology Project

### Project Brief Description:  

The project is for the Royal Society Summer Science Exhibition 2020 and furtherly developed in an AR form.
Durham University’s Institute of Computational Cosmology created the Galaxy Makers exhibit in 2016 [see details](http://www.galaxymakers.org/)

### Main Interface

![avatar](https://github.com/huangjjv1/AR-cosmology/blob/Master/interface.png)

## AR-cosmology App Utilisation Guidance

### Requirements

* Xcode 11 or above (author's version: Xcode: Version 11.3 11C29 )
* iOS 11 or above
* A9 or better chip for ARWorldTrackingConfiguration
* Imported packages: UIKit(2019/11); SceneKit(2019/11); ARKit(2019/11)  

## Communication

- If you **found a bug**, open an issue after checking the [FAQ](#faq).
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

### Download

The app is only available for ios version now, and only works on device with ios 11 or higher system version. Available device models include iPhone 6s/iPhone 6S Plus/iPhone 7/iPhone 7 Plus/iPhone 8/iPhone 8 Plus/iPhone X/iPhone XR/iPhone XS/iPhone XS Plus/iPhone 11/iPhone 11 Pro/iPhone 11 Pro Plus

- 1. Pull/download the AR-cosmology project from the gitHub
 Or simply navigate to your directory of interest, then clone.
  ```bash
  $ git clone https://github.com/huangjjv1/AR-cosmology.git
  ```
- 2. Makesure your computer has Xcode pre-downloaded 
- 3. Connect any one of the above device with your computer
- 4. Finally, open the `*.xcodeproj` file and build to your [supported device](#requirements)

## Working logistic

### General
This project aims to visualize a galaxy formation simulation model by using the given SPH particles. Then import these pre simulated model into a designed app, which will enable users to view the model in AR technology by the App. Specifically, the app will recognize a nebula map hanging on a wall with an anchor point. The procedure will firstly recognize the anchor point as an axis starting point. The initial interface of the app will show the real-time picture that the device camera is pointing to. By changing the different direction values of device. When obtained value meet the preset galaxy, more detailed information will be popped out in 3D model and show the formation information in 3D based on AGN feedback, mass stars, which define the structure of the universe model. 

### Work flow

#### Setup

Application starts: It automatically calls the function viewWillAppear(), in which configuration will be initialized to ARImageTrackingConfiguration, reference images will be referred. After that, the function viewDidLoad() is automatically called next. In which, some global variable such as score, transparency.

#### Targets displaying 

- 1.    Targets recognition. The ARScneneView is running in real-time form and recognizing the image in the viewing frame. Whenever it successfully has the target and its corresponding anchor name, renderer() function is called to render and display the model in augmented reality. When the user press the detail button at the top right of the interface

- 2.    Action function. Whenever a target is recognized, it will be added a series of action to the displayed model (We set it up as a spinning sphere by default). After pressing the scale up and down button (at the bottom of the interface). Function spawningmode() is called to add the function to the rendered model.

#### Game system

- 1.    Game initialization. Game start/end button (in main interface) and the corresponding button function will give the first target to find and set score to zero.
- 2.    Game UI. Submit button submitting the current scanned target to the system and the corresponding function; The pop-up window calls the function giveClue() to show the next target that user should look for and whether the user has chosen the right one or not.
- 3.    Repick button: The focus frame is deigned to be a button as well, which has both the functions of alignment and repicking the target. When it is pressed, the corresponding reRecognize() function will be called to run viewWillDisappear() to make a pause then run the viewWillAppear() to go on detecting.


## FAQ

### I am getting the SCNMatrix error:

`Cannot invoke initializer for type 'SCNMatrix4' with an argument list of type '(matrix_float4x4)'`

Please update to the latest Xcode version (this error is a result of a syntactical change made in Beta 2). If you insist on using Xcode Beta 1, then simply replace SCNMatrix4 with SCNMatrix4FromMat4.

## Thanks

AR-cosmology has been featured by
* [Wei Zeng](https://github.com/qlqf72)
* [Siyi Han](https://github.com/hwhv66)
* [Zibo Wang](https://github.com/Aikia0710)
* [Josh Borrow](https://github.com/JBorrow)

## License

ARShooter is released under the MIT license.
[See LICENSE](https://github.com/huangjjv1/AR-cosmology/blob/master/LICENSE) for details.
