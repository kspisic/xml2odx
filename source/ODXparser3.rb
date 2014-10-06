require 'nokogiri'
require 'fileutils'

$id = 10000
ID_REF_FunctionalClass = '_172' # 172 --> Ident, 250 --> Engineering Parameters
ID_REF_Nrc			   = '_106'
ID_REF_Dop			   = '_1'


	#                <DOP-REF ID-REF='#{did[:DID_struct_ref_id]}'/>

def getTemplate_Read_Request(did, r_service="Read")
	return "
	  <REQUEST ID='_#{$id}'>
		<SHORT-NAME>RQ_#{did[:DID_name]}_#{r_service}</SHORT-NAME>
		<LONG-NAME>RQ #{did[:DID_name]} #{r_service}</LONG-NAME>
		<PARAMS>
		  <PARAM SEMANTIC='SERVICE-ID' xsi:type='CODED-CONST'>
			<SHORT-NAME>SID_RQ</SHORT-NAME>
			<LONG-NAME>SID-RQ</LONG-NAME>
			<BYTE-POSITION>0</BYTE-POSITION>
			<CODED-VALUE>34</CODED-VALUE>
			<DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
			  <BIT-LENGTH>8</BIT-LENGTH>
			</DIAG-CODED-TYPE>
		  </PARAM>
		  <PARAM SEMANTIC='ID' xsi:type='CODED-CONST'>
			<SHORT-NAME>RecordDataIdentifier</SHORT-NAME>
			<LONG-NAME>RecordDataIdentifier</LONG-NAME>
			<BYTE-POSITION>1</BYTE-POSITION>
			<CODED-VALUE>#{did[:DID_id]}</CODED-VALUE>
			<DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
			  <BIT-LENGTH>16</BIT-LENGTH>
			</DIAG-CODED-TYPE>
		  </PARAM>
		</PARAMS>
	  </REQUEST>
		"
end
def getTemplate_Read_PosResp(did, r_service="Read")
	return "
			  <POS-RESPONSE ID='_#{$id}'>
				<SHORT-NAME>PR_#{did[:DID_name]}_#{r_service}</SHORT-NAME>
				<LONG-NAME>PR #{did[:DID_name]} #{r_service}</LONG-NAME>
				<PARAMS>
				  <PARAM SEMANTIC='SERVICE-ID' xsi:type='CODED-CONST'>
					<SHORT-NAME>SID_PR</SHORT-NAME>
					<LONG-NAME>SID-PR</LONG-NAME>
					<BYTE-POSITION>0</BYTE-POSITION>
					<CODED-VALUE>98</CODED-VALUE>
					<DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
					  <BIT-LENGTH>8</BIT-LENGTH>
					</DIAG-CODED-TYPE>
				  </PARAM>
				  <PARAM SEMANTIC='ID' xsi:type='CODED-CONST'>
					<SHORT-NAME>RecordDataIdentifier</SHORT-NAME>
					<LONG-NAME>RecordDataIdentifier</LONG-NAME>
					<BYTE-POSITION>1</BYTE-POSITION>
					<CODED-VALUE>#{did[:DID_id]}</CODED-VALUE>
					<DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
					  <BIT-LENGTH>16</BIT-LENGTH>
					</DIAG-CODED-TYPE>
				  </PARAM>
				  <PARAM SEMANTIC='DATA' xsi:type='VALUE'>
					<SHORT-NAME>#{did[:DID_name]}</SHORT-NAME>
					<LONG-NAME>#{did[:DID_name]}</LONG-NAME>
					<BYTE-POSITION>3</BYTE-POSITION>
					 <DOP-REF ID-REF='#{did[:DID_struct_ref_id]}'/>
				  </PARAM>
				</PARAMS>
			  </POS-RESPONSE>
		"
