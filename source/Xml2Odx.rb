require 'nokogiri'
require 'fileutils'
require_relative 'OdxTemplates'

CvdtInputFile = ARGV[0]
OdxTemplateInputFile = ARGV[1]
OdxOutputFile = ARGV[2]

$id = 10000
ID_REF_FunctionalClass = '_172' # 172 --> Ident, 250 --> Engineering Parameters
ID_REF_Nrc			   = '_106'

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
	
	hash = {	:DID_name 			=> node.xpath('Name').text.gsub(/[^0-9A-Za-z]/, '_'),
				:DID_desc 			=> "Supported Variants: #{node.xpath('SupportedVariants').text}",
				:DID_id 			=> node.xpath('ID').text,
				:DID_rw				=> node.xpath('ReadWriteMode').text,
				:DID_struct_ref_id 	=> 0, 
				:RQ_id				=> 0,
				:POSRESP_id			=> 0,
				:NEGRESP_id			=> 0
			}
			
	dataArray.push(hash)
			  
end

# Find nodes in xml template file
request_node = xml_in2 %('//REQUESTS')
posresp_node = xml_in2 %('//POS-RESPONSES')
negresp_node = xml_in2 %('//NEG-RESPONSES')
diagcomms_node = xml_in2 %('//DIAG-COMMS')
structures_node = xml_in2 %('//DIAG-DATA-DICTIONARY-SPEC')

dataArray.each{ |did|

	if did[:DID_rw].include? "Read"
		request_node.last_element_child.after(getTemplate_Read_Request(did))
		did[:RQ_id] = $id;
		$id = $id + 1;
		
		posresp_node.last_element_child.after(getTemplate_Read_PosResp(did))
		did[:POSRESP_id] = $id;
		$id = $id + 1;

		negresp_node.last_element_child.after(getTemplate_Read_NegResp(did))
		did[:NEGRESP_id] = $id;
		$id = $id + 1;	
		
		diagcomms_node.last_element_child.after(getTemplate_DiagComms(did, "Read"))
		$id = $id + 3;
	end
	
	if did[:DID_rw].include? "Write"
		request_node.last_element_child.after(getTemplate_Write_Request(did))
		did[:RQ_id] = $id;
		$id = $id + 1;
		
		posresp_node.last_element_child.after(getTemplate_Write_PosResp(did))
		did[:POSRESP_id] = $id;
		$id = $id + 1;

		negresp_node.last_element_child.after(getTemplate_Write_NegResp(did))
		did[:NEGRESP_id] = $id;
		$id = $id + 1;	
		
		diagcomms_node.last_element_child.after(getTemplate_DiagComms(did, "Write"))
		$id = $id + 3;
	end
}


f3.write(xml_in2.to_xml)
f3.close