require 'nokogiri'
require 'fileutils'

CvdtInputFile = ARGV[0]
OdxTemplateInputFile = ARGV[1]
OdxOutputFile = ARGV[2]

#exit unless File.exist?(CvdtInputFile)
#exit unless File.exist?(OdxTemplateInputFile)

begin
	f1 = File.open(CvdtInputFile, 'rb')
	f2 = File.open(OdxTemplateInputFile, 'rb')
	f3 = File.open(OdxOutputFile, 'w')
rescue 
	puts "File not found"
	exit 1
end
	
xml_in1 = Nokogiri::XML(f1)
xml_in2 = Nokogiri::XML(f2)
f1.close
f2.close

dataArray = []

xml_in1.xpath("//Data").map do |node|
	
	hash = {	:DID_name 			=> node.xpath('Name').text, 
				:DID_desc 			=> "Supported Variants: #{node.xpath('SupportedVariants').text}",
				:DID_id 			=> node.xpath('ID').text, 
				:DID_struct_ref_id 	=> 0, 
				:RQ_id				=> 0,
				:POSRESP_id			=> 0,
				:NEGRESP_id			=> 0
			}
	
	dataArray.push(hash)
			  
end

f3.write(xml_in2.to_xml)
f3.close