end
def getTemplate_Read_NegResp(did, r_service="Read")
	return "
			  <NEG-RESPONSE ID='_#{$id}'>
				<SHORT-NAME>NR_#{did[:DID_name]}_#{r_service}</SHORT-NAME>
				<LONG-NAME>NR #{did[:DID_name]} #{r_service}</LONG-NAME>
				<PARAMS>
				  <PARAM SEMANTIC='SERVICE-ID' xsi:type='CODED-CONST'>
					<SHORT-NAME>SID_NR</SHORT-NAME>
					<LONG-NAME>SID-NR</LONG-NAME>
					<BYTE-POSITION>0</BYTE-POSITION>
					<CODED-VALUE>127</CODED-VALUE>
					<DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
					  <BIT-LENGTH>8</BIT-LENGTH>
					</DIAG-CODED-TYPE>
				  </PARAM>
				  <PARAM SEMANTIC='SERVICEIDRQ' xsi:type='CODED-CONST'>
					<SHORT-NAME>SIDRQ_NR</SHORT-NAME>
					<LONG-NAME>SIDRQ-NR</LONG-NAME>
					<BYTE-POSITION>1</BYTE-POSITION>
					<CODED-VALUE>34</CODED-VALUE>
					<DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
					  <BIT-LENGTH>8</BIT-LENGTH>
					</DIAG-CODED-TYPE>
				  </PARAM>
				  <PARAM SEMANTIC='DATA' xsi:type='VALUE'>
					<SHORT-NAME>#{r_service}_NR</SHORT-NAME>
					<LONG-NAME>#{r_service} NR</LONG-NAME>
					<BYTE-POSITION>2</BYTE-POSITION>
					<DOP-REF ID-REF='#{ID_REF_Nrc}'/>
				  </PARAM>
				  <PARAM SEMANTIC='DATA' xsi:type='NRC-CONST'>
					<SHORT-NAME>NRCConst_#{r_service}_NR</SHORT-NAME>
					<LONG-NAME>#{r_service} NR</LONG-NAME>
					<BYTE-POSITION>2</BYTE-POSITION>
					<CODED-VALUES>
					  <CODED-VALUE>17</CODED-VALUE>
					  <CODED-VALUE>19</CODED-VALUE>
					  <CODED-VALUE>33</CODED-VALUE>
					  <CODED-VALUE>49</CODED-VALUE>
					  <CODED-VALUE>120</CODED-VALUE>
					  <CODED-VALUE>127</CODED-VALUE>
					</CODED-VALUES>
					<DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
					  <BIT-LENGTH>8</BIT-LENGTH>
					</DIAG-CODED-TYPE>
				  </PARAM>
				</PARAMS>
			  </NEG-RESPONSE>
		"
end

def getTemplate_Write_Request(did, r_service="Write")
	return "
		<REQUEST ID='_#{$id}'>
		<SHORT-NAME>RQ_#{did[:DID_name]}_#{r_service}</SHORT-NAME>
		<LONG-NAME>RQ #{did[:DID_name]} #{r_service}</LONG-NAME>
            <PARAMS>
              <PARAM SEMANTIC='SERVICE-ID' xsi:type='CODED-CONST'>
                <SHORT-NAME>SID_RQ</SHORT-NAME>
                <LONG-NAME>SID-RQ</LONG-NAME>
                <BYTE-POSITION>0</BYTE-POSITION>
                <CODED-VALUE>46</CODED-VALUE>
                <DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
                  <BIT-LENGTH>8</BIT-LENGTH>
                </DIAG-CODED-TYPE>
              </PARAM>
              <PARAM SEMANTIC='ID' xsi:type='CODED-CONST'>
                <SHORT-NAME>RecordDataIdentifier</SHORT-NAME>
                <LONG-NAME>RecordDataIdentifier</LONG-NAME>
                <BYTE-POSITION>1</BYTE-POSITION>
                <CODED-VALUE>#{did[:DID_id]}</CODED-VALUE>
                <DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
                  <BIT-LENGTH>16</BIT-LENGTH>
                </DIAG-CODED-TYPE>
              </PARAM>
			  <PARAM SEMANTIC='DATA' xsi:type='VALUE'>
					<SHORT-NAME>#{did[:DID_name]}</SHORT-NAME>
					<LONG-NAME>#{did[:DID_name]}</LONG-NAME>
					<BYTE-POSITION>3</BYTE-POSITION>
					 <DOP-REF ID-REF='#{did[:DID_struct_ref_id]}'/>
			  </PARAM>
            </PARAMS>
        </REQUEST>
		"
