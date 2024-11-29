# Technical Notes
* The OMDBAPI returns everything as string. Whenever possible, I tried to map the results to a more sensible data type.
* `Codable` can parse `URL`s directly out of strings, so some properties such as poster URLs could be parsed as URL. But I have learned from experience that oftentimes APIs might return malfored URL's that Foundation's `URL` object can't parse. For this reason, everything that is URL is treated as a string when parsing.
