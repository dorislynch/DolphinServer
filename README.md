
# react-native-dolphin-server

## Getting started

`$ npm install react-native-dolphin-server --save`

### Mostly automatic installation

`$ react-native link react-native-dolphin-server`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-dolphin-server` and add `RNDolphinServer.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNDolphinServer.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNDolphinServerPackage;` to the imports at the top of the file
  - Add `new RNDolphinServerPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-dolphin-server'
  	project(':react-native-dolphin-server').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-dolphin-server/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-dolphin-server')
  	```

#### Windows
[Read it! :D](https://github.com/ReactWindows/react-native)

1. In Visual Studio add the `RNDolphinServer.sln` in `node_modules/react-native-dolphin-server/windows/RNDolphinServer.sln` folder to their solution, reference from their app.
2. Open up your `MainPage.cs` app
  - Add `using Dolphin.Server.RNDolphinServer;` to the usings at the top of the file
  - Add `new RNDolphinServerPackage()` to the `List<IReactPackage>` returned by the `Packages` method


## Usage
```javascript
import RNDolphinServer from 'react-native-dolphin-server';

// TODO: What to do with the module?
RNDolphinServer;
```
  