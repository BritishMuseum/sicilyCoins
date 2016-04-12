Easy way to convert csv to geoJSON.
==================================


Install the Mapbox library (https://github.com/mapbox/csv2geojson) via NPM and then run the conversion command. Below assumes that you are in the correct directory.

````
    $ npm install -g csv2geojson
    $ csv2geojson matchedNomismaBM.csv > ../geojson/sicilyCoins.geojson
````