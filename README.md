Toy Java ATDD Example !!
===


## Refence
[Awesome Swift](https://github.com/Wolg/awesome-swift)
- UI
    - [Eureka](https://github.com/xmartlabs/Eureka)
    - [SwiftOverlays](https://github.com/peterprokop/SwiftOverlays)
    - [ios-charts](https://github.com/danielgindi/ios-charts)
    - [TagListView](https://github.com/xhacker/TagListView)
    - [FontAwesome.swift](https://github.com/thii/FontAwesome.swift)
    - [GoogleMaterialIconFont](https://github.com/kitasuke/GoogleMaterialIconFont)
- File
    - [FileKit](https://github.com/nvzqz/FileKit)
- Parse
    - [Argo](https://github.com/thoughtbot/Argo)
- Networking
    - [Alamofire](https://github.com/Alamofire/Alamofire)
- Queue
    - [TaskQueue(Swift)](https://github.com/icanzilb/TaskQueue)
- Test
    - [Quick](https://github.com/Quick/Quick)
- Docs
    - [jazzy](https://github.com/realm/jazzy)
- Resource
    - [Basic Playground](https://github.com/nettlep/learn-swift)
    - [Design Pattern Playground](https://github.com/ochococo/Design-Patterns-In-Swift)

## Example
### Sequence 1
```
sequenceDiagram
participant Route
participant View
participant Controller
participant Service
participant API

Route->>View: /main
View->>Controller: interacts with controller
Controller->>Service: calls service to retrieve data
Service->>API: $http.jsonp() RESTful endpoint
API->>API: process request
API-->>Service: response/jsonp
loop Reply every minute
    Service->Service: Great!
end
alt is sick
    Service->Service: Not so good :(
else is well
    Service->Service: Feeling fresh like a daisy
end
opt Extra response
    Service->Service: Thanks for asking
end
Service-->>Controller: Promise / results object
Controller->>Controller: assigned to $scope
Controller-->>View: displayed in view
```

### Sequence 2
```
sequenceDiagram
participant Route
participant LoginController
participant AuthService
participant $rootScope
participant MenuBarController

Route->>LoginController: /login
LoginController->>LoginController: forward to welcome page
LoginController->>AuthService: login(credentials)
AuthService-->>LoginController: response
AuthService->>$rootScope: $broadcast(LOGIN_SUCCESS)
$rootScope->>MenuBarController: $on(LOGIN_SUCCESS)
MenuBarController->>MenuBarController: activate()
MenuBarController->>AuthService: isAuthenticated()
AuthService-->>MenuBarController: response
MenuBarController->>AuthService: getCurrentUser()
AuthService-->>MenuBarController: response
```


[Open in evernote](evernote:///view/2147483647/s115/e4a3d4aa-f9a2-487f-bd88-dc89f6ce7523/e4a3d4aa-f9a2-487f-bd88-dc89f6ce7523/)
