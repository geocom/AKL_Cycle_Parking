# AT Converter

Code is writen in Ruby you will need the Ruby language installed on your computer to run this code.
The code below depends on json and htmlentities(gem install htmlentities)

Download JSON for Auckland(provided by AT) from
https://maps.at.govt.nz/arcgis/rest/services/AC/AT_ACN_Facilities_rev2/MapServer/1/query?f=json&returnGeometry=true&spatialRel=esriSpatialRelIntersects&geometry={spatialReference%22%3A{%22wkid%22%3A2193%2C%22latestWkid%22%3A2193}}&geometryType=esriGeometryEnvelope&inSR=2193&outFields=*&outSR=2193

Once downloaded save the json as pointmap.json within this directory. Run pulllocations.rb this will output the coordinate data which needs to be converted.

To convert the coordinates go to https://www.geodesy.linz.govt.nz/concord/index.cgi 

In the Input section select 
New Zealand Transverse Mercator Projection
Height System = None
Coordinate Format options = Named | easting/northing | separated by spaces

In the output section select 
World Geodetic System 1984(G730)
Height System = None
Coordinate format options = decimal degrees | longitude/latitude | separated by spaces

Enter Coordinates

Take the output of pulllocations.rb and enter this into the text field -> Convert Coordinates

Take the data outputted and save these into a file within this directory as pointmap_converted.txt

Run convert_to_kml.rb this will create a output.kml file
