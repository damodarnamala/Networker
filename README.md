# Networker

`LightReachability` library helps to check network status with simple 5 steps. 
Just subscribe for network notifications, that all you will get an update when there is a change in 'Network' status. 

##### Step 1. Import library
```swift
import Networker
```

##### Step 2. Create share instance in `ViewController`
```swift
let reachability = Networker.shared
```

##### Step 3. Add observer in `viewDidLoad()`       
```swift 
override func viewDidLoad() {
  super.viewDidLoad() 

  reachability.register()
  Notification.Name.didUpdateNetworkStatus.add(self,
                                               selector: #selector(networkStatusChanged),
                                               object: nil)
}

```
##### Step 4. Add `networkStatusChanged` method in your `ViewController`       
```swift 
@objc func networkStatusChanged() {
  switch reachability.currentStatus {
  case .reachableViaWWAN, .reachableViaWiFi:
    print(" ✅ Network status 'Connected'")
    // Do your stuff here code 💻💻💻
  case .notReachable:
    print("❗️Network status 'No Internet'")
  }
}
```  

##### Step 5. Finally, Remove the observer in `deinit()`   
```swift
deinit {
  Notification.Name.didUpdateNetworkStatus.remove(self)
}
```# Networker
`LightReachability` library helps to check network status with simple 5 steps. 
Just subscribe for network notifications, that all you will get an update when there is a change in 'Network' status. 

##### Step 1. Import library
```swift
import Networker
```

##### Step 2. Create share instance in `ViewController`
```swift
let reachability = Networker.shared
```

##### Step 3. Add observer in `viewDidLoad()`       
```swift 
override func viewDidLoad() {
  super.viewDidLoad() 

  reachability.register()
  Notification.Name.didUpdateNetworkStatus.add(self,
                                               selector: #selector(networkStatusChanged),
                                               object: nil)
}

```
##### Step 4. Add `networkStatusChanged` method in your `ViewController`       
```swift 
@objc func networkStatusChanged() {
  switch reachability.currentStatus {
  case .reachableViaWWAN, .reachableViaWiFi:
    print(" ✅ Network status 'Connected'")
    // Do your stuff here code 💻💻💻
  case .notReachable:
    print("❗️Network status 'No Internet'")
  }
}
```  

##### Step 5. Finally, Remove the observer in `deinit()`   
```swift
deinit {
  Notification.Name.didUpdateNetworkStatus.remove(self)
}
```
