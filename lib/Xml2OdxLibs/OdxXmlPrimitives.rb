# Contains mapping from internal ruby DID struct to 
# ODX XML primitives
#
# Copyright (C) 2014 Kresimir Spisic <keko@spisic.de>
# See COPYING for the License of this software

def getTemplate_Read_Request(main_service, sub_service, did, r_service="Read")

	byte_pos = 0
	str1 = getTemplate_ServiceParam('SERVICE-ID',	'CODED-CONST',	'SID_RQ',		'SID-RQ',		byte_pos,	main_service.to_i(16),	8)
	byte_pos += 1
	if sub_service != "" then
		str2 = getTemplate_ServiceParam('SUBFUNCTION',	'CODED-CONST',	'Read_Data',	'Read Data',	byte_pos,	sub_service.to_i(16),	8)
		byte_pos += 1
	else
		str2 = ""
	end
	
	did_hex_len = did.id.to_i.to_s(16).length
	
	str3 = getTemplate_ServiceParam('ID',			'CODED-CONST',	'RecordDataIdentifier',	'RecordDataIdentifier',	byte_pos, did.id,	did_hex_len*4)
	byte_pos += did_hex_len / 2
	
	return "
	  <REQUEST ID='_#{RefId.id}'>
		#{getTemplate_Short_Long_Name("RQ #{did.name} #{r_service}")}
		<PARAMS>
		  #{str1}
		  #{str2}
		  #{str3}
		</PARAMS>
	  </REQUEST>
		"
end
def getTemplate_Read_PosResp(main_service, sub_service, did, r_service="Read")
	byte_pos = 0
	str1 = getTemplate_ServiceParam('SERVICE-ID',	'CODED-CONST',	'SID_PR',		'SID-PR',		byte_pos,	(main_service.to_i(16) + 64).to_s,	8)
	byte_pos += 1
	if sub_service != "" then
		str2 = getTemplate_ServiceParam('SUBFUNCTION',	'CODED-CONST',	'Read_Data',	'Read Data',	byte_pos,	sub_service.to_i(16),	8)
		byte_pos += 1
	else
		str2 = ""
	end
	
	did_hex_len = did.id.to_i.to_s(16).length
	
	str3 = getTemplate_ServiceParam('ID',			'CODED-CONST',	'RecordDataIdentifier',	'RecordDataIdentifier',	byte_pos, did.id,	did_hex_len*4)
	byte_pos += did_hex_len / 2

	return "
			  <POS-RESPONSE ID='_#{RefId.id}'>
			  	#{getTemplate_Short_Long_Name("PR #{did.name} #{r_service}")}
				<PARAMS>
				  #{str1}
				  #{str2}
				  #{str3}
				  <PARAM SEMANTIC='DATA' xsi:type='VALUE'>
				    #{getTemplate_Short_Long_Name("#{did.name}", "#{did.name}")}
					<BYTE-POSITION>#{byte_pos}</BYTE-POSITION>
					 <DOP-REF ID-REF='_#{did.struct_ref_id}'/>
				  </PARAM>
				</PARAMS>
			  </POS-RESPONSE>
		"
end

def getTemplate_Read_NegResp(main_service, sub_service, did, r_service="Read")
	return "
			  <NEG-RESPONSE ID='_#{RefId.id}'>
			  	#{getTemplate_Short_Long_Name("NR #{did.name} #{r_service}")}
				<PARAMS>
				  #{getTemplate_ServiceParam('SERVICE-ID',	'CODED-CONST',	'SID_NR',		'SID-NR',		0,	127,	8)}
				  #{getTemplate_ServiceParam('SERVICEIDRQ',	'CODED-CONST',	'SID_RQ_NR',	'SID-RQ-NR',	1,	main_service.to_i(16),	8)}				
				  <PARAM xsi:type='RESERVED'>
				    #{getTemplate_Short_Long_Name("#{r_service} NR", "#{r_service}_NR")}
					<BYTE-POSITION>2</BYTE-POSITION>
					<BIT-LENGTH>8</BIT-LENGTH>
				  </PARAM>
				</PARAMS>
			  </NEG-RESPONSE>
		"
end

