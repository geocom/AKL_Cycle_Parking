require 'nokogiri'
at_output = File.open("#{Dir.pwd}/AT Converter/output.kml") { |f| Nokogiri::XML(f) }
kml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<kml xmlns=\"http://www.opengis.net/kml/2.2\"><Document>"

kml += at_output.css('Placemark').to_s

Dir.entries("#{Dir.pwd}/User Contributed").each do |entry|
  if entry.include?("xml") or entry.include?("kml")
    kml_to_process = File.open("#{Dir.pwd}/User Contributed/#{entry}") { |f| Nokogiri::XML(f) }
    username = entry.split(".").first

    kml_to_process.css('Placemark').each do |placemark|

      kml += "<Placemark>\n"
    	kml += "#{placemark.css('name')}\n"

      kml += "#{placemark.css('description')}\n"

    	kml += "<ExtendedData>"
    	kml += "#{placemark.css('ExtendedData').css("Data")}"

    	kml += "<Data name=\"Contributed By\">"
    	kml += "<value>#{username}</value>"
    	kml += "</Data>"

    	kml += "</ExtendedData>"

    	kml += "#{placemark.css('Point')}"
      kml += "</Placemark>\n"
    end
  end
end

kml += "</Document></kml>"

File.open("#{Dir.pwd}/output.kml", 'w') { |file| file.write(kml) }
