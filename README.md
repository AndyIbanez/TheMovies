# Technical Notes
* The OMDBAPI returns everything as string. Whenever possible, I tried to map the results to a more sensible data type.
* `Codable` can parse `URL`s directly out of strings, so some properties such as poster URLs could be parsed as URL. But I have learned from experience that oftentimes APIs might return malfored URL's that Foundation's `URL` object can't parse. For this reason, everything that is URL is treated as a string when parsing.

# Requirements

To build and run this project, you need to add a file called `OMDBConfigs.json` to the root of your project. The contents of the file should be:

```json
{
    "apiKey": "YOUR_API_KEY",
    "baseURL": "https://www.omdbapi.com/"
}
```

Replacing `YOUR_API_KEY` with the API key you got from [OMDBAPI](https://omdbapi.com). You can make use of the `baseURL` parameter if you own your own environment.