end
def getTemplate_Write_PosResp(did, r_service="Write")
	return "
		<POS-RESPONSE ID='_#{$id}'>
			<SHORT-NAME>PR_#{did[:DID_name]}_#{r_service}</SHORT-NAME>
			<LONG-NAME>PR #{did[:DID_name]} #{r_service}</LONG-NAME>
            <PARAMS>
              <PARAM SEMANTIC='SERVICE-ID' xsi:type='CODED-CONST'>
                <SHORT-NAME>SID_PR</SHORT-NAME>
                <LONG-NAME>SID-PR</LONG-NAME>
                <BYTE-POSITION>0</BYTE-POSITION>
                <CODED-VALUE>110</CODED-VALUE>
                <DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
                  <BIT-LENGTH>8</BIT-LENGTH>
                </DIAG-CODED-TYPE>
              </PARAM>
              <PARAM SEMANTIC='ID' xsi:type='CODED-CONST'>
                <SHORT-NAME>RecordDataIdentifier</SHORT-NAME>
                <LONG-NAME>RecordDataIdentifier</LONG-NAME>
                <BYTE-POSITION>1</BYTE-POSITION>
                <CODED-VALUE>#{did[:DID_id]}</CODED-VALUE>
                <DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
                  <BIT-LENGTH>16</BIT-LENGTH>
                </DIAG-CODED-TYPE>
              </PARAM>
            </PARAMS>
          </POS-RESPONSE>
		"
end
def getTemplate_Write_NegResp(did, r_service="Write")
	return "
		<NEG-RESPONSE ID='_#{$id}'>
			<SHORT-NAME>NR_#{did[:DID_name]}_#{r_service}</SHORT-NAME>
			<LONG-NAME>NR #{did[:DID_name]} #{r_service}</LONG-NAME>
            <PARAMS>
              <PARAM SEMANTIC='SERVICE-ID' xsi:type='CODED-CONST'>
                <SHORT-NAME>SID_NR</SHORT-NAME>
                <LONG-NAME>SID-NR</LONG-NAME>
                <BYTE-POSITION>0</BYTE-POSITION>
                <CODED-VALUE>127</CODED-VALUE>
                <DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
                  <BIT-LENGTH>8</BIT-LENGTH>
                </DIAG-CODED-TYPE>
              </PARAM>
              <PARAM SEMANTIC='SERVICEIDRQ' xsi:type='CODED-CONST'>
                <SHORT-NAME>SIDRQ_NR</SHORT-NAME>
                <LONG-NAME>SIDRQ-NR</LONG-NAME>
                <BYTE-POSITION>1</BYTE-POSITION>
                <CODED-VALUE>46</CODED-VALUE>
                <DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
                  <BIT-LENGTH>8</BIT-LENGTH>
                </DIAG-CODED-TYPE>
              </PARAM>
              <PARAM SEMANTIC='DATA' xsi:type='VALUE'>
				<SHORT-NAME>#{r_service}_NR</SHORT-NAME>
				<LONG-NAME>#{r_service} NR</LONG-NAME>
                <BYTE-POSITION>2</BYTE-POSITION>
                <DOP-REF ID-REF='#{ID_REF_Nrc}'/>
              </PARAM>
              <PARAM SEMANTIC='DATA' xsi:type='NRC-CONST'>
				<SHORT-NAME>NRCConst_#{r_service}_NR</SHORT-NAME>
				<LONG-NAME>#{r_service} NR</LONG-NAME>
                <BYTE-POSITION>2</BYTE-POSITION>
                <CODED-VALUES>
                  <CODED-VALUE>17</CODED-VALUE>
                  <CODED-VALUE>19</CODED-VALUE>
                  <CODED-VALUE>33</CODED-VALUE>
                  <CODED-VALUE>34</CODED-VALUE>
                  <CODED-VALUE>49</CODED-VALUE>
                  <CODED-VALUE>120</CODED-VALUE>
                  <CODED-VALUE>127</CODED-VALUE>
                </CODED-VALUES>
                <DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
                  <BIT-LENGTH>8</BIT-LENGTH>
                </DIAG-CODED-TYPE>
              </PARAM>
            </PARAMS>
          </NEG-RESPONSE>
		"
