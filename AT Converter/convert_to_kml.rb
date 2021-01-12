require 'json'
require 'htmlentities'
coder = HTMLEntities.new
jsondata = File.read("#{Dir.pwd}/pointmap.json")
data = JSON.parse(jsondata)
rack_type = []

kml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<kml xmlns=\"http://www.opengis.net/kml/2.2\"><Document>"

converted_data = File.read("#{Dir.pwd}/pointmap_converted.txt")
converted_data.split("\n").each_with_index do |line, index|


	line_data = line.split(" ")
	feature_data = data['features'][index]['attributes']
	rack_style = feature_data['STYLE']

	if not rack_type.include?(rack_style)
		rack_type << rack_style
	end



	if line_data[0].to_i != feature_data['OBJECTID'].to_i or line_data[0].to_i == 0
		raise "Object Number Match Error Line #{index + 1} "
	end
	kml += "<Placemark>\n"
	kml += "<name>AT Bike Stand \##{feature_data['OBJECTID']}</name>\n"

	kml += "<description>"
	if not feature_data['LOCATIONDESCRIPTION'].nil?
		kml += "#{coder.encode(feature_data['LOCATIONDESCRIPTION'], :hexadecimal)}\n"
	end
	if not feature_data['COMMENTS'].nil?
		kml += "#{coder.encode(feature_data['COMMENTS'], :hexadecimal)}\n"
	end
	kml += "</description>"
	kml += "<ExtendedData>"
	kml += "<Data name=\"rack_type\">"
	kml += "<value>#{rack_style}</value>"
	kml += "</Data>"
	kml += "<Data name=\"Fixture Count\">"
	kml += "<value>#{feature_data['NUMRACKS']}</value>"
	kml += "</Data>"
	kml += "<Data name=\"Allowed Use\">"
	kml += "<value>Public</value>"
	kml += "</Data>"
	kml += "</ExtendedData>"

	kml += "<Point>"
	kml += "<coordinates>#{line_data[1]},#{line_data[2]},0</coordinates>"
	kml += "</Point>"
	kml += "</Placemark>"
end

kml += "</Document></kml>"
puts rack_type
File.open("#{Dir.pwd}/output.kml", 'w') { |file| file.write(kml) }
