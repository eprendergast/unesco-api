# Welcome to UNESCO API #

UNESCO API is an open, RESTful API providing access to the UNESCO World Heritage Site data. Thank you to UNESCO for providing the XML file on which this API was built - http://whc.unesco.org/en/syndication .

I built this API as part of my Flatiron School Final Project, UNESGO - a web application which allows users to explore UNESCO World Heritage Sites from around the world. Repo visible here: https://github.com/eprendergast/UNESGO

## Endpoints ##


``` GET https://unesco-api.herokuapp.com/sites ```

Returns data for all 1029 UNESCO World Heritage sites.


``` GET https://unesco-api.herokuapp.com/sites/:id ```

Passing in a site's id_number as a parameter, returns data for that specific UNESCO site


``` GET https://unesco-api.herokuapp.com/states ```

Returns all countries which have at least one UNESCO World Heritage Site.


``` GET https://unesco-api.herokuapp.com/regions ```

Returns all UNESCO-specified regions.


``` GET https://unesco-api.herokuapp.com/iso_codes ```

Returns all ISO Codes for countries which have at least one UNESCO World Heritage Site.


``` GET https://unesco-api.herokuapp.com/sites/search/:query```

The following parameters may be passed in as part of the query string:

| Parameter  | Options |
| ------------- | ------------- |
| category  | Natural, Mixed, Cultural  |
| region  | Europe and North America, Latin America and the Caribbean, Africa, Asia and the Pacific, Arab States |
| state  | ...  |
| ISO_Code  | ...  |

Example usage:

``` GET https://unesco-api.herokuapp.com/sites/search/category=Natural```

``` GET https://unesco-api.herokuapp.com/sites/search/region=Asia+and+the+Pacific```

``` GET https://unesco-api.herokuapp.com/sites/search/state=Argentina```

``` GET https://unesco-api.herokuapp.com/sites/search/iso_code=ca```