def getTemplate_Write_Request(main_service, sub_service, did, r_service="Write")

	byte_pos = 0
	str1 = getTemplate_ServiceParam('SERVICE-ID',	'CODED-CONST',	'SID_RQ',		'SID-RQ',		byte_pos,	main_service.to_i(16),	8)
	byte_pos += 1
	if sub_service != "" then
		str2 = getTemplate_ServiceParam('SUBFUNCTION',	'CODED-CONST',	'Write_Data',	'Write Data',	byte_pos,	sub_service.to_i(16),	8)
		byte_pos += 1
	else
		str2 = ""
	end
	
	did_hex_len = did.id.to_i.to_s(16).length
	
	str3 = getTemplate_ServiceParam('ID',			'CODED-CONST',	'RecordDataIdentifier',	'RecordDataIdentifier',	byte_pos, did.id,	did_hex_len*4)
	byte_pos += did_hex_len / 2

	return "
		<REQUEST ID='_#{RefId.id}'>
		#{getTemplate_Short_Long_Name("RQ #{did.name} #{r_service}")}
            <PARAMS>
				  #{str1}
				  #{str2}
				  #{str3}			  
				  <PARAM SEMANTIC='DATA' xsi:type='VALUE'>
					#{getTemplate_Short_Long_Name("#{did.name}", "#{did.name}")}
					<BYTE-POSITION>#{byte_pos}</BYTE-POSITION>
					 <DOP-REF ID-REF='_#{did.struct_ref_id}'/>
			  </PARAM>
            </PARAMS>
        </REQUEST>
		"
end
def getTemplate_Write_PosResp(main_service, sub_service, did, r_service="Write")

	byte_pos = 0
	str1 = getTemplate_ServiceParam('SERVICE-ID',	'CODED-CONST',	'SID_PR',		'SID-PR',		byte_pos,	(main_service.to_i(16) + 64).to_s,	8)
	byte_pos += 1
	if sub_service != "" then
		str2 = getTemplate_ServiceParam('SUBFUNCTION',	'CODED-CONST',	'Write_Data',	'Write Data',	byte_pos,	sub_service.to_i(16),	8)
		byte_pos += 1
	else
		str2 = ""
	end
	
	did_hex_len = did.id.to_i.to_s(16).length
	
	str3 = getTemplate_ServiceParam('ID',			'CODED-CONST',	'RecordDataIdentifier',	'RecordDataIdentifier',	byte_pos, did.id,	did_hex_len*4)
	byte_pos += did_hex_len / 2

	return "
		<POS-RESPONSE ID='_#{RefId.id}'>
			#{getTemplate_Short_Long_Name("PR #{did.name} #{r_service}")}
            <PARAMS>
				  #{str1}
				  #{str2}
				  #{str3}			  
            </PARAMS>
          </POS-RESPONSE>
		"
end

def getTemplate_Write_NegResp(main_service, sub_service, did, r_service="Write")
	return "
		<NEG-RESPONSE ID='_#{RefId.id}'>
			#{getTemplate_Short_Long_Name("NR #{did.name} #{r_service}")}		
            <PARAMS>
			  #{getTemplate_ServiceParam('SERVICE-ID',	'CODED-CONST',	'SID_NR',		'SID-NR',		0,	127,	8)}
			  #{getTemplate_ServiceParam('SERVICEIDRQ',	'CODED-CONST',	'SID_RQ_NR',	'SID-RQ-NR',	1,	main_service.to_i(16),	8)}							
			  <PARAM xsi:type='RESERVED'>
			  	#{getTemplate_Short_Long_Name("#{r_service}_NR", "#{r_service}_NR")}
                <BYTE-POSITION>2</BYTE-POSITION>
                <BIT-LENGTH>8</BIT-LENGTH>
              </PARAM>
			</PARAMS>
          </NEG-RESPONSE>
		"
end


def getTemplate_Short_Long_Name(long_name, short_name="")
	if short_name == "" then
		short_name = long_name.gsub(' ', '_')
	end
	
	ret = 	"<SHORT-NAME>#{short_name}</SHORT-NAME>
			 <LONG-NAME>#{long_name}</LONG-NAME>"
end

def getTemplate_ServiceParam(semantic, xsi_type, short_name, long_name, byte_pos, coded_val, bit_len)
  "<PARAM SEMANTIC='#{semantic}' xsi:type='#{xsi_type}'>
    #{getTemplate_Short_Long_Name("#{long_name}", "#{short_name}")}	
	<BYTE-POSITION>#{byte_pos}</BYTE-POSITION>
	<CODED-VALUE>#{coded_val}</CODED-VALUE>
	<DIAG-CODED-TYPE BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
	  <BIT-LENGTH>#{bit_len}</BIT-LENGTH>
	</DIAG-CODED-TYPE>
  </PARAM>"
end

def getTemplate_FunctClass(short_name, long_name)
    ret ="<FUNCT-CLASS ID='_#{RefId.id}'>
				#{getTemplate_Short_Long_Name(long_name, short_name)}
          </FUNCT-CLASS>"
end

