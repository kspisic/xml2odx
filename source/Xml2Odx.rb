require 'nokogiri'
require 'fileutils'
require_relative 'OdxTemplates'

CvdtInputFile = ARGV[0]
OdxTemplateInputFile = ARGV[1]
OdxOutputFile = ARGV[2]

$id = 10000
ID_REF_FunctionalClass = '_161' # 161 --> Stored data
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


def getDidParams(subdata_nodes)

	paramArray = []
	subdata_nodes.map do |subdata|
		hash = getDidParam(subdata)
		paramArray.push(hash)
	end
	
	return paramArray
end

def getDidParam(subdata)
	hash = {	:PRM_shortname => subdata.xpath('Name').text.gsub(/[^0-9A-Za-z]/, '_'),
				:PRM_longname  => subdata.xpath('GroupName').text + "." + subdata.xpath('Name').text.gsub(/[^0-9A-Za-z]/, '_'),
				:PRM_startbyte => subdata.xpath('BitStruct/StartByte').text.to_i,
				:PRM_startbit  => subdata.xpath('BitStruct/StartBit').text.to_i,
				:PRM_lengthinbits => subdata.xpath('BitStruct/LengthInBits').text.to_i,
				:PRM_isArray   => "#{subdata.xpath('BitStruct')}".include?('BitStructs'),
				:PRM_ArrayLengthInByte => if "#{subdata.xpath('BitStruct')}".include?('BitStructs') then subdata.xpath('BitStruct/BitStructs/RepeatCount').text.to_i else 0 end,
				:PRM_ArrayElementLengthInBits => if "#{subdata.xpath('BitStruct')}".include?('BitStructs') then subdata.xpath('BitStruct/BitStructs/LengthInBits').text.to_i else 0 end,
				:PRM_dop	   => "_#{$id}"
	}
	
	$id = $id + 1;
	
	return hash
end


dataArray = []

xml_in1.xpath("//Data").map do |node|
	
	hash = {	:DID_name 			=> node.xpath('Name').text.gsub(/[^0-9A-Za-z]/, '_'),
				:DID_desc 			=> "Supported Variants: #{node.xpath('SupportedVariants').text}",
				:DID_id 			=> node.xpath('ID').text,
				:DID_rw				=> node.xpath('ReadWriteMode').text,
				:DID_byte_size		=> node.xpath('Length').text,
				:DID_struct_ref_id 	=> 0, 
				:RQ_id				=> 0,
				:POSRESP_id			=> 0,
				:NEGRESP_id			=> 0,
				:DID_params			=> getDidParams(node.xpath('SubData'))
			}
			
	dataArray.push(hash)
		  
end

puts dataArray[0][:DID_params]

# Find nodes in xml template file
request_node = xml_in2 %('//REQUESTS')
posresp_node = xml_in2 %('//POS-RESPONSES')
negresp_node = xml_in2 %('//NEG-RESPONSES')
diagcomms_node = xml_in2 %('//DIAG-COMMS')
structures_node = xml_in2 %('//STRUCTURES')
dop_node = xml_in2 %('//DATA-OBJECT-PROPS')

dataArray.each{ |did|
	#puts getTemplate_Dops(did)
	
	dop_node.last_element_child.after(getTemplate_Dops(did))
	
	structures_node.last_element_child.after(getTemplate_Structure(did))
	did[:DID_struct_ref_id] = $id
	$id = $id + 1;
	
	if did[:DID_rw].include? "Read"	
		request_node.last_element_child.after(getTemplate_Read_Request_Toyota(did))
		did[:RQ_id] = $id;
		$id = $id + 1;
		
		posresp_node.last_element_child.after(getTemplate_Read_PosResp_Toyota(did))
		did[:POSRESP_id] = $id;
		$id = $id + 1;

		negresp_node.last_element_child.after(getTemplate_Read_NegResp_Toyota(did))
		did[:NEGRESP_id] = $id;
		$id = $id + 1;	
		
		diagcomms_node.last_element_child.after(getTemplate_DiagComms(did, "Read"))
		$id = $id + 3;
	end
	
	if did[:DID_rw].include? "Write"
		request_node.last_element_child.after(getTemplate_Write_Request_Toyota(did))
		did[:RQ_id] = $id;
		$id = $id + 1;
		
		posresp_node.last_element_child.after(getTemplate_Write_PosResp_Toyota(did))
		did[:POSRESP_id] = $id;
		$id = $id + 1;

		negresp_node.last_element_child.after(getTemplate_Write_NegResp_Toyota(did))
		did[:NEGRESP_id] = $id;
		$id = $id + 1;	
		
		diagcomms_node.last_element_child.after(getTemplate_DiagComms(did, "Write"))
		$id = $id + 3;
	end
}


f3.write(xml_in2.to_xml)
f3.close