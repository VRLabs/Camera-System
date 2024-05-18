## Camera System Install Guide

1. Put the prefab into the your scene, unpack it, and then move it onto your avatar (to give it default scaling)
2. Move the Target object to where you want to set the points from (for example under your right hand bone), and make sure it's located at the right position and rotation you want to record from
3. Delete the `DELETE ME AFTER PLACEMENT` object
3. Add the VRC Expression Parameters, Menu, and FX Controller to your avatar using the AV3 manager
4. Install VRCLens to your avatar
5. Add a Parent constraint to the VRCLens/WorldC/CamPickup/CamBase/CamObject/LensC object, with the following settings:
- Source 1: Target, weight 1
- Source 2: Result, weight 0
6. Press Activate on the parent constraint
7. Unpack the CameraSystemApp.zip folder to somewhere you wanna have it (NOT IN THE UNITY PROJECT)
8. Double click the CameraSystem.exe file to start the program. A camera icon should now show up in your task bar. To exit the program, right click this icon and press "Exit".

To scale the vizualiser points, you can scale the Vizualizer object at Camera System/Visualization/Visualizer

In game, make sure OSC is enabled on your avatar, and you have pressed "Reset Config" after installing the system.