def getTemplate_Dops(did)

	prm_string = ""
	
	did.params.each{ |prm|
	
		bit_length = if prm.isArray then (prm.arrayLengthInByte*prm.arrayElementLengthInBits) else prm.lengthinbits end
	
		prm_string += "
			<DATA-OBJECT-PROP ID='_#{prm.dop}'>
              <SHORT-NAME>#{prm.shortname}</SHORT-NAME>
              <LONG-NAME>#{prm.longname}</LONG-NAME>
              <COMPU-METHOD>
                <CATEGORY>IDENTICAL</CATEGORY>
              </COMPU-METHOD>
              <DIAG-CODED-TYPE BASE-TYPE-ENCODING='NONE' BASE-DATA-TYPE='A_UINT32' xsi:type='STANDARD-LENGTH-TYPE'>
                <BIT-LENGTH>#{bit_length}</BIT-LENGTH>
              </DIAG-CODED-TYPE>
              <PHYSICAL-TYPE BASE-DATA-TYPE='A_UINT32' DISPLAY-RADIX='DEC'/>
            </DATA-OBJECT-PROP>
		"
	}
	
	return prm_string
end

def getTemplate_DiagComms(did, r_service, id_ref_functionalclass)
	return "
			  <DIAG-SERVICE ID='_#{RefId.id}' SEMANTIC='STOREDDATA' ADDRESSING='FUNCTIONAL-OR-PHYSICAL'>
				<SHORT-NAME>#{did.name}_#{r_service}</SHORT-NAME>
				<LONG-NAME>#{did.name} #{r_service}</LONG-NAME>
				<SDGS>
				  <SDG>
					<SDG-CAPTION ID='_#{RefId.id+1}'>
					  <SHORT-NAME>CANdelaServiceInformation</SHORT-NAME>
					</SDG-CAPTION>
					<SD SI='DiagInstanceQualifier'>#{did.name}</SD>
					<SD SI='DiagInstanceName'>#{did.name}</SD>
					<SD SI='ServiceQualifier'>#{r_service}</SD>
					<SD SI='ServiceName'>#{r_service}</SD>
					<SD SI='PositiveResponseSuppressed'>no</SD>
				  </SDG>
				  <SDG>
					<SDG-CAPTION ID='_#{RefId.id+2}'>
					  <SHORT-NAME>State_Model</SHORT-NAME>
					  <LONG-NAME>State Model</LONG-NAME>
					</SDG-CAPTION>
				  </SDG>
				</SDGS>
				<FUNCT-CLASS-REFS>
				  <FUNCT-CLASS-REF ID-REF='_#{id_ref_functionalclass}'/>
				</FUNCT-CLASS-REFS>
				<AUDIENCE/>
				<REQUEST-REF ID-REF='_#{did.rq_id}'/>
				<POS-RESPONSE-REFS>
				  <POS-RESPONSE-REF ID-REF='_#{did.posresp_id}'/>
				</POS-RESPONSE-REFS>
				<NEG-RESPONSE-REFS>
				  <NEG-RESPONSE-REF ID-REF='_#{did.negresp_id}'/>
				</NEG-RESPONSE-REFS>
			  </DIAG-SERVICE>
		"
end

def getTemplate_Params(params)
	paramsString = ""
	params.each{ |prm|
		paramsString += "
			    <PARAM SEMANTIC='DATA' xsi:type='VALUE'>
                  <SHORT-NAME>#{prm.shortname}</SHORT-NAME>
                  <LONG-NAME>#{prm.longname}</LONG-NAME>
                  <BYTE-POSITION>#{prm.startbyte}</BYTE-POSITION>
				  <BIT-POSITION>#{prm.startbit}</BIT-POSITION>
                  <DOP-REF ID-REF='_#{prm.dop}'/>
                </PARAM>
		"
	}

	return "<PARAMS>" + paramsString + "</PARAMS>"
end

def getTemplate_Structure(did)
	return "
		<STRUCTURE ID='_#{RefId.id}'>
		  <SHORT-NAME>#{did.name}</SHORT-NAME>
		  <LONG-NAME>#{did.name}</LONG-NAME>
		  <BYTE-SIZE>#{did.byte_size}</BYTE-SIZE>
		  #{getTemplate_Params(did.params)}
		</STRUCTURE>"
end


def setODXEcuName(xml_doc, new_ecu_name)
	xml_doc.at('ODX/DIAG-LAYER-CONTAINER/SHORT-NAME').content = new_ecu_name
	xml_doc.at('ODX/DIAG-LAYER-CONTAINER/LONG-NAME').content = new_ecu_name
	xml_doc.at('BASE-VARIANT/SHORT-NAME').content = new_ecu_name
	xml_doc.at('BASE-VARIANT/LONG-NAME').content = new_ecu_name
	xml_doc.at('BASE-VARIANT')['ID'] = new_ecu_name
end