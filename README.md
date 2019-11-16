# Welcome to UNESCO API #

UNESCO API is an open, RESTful API providing access to the UNESCO World Heritage Site data. Thank you to UNESCO for providing the XML file on which this API was built - http://whc.unesco.org/en/syndication 

## Endpoints ##

``` GET http://localhost:3000/sites ```

Returns data for all 1029 UNESCO World Heritage sites.


``` GET http://localhost:3000/sites/:id ```

Passing in a site's id_number as a parameter, returns data for that specific UNESCO site


``` GET http://localhost:3000/sites/search?```

The following parameters may be passed in as part of the query string:

| Parameter  | Options |
| ------------- | ------------- |
| Category  | ...  |
| Region  | ...  |
| State  | ...  |
| ISO_Code  | ...  |
