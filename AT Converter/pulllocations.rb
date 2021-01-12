require 'json'

jsondata = File.read("#{Dir.pwd}/pointmap.json")

JSON.parse(jsondata)['features'].each do |feature|
	puts "#{feature['attributes']['OBJECTID']} #{feature['geometry']['x']} #{feature['geometry']['y']}"
end

