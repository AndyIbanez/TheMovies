# Technical Notes

* The OMDBAPI returns everything as string. Whenever possible, I tried to map the results to a more sensible data type.
* `Codable` can parse `URL`s directly out of strings, so some properties such as poster URLs could be parsed as URL. But I have learned from experience that oftentimes APIs might return malfored URL's that Foundation's `URL` object can't parse. For this reason, everything that is URL is treated as a string when parsing.
* The idea to use `Provider`s and `DataSource`'s is to make it easy for SwiftUI to take dependencies that are hard to pass directly. Sometimes when you try to use generics in SwiftUI, you enter a hell of generics and it can mess a lot of stuff up.
* In order to avoid leaking the API key, the repository does not include a file mentioned in the Requirements section. There's better ways to prvent API keys from leaking, but this was the fastest way for now.
* CoreData was used via SwiftData instead. SwiftData uses CoreData behind the good, and it is the "Swiftiest" way to use CoreData in SwiftUI.


# Requirements

To build and run this project, you need to add a file called `OMDBConfigs.json` to the root of your project. The contents of the file should be:

```json
{
    "apiKey": "YOUR_API_KEY",
    "baseURL": "https://www.omdbapi.com/"
}
```

Replacing `YOUR_API_KEY` with the API key you got from [OMDBAPI](https://omdbapi.com). You can make use of the `baseURL` parameter if you own your own environment.

# Things that may make you raise your eyebrows

* The app entry point (`TheMoviesApp.swift`) may raise some eyebrows due to the way I initialize the dependencies that are used by the entire app. It was the cleanest way I could come up with in the short amount of time I had :-), but at least the providers and data sources are injected and are testable.
* `OMDBMoviesDataSourceError`. When injecting dependencies down the SwiftUI view hierarchy via the Environment, I don't like to use optionals for dependencies that are obviously not optional. So there is this default object in the environment that crashes the app whenever a developer calls it. This is good, because it forces developers to inject a different conformance that actually returns data.
