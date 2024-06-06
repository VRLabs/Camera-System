<div align="center">

# Camera System

[![Generic badge](https://img.shields.io/github/downloads/VRLabs/Camera-System/total?label=Downloads)](https://github.com/VRLabs/Camera-System/releases/latest)
[![Generic badge](https://img.shields.io/badge/License-MIT-informational.svg)](https://github.com/VRLabs/Camera-System/blob/main/LICENSE)
[![Generic badge](https://img.shields.io/badge/Unity-2019.4.31f1-lightblue.svg)](https://unity3d.com/unity/whats-new/2019.4.31)
[![Generic badge](https://img.shields.io/badge/SDK-AvatarSDK3-lightblue.svg)](https://vrchat.com/home/download)

[![Generic badge](https://img.shields.io/discord/706913824607043605?color=%237289da&label=DISCORD&logo=Discord&style=for-the-badge)](https://discord.vrlabs.dev/)
[![Generic badge](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Fshieldsio-patreon.vercel.app%2Fapi%3Fusername%3Dvrlabs%26type%3Dpatrons&style=for-the-badge)](https://patreon.vrlabs.dev/)

An OSC camera system that moves a camera along a set path.

![Preview](https://github.com/VRLabs/CameraSystem/assets/76777936/449b1aed-32b8-4858-9885-3ade9a755ad7)

### ⬇️ [Download Latest Version](https://github.com/VRLabs/Camera-System/releases/latest)


### 📦 [Add to VRChat Creator Companion](https://vrlabs.dev/packages?package=dev.vrlabs.camera-system)

</div>

---

## How it works

* An osc program is ran, receiving data from VRChat.
* When points are set in the world, and settings are placed, this data is captured through constraints, contacts and physbones, and sent out to the program.
* When play is pressed, this program sends the path back to the avatar, and the camera follows this path.
  * Note: Due to this program being compiled for x86_64 Windows only, it is not compatible with ARM processors, Mac, and Linux.

## Install guide

https://github.com/VRLabs/CameraSystem/assets/76777936/42e730c4-f8c9-4a8d-b2e6-a2e0d928bfeb

* Merge the Animator Controller ``Camera System FX`` to your own FX Controller, using the [Avatars 3.0 Manager](https://github.com/VRLabs/Avatars-3.0-Manager) tool.
* Merge the Expression Parameter List ``Camera System Parameters`` to your own Expression Parameter List, using the [Avatars 3.0 Manager](https://github.com/VRLabs/Avatars-3.0-Manager) tool.
* Place the ``Camera System Menu`` somewhere in your avatar's Expression Menu.
* Drag & drop the ``Camera System`` prefab into the base of your Hierarchy.
* Right click and unpack the prefab, then drag & drop it onto your avatar.
* Place the ``Target`` object under the transform you'll be using to place the points (E.G. your right hand).
* Position the Target object until it is set correctly according to the ``DELETE ME AFTER PLACEMENT`` object, then delete said object.
* Note: Due to the use of OSCQuery, this script can not be tested in the Editor.

### Alternative Camera Systems
* To use alternative systems like VRCLens, parent constrain their cameras to the Camera object, and remove the Camera Component the system comes with by default.

## How to use

* First, unpack CameraSystemScript.zip and place it somewhere ***THAT IS NOT IN YOUR UNITY PROJECT***.
* Then, launch the CameraSystem.exe from within this folder by double clicking it. You should now see a Camera symbol in your system tray. This is also how you can close the program through right clicking the Camera symbol.
* Now, in VRChat, when you load into the avatar, you should see the Connected bool set to true.
  * If the system isn't connecting, you can try resetting your osc config for this avatar and double checking OSC is enabled in your Radial Menu.
* Then you can start placing points. You can do this by selecting which point to place using the ``Point Select Menu`` and placingit using ``Set Selected Point``, or by going into the settings and enabling Gestures.
  * The Gestures to place points are as follows:
    * FingerPoint: Place
    * ThumbsUp: Next Point
    * RockNRoll: Previous Point
  * The ``Visualize`` setting shows you the points you've placed thus far. They won't be visible in the camera if you're in VR, but they might be visible in desktop when playing, so disable this before playing the track in desktop.
  * The ``Preview`` settings shows the Desktop what the camera will see.
* Once you're done placing points, you can set the play duration and some other values in the settings.
  * The ``Time Length`` is total time by default, but with the ``Time Per Point`` option, you can change how the spline is sampled and make each point take a certain amount of time instead. Note that this makes the playback speed up and slow down based on point distance.
  * ``Use B Spline`` uses a different spline which doesn't go directly through all points, but is smoother.
  * ``Wait time at end`` decides how long the system waits at the end of the path.
  * ``Loop`` decides whether the loop will restart after it's done.
  * ``Circle Mode`` changes the system to follow a circle instead, where the first point is the center, and the second point decides the radius and look direction.
  * ``Closed Loop`` changes the system to follow a closed loop instead, so it seamlessly loops back to the first point.
* After you're happy with the settings you can press ``Play Track``, which starts the script sending the path and overriding the desktop view.
  * To cancel the playing track, you can press ``Play Track`` again.
* Right now, the range is limited to 500m from the origin, but this can be changed in by:
  * Changing the default location of the Contact Sender to the new max radius,
  * Changing the default location of the Contact Receivers to the new max radius (except for their controlled axis),
  * Changing the weights in the Contact Receiver's Position Constraint to 1 - (3 / new Max Diameter), (3 / new Max Diameter),
  * And changing the animations in the `Resources/Animations/Output` folder to the new max radius. 

## Performance stats

```c++
Cameras:                1
Constraints:            41
Contact Senders:        1
Contact Receivers:      3
FX Animator Layers:     4
Mesh Renderers:         2 (after deleting preview)
Phys Bones:             6
Phys Bone Colliders:    3
```

## Hierarchy layout

```html
Camera System
|-Camera
|-Target
|  |-DELETE ME AFTER PLACEMENT
|-Measure
|  |-Position
|  |  |-Sender
|  |  |-Receiver X
|  |  |-Receiver Y
|  |  |-Receiver Z
|  |-Rotation
|  |  |-Measure Bones
|  |  |  |-Measure X Angle
|  |  |  |-Measure X PosNeg
|  |  |  |-Measure Y Angle
|  |  |  |-Measure Y PosNeg
|  |  |  |-Measure Z Angle
|  |  |  |-Measure Z PosNeg
|  |  |-Measure Planes
|  |  |  |-X Angle Plane
|  |  |  |-Y Angle Plane
|  |  |  |-Z Angle Plane
|-Set
|  |-Result
|  |  |-Cube
|-Visualisation
|  |-Visualizer
|  |  |-Armature
|  |  |  |-Root
|  |  |  |  |-Visualizer 1
|  |  |  |  |  |-Visualizer 1_end
|  |  |  |  |-Visualizer 2
|  |  |  |  |  |-Visualizer 2_end
|  |  |  |  |-Visualizer 3
|  |  |  |  |  |-Visualizer 3_end
|  |  |  |  |-Visualizer 4
|  |  |  |  |  |-Visualizer 4_end
|  |  |  |  |-Visualizer 5
|  |  |  |  |  |-Visualizer 5_end
|  |  |  |  |-Visualizer 6
|  |  |  |  |  |-Visualizer 6_end
|  |  |  |  |-Visualizer 7
|  |  |  |  |  |-Visualizer 7_end
|  |  |  |  |-Visualizer 8
|  |  |  |  |  |-Visualizer 8_end
|  |  |  |  |-Visualizer 9
|  |  |  |  |  |-Visualizer 9_end
|  |  |  |  |-Visualizer 10
|  |  |  |  |  |-Visualizer 10_end
|  |  |  |  |-Visualizer 11
|  |  |  |  |  |-Visualizer 11_end
|  |  |  |  |-Visualizer 12
|  |  |  |  |  |-Visualizer 12_end
|  |  |  |  |-Visualizer 13
|  |  |  |  |  |-Visualizer 13_end
|  |  |  |  |-Visualizer 14
|  |  |  |  |  |-Visualizer 14_end
|  |  |  |  |-Visualizer 15
|  |  |  |  |  |-Visualizer 15_end
|  |  |  |  |-Visualizer 16
|  |  |  |  |  |-Visualizer 16_end
|  |  |  |  |-Visualizer 17
|  |  |  |  |  |-Visualizer 17_end
|  |  |  |  |-Visualizer 18
|  |  |  |  |  |-Visualizer 18_end
|  |  |  |  |-Visualizer 19
|  |  |  |  |  |-Visualizer 19_end
|  |  |  |  |-Visualizer 20
|  |  |  |  |  |-Visualizer 20_end
|  |  |  |  |-Visualizer 21
|  |  |  |  |  |-Visualizer 21_end
|  |  |  |  |-Visualizer 22
|  |  |  |  |  |-Visualizer 22_end
|  |  |  |  |-Visualizer 23
|  |  |  |  |  |-Visualizer 23_end
|  |  |  |  |-Visualizer 24
|  |  |  |  |  |-Visualizer 24_end
|  |  |  |  |-Visualizer 25
|  |  |  |  |  |-Visualizer 25_end
|  |  |  |  |-Visualizer 26
|  |  |  |  |  |-Visualizer 26_end
|  |  |  |  |-Visualizer 27
|  |  |  |  |  |-Visualizer 27_end
|  |  |  |  |-Visualizer 28
|  |  |  |  |  |-Visualizer 28_end
|  |  |  |  |-Visualizer 29
|  |  |  |  |  |-Visualizer 29_end
|  |  |-Cube
|  |-Error
```

## Contributors

* [jellejurre](https://github.com/jellejurre)

## License

Camera System is available as-is under MIT. For more information see [LICENSE](https://github.com/VRLabs/Camera-System/blob/main/LICENSE).

​

<div align="center">

[<img src="https://github.com/VRLabs/Resources/raw/main/Icons/VRLabs.png" width="50" height="50">](https://vrlabs.dev "VRLabs")
<img src="https://github.com/VRLabs/Resources/raw/main/Icons/Empty.png" width="10">
[<img src="https://github.com/VRLabs/Resources/raw/main/Icons/Discord.png" width="50" height="50">](https://discord.vrlabs.dev/ "VRLabs")
<img src="https://github.com/VRLabs/Resources/raw/main/Icons/Empty.png" width="10">
[<img src="https://github.com/VRLabs/Resources/raw/main/Icons/Patreon.png" width="50" height="50">](https://patreon.vrlabs.dev/ "VRLabs")
<img src="https://github.com/VRLabs/Resources/raw/main/Icons/Empty.png" width="10">
[<img src="https://github.com/VRLabs/Resources/raw/main/Icons/Twitter.png" width="50" height="50">](https://twitter.com/vrlabsdev "VRLabs")

</div>