end


def getTemplate_DiagComms(did, r_service)
	return "
			  <DIAG-SERVICE ID='_#{$id}' SEMANTIC='IDENTIFICATION' ADDRESSING='FUNCTIONAL-OR-PHYSICAL'>
				<SHORT-NAME>#{did[:DID_name]}_#{r_service}</SHORT-NAME>
				<LONG-NAME>#{did[:DID_name]} #{r_service}</LONG-NAME>
				<SDGS>
				  <SDG>
					<SDG-CAPTION ID='_#{$id+1}'>
					  <SHORT-NAME>CANdelaServiceInformation</SHORT-NAME>
					</SDG-CAPTION>
					<SD SI='DiagInstanceQualifier'>#{did[:DID_name]}</SD>
					<SD SI='DiagInstanceName'>#{did[:DID_name]}</SD>
					<SD SI='ServiceQualifier'>#{r_service}</SD>
					<SD SI='ServiceName'>#{r_service}</SD>
					<SD SI='PositiveResponseSuppressed'>no</SD>
				  </SDG>
				  <SDG>
					<SDG-CAPTION ID='_#{$id+2}'>
					  <SHORT-NAME>State_Model</SHORT-NAME>
					  <LONG-NAME>State Model</LONG-NAME>
					</SDG-CAPTION>
				  </SDG>
				</SDGS>
				<FUNCT-CLASS-REFS>
				  <FUNCT-CLASS-REF ID-REF='#{ID_REF_FunctionalClass}'/>
				</FUNCT-CLASS-REFS>
				<AUDIENCE/>
				<REQUEST-REF ID-REF='_#{did[:RQ_id]}'/>
				<POS-RESPONSE-REFS>
				  <POS-RESPONSE-REF ID-REF='_#{did[:POSRESP_id]}'/>
				</POS-RESPONSE-REFS>
				<NEG-RESPONSE-REFS>
				  <NEG-RESPONSE-REF ID-REF='_#{did[:NEGRESP_id]}'/>
				</NEG-RESPONSE-REFS>
			  </DIAG-SERVICE>
		"
end



def AddOdxServiceNodesRead(table_array, service, xml_out)

	# Find nodes in xml file
	request_node = xml_out %('//ODX/DIAG-LAYER-CONTAINER/BASE-VARIANTS/BASE-VARIANT/REQUESTS')
	posresp_node = xml_out %('//ODX/DIAG-LAYER-CONTAINER/BASE-VARIANTS/BASE-VARIANT/POS-RESPONSES')
	negresp_node = xml_out %('//ODX/DIAG-LAYER-CONTAINER/BASE-VARIANTS/BASE-VARIANT/NEG-RESPONSES')
	diagcomms_node = xml_out %('//ODX/DIAG-LAYER-CONTAINER/BASE-VARIANTS/BASE-VARIANT/DIAG-COMMS')
	structures_node = xml_out %('//ODX/DIAG-LAYER-CONTAINER/BASE-VARIANTS/BASE-VARIANT/DIAG-DATA-DICTIONARY-SPEC')

	
	table_array.each{ |did|

	#did = varArray[0]

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
	}

	return xml_out
end

