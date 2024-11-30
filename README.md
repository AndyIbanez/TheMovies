# Requirements

To build and run this project, you need to add a file called `OMDBConfigs.json` to the root of your project. The contents of the file should be:

```json
{
    "apiKey": "YOUR_API_KEY",
    "baseURL": "https://www.omdbapi.com/"
}
```

Replacing `YOUR_API_KEY` with the API key you got from [OMDBAPI](https://omdbapi.com). You can make use of the `baseURL` parameter if you own your own environment.

# Technical Notes

* The OMDBAPI returns everything as string. Whenever possible, I tried to map the results to a more sensible data type.
* `Codable` can parse `URL`s directly out of strings, so some properties such as poster URLs could be parsed as URL. But I have learned from experience that oftentimes APIs might return malfored URL's that Foundation's `URL` object can't parse. For this reason, everything that is URL is treated as a string when parsing, and a `urlRepresentation` method has been added via an extension to `URL` to quickly attempt to convert strings to URLs.
* The idea to use `Provider`s and `DataSource`'s is to make it easy for SwiftUI to take dependencies that are hard to pass directly. Sometimes when you try to use generics in SwiftUI, you enter a hell of generics and it can mess a lot of stuff up. The current data sources grab data from the network, consuming OMDBAPI's API. But there can exist different data sources that grab from elsewhere, like from a local file. This can be used for testing.
* In order to avoid leaking the API key, the repository does not include a file mentioned in the Requirements section. There's better ways to prevent API keys from leaking, but this was the fastest way for now.
* CoreData was used via SwiftData. SwiftData uses CoreData behind the scenes, and it is the "Swiftiest" way to use CoreData in SwiftUI.
* Unfortunately due to my decision to use Swift's `@Observable` instead of the older `ObservedObject`, I wasn't able to debounce with Combine directly, due to how Combine events and how they may be discarded when debouncing. Therefore, debouncing was implemented with a timer instead.
* I opted to use the latest SwiftUI features (at the time of this writing, SwiftUI for iOS 18) to save time. This entire app could be done for lesser versions, but with more code.
* For caching purposes, `CachedImageView` was created. It is not a directy drop-in replacement for API image, but it uses `URLCache` under the hood to cache images. By default it uses the default `URLCache`, but a different cache can be specified.
* `NetworkExecutor` and `OMDBHTTPDataTask ` are the core of the networking system. `NetworkExecutor` executes tasks that conform to `OMDBHTTPDataTask`, a protocol. Developers implement this protocol to represent different REST calls to a service. It's a very flexible system that allows developers to execute network calls, and NetworkExecutor handles errors and details on behalf of the developer.


# Things that may make you raise your eyebrows

* The app entry point (`TheMoviesApp.swift`) may raise some eyebrows due to the way depdencies are initialized that are used by the entire app. It was the cleanest way I could come up with in the short amount of time I had :-), but at least the providers and data sources are injected and are testable.
* `OMDBMoviesDataSourceError`. When injecting dependencies down the SwiftUI view hierarchy via the Environment, I don't like to use optionals for dependencies that are obviously not optional. So there is this default object in the environment that crashes the app whenever a developer calls it. This is good, because it forces developers to inject a different conformance that actually returns data. In general, I have used forced unwrapped optionals and `fatalErrors()` very sparingly, and only for portions of the code where the entire app would fail anyway.