def AddOdxServiceNodesWrite(table_array, service, xml_out)

	# Find nodes in xml file
	request_node = xml_out %('//ODX/DIAG-LAYER-CONTAINER/BASE-VARIANTS/BASE-VARIANT/REQUESTS')
	posresp_node = xml_out %('//ODX/DIAG-LAYER-CONTAINER/BASE-VARIANTS/BASE-VARIANT/POS-RESPONSES')
	negresp_node = xml_out %('//ODX/DIAG-LAYER-CONTAINER/BASE-VARIANTS/BASE-VARIANT/NEG-RESPONSES')
	diagcomms_node = xml_out %('//ODX/DIAG-LAYER-CONTAINER/BASE-VARIANTS/BASE-VARIANT/DIAG-COMMS')
	
	table_array.each{ |did|

	#did = varArray[0]

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
	}

	return xml_out
end



def CreateTableArray(table_category, xml_in)

	varArray = []

	# interate through variables 
	xml_in.xpath("//ODX/DIAG-LAYER-CONTAINER/BASE-VARIANTS/BASE-VARIANT/DIAG-DATA-DICTIONARY-SPEC/TABLES/TABLE[SHORT-NAME='#{table_category}']/TABLE-ROW").map do |node|
	   
	   hash = {	:DID_name 			=> node.xpath('SHORT-NAME').text, 
	######			:DID_desc 			=> node.xpath('DESC').text,
				:DID_id 			=> node.xpath('KEY').text, 
				:DID_struct_ref_id 	=> node.xpath('STRUCTURE-REF/@ID-REF').text, 
				:RQ_id				=> 0,
				:POSRESP_id			=> 0,
				:NEGRESP_id			=> 0
			  }
			   
	   varArray.push(hash)
	   
	end

	return varArray
end

# read command line parameter
OdxInputFile = ARGV[0]
OdxCandelaExportFile = ARGV[1]
OdxOutputFile = ARGV[2]


if !File.exist?(OdxInputFile) then
	puts OdxInputFile + ' does not exist!'
	exit 1
end

if !File.exist?(OdxCandelaExportFile) then
	puts OdxCandelaExportFile + 'does not exist!'
	exit 1
end

f1 = File.open(OdxInputFile, 'rb')
f2 = File.open(OdxCandelaExportFile, 'rb') 
#FileUtils.copy(OdxCandelaExportFile, OdxOutputFile)
f3 = File.open(OdxOutputFile, 'w')

xml_in1 = Nokogiri::XML(f1)
xml_in2 = Nokogiri::XML(f2)

table_array = []

table_array = CreateTableArray("DID_22_TAB", xml_in1)
xml_in2  = AddOdxServiceNodesRead(table_array, "Read", xml_in2)

table_array = CreateTableArray("DID_2E_TAB", xml_in1)
xml_in2  = AddOdxServiceNodesWrite(table_array, "Write", xml_in2)

#Copy structures
structures_node_in  = xml_in1 %('//STRUCTURES')
structures_node_out = xml_in2 %('//STRUCTURES')
structures_node_out.last_element_child.after(structures_node_in.children.to_xml)

#-DATA-OBJECT-PROPS + UNIT-SPEC --> aus BMW_LIB.odx-d importieren
xml_bmw_lib = Nokogiri::XML(File.open('BMW_LIB.odx-d', 'r'))

dop_node_out = xml_in2 %('//DATA-OBJECT-PROPS')
dop_node_in  = xml_bmw_lib %('//DATA-OBJECT-PROPS')
dop_node_out.last_element_child.after(dop_node_in.children.to_xml)

unit_node_out = xml_in2 %('//UNITS')
unit_node_in  = xml_bmw_lib %('//UNITS')
unit_node_out.last_element_child.after(unit_node_in.children.to_xml)

desc = xml_in2.search("DESC")
desc.remove

#xml_in2 %('//DATA-OBJECT-PROPS').last_element_child.after(xml_bmw_lib %('//DATA-OBJECT-PROPS').children)
#xml_in2 %('//UNIT-SPEC').last_element_child.after(xml_bmw_lib %('//UNIT-SPEC').children)



f3.write(xml_in2.to_xml)

puts table_array

f1.close
f2.close
f3.close

