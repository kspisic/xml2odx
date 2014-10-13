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
	
	did_hex_len = did[:DID_id].to_i.to_s(16).length
	
	str3 = getTemplate_ServiceParam('ID',			'CODED-CONST',	'RecordDataIdentifier',	'RecordDataIdentifier',	byte_pos, did[:DID_id],	did_hex_len*4)
	byte_pos += did_hex_len / 2
	
	return "
	  <REQUEST ID='_#{$id}'>
		#{getTemplate_Short_Long_Name("RQ #{did[:DID_name]} #{r_service}")}
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
	
	did_hex_len = did[:DID_id].to_i.to_s(16).length
	
	str3 = getTemplate_ServiceParam('ID',			'CODED-CONST',	'RecordDataIdentifier',	'RecordDataIdentifier',	byte_pos, did[:DID_id],	did_hex_len*4)
	byte_pos += did_hex_len / 2

	return "
			  <POS-RESPONSE ID='_#{$id}'>
			  	#{getTemplate_Short_Long_Name("PR #{did[:DID_name]} #{r_service}")}
				<PARAMS>
				  #{str1}
				  #{str2}
				  #{str3}
				  <PARAM SEMANTIC='DATA' xsi:type='VALUE'>
				    #{getTemplate_Short_Long_Name("#{did[:DID_name]}", "#{did[:DID_name]}")}
					<BYTE-POSITION>#{byte_pos}</BYTE-POSITION>
					 <DOP-REF ID-REF='_#{did[:DID_struct_ref_id]}'/>
				  </PARAM>
				</PARAMS>
			  </POS-RESPONSE>
		"
end

def getTemplate_Read_NegResp(main_service, sub_service, did, r_service="Read")
	return "
			  <NEG-RESPONSE ID='_#{$id}'>
			  	#{getTemplate_Short_Long_Name("NR #{did[:DID_name]} #{r_service}")}
				<PARAMS>
				  #{getTemplate_ServiceParam('SERVICE-ID',	'CODED-CONST',	'SID_NR',		'SID-NR',		'0',	'127',	'8')}
				  #{getTemplate_ServiceParam('SERVICEIDRQ',	'CODED-CONST',	'SID_RQ_NR',	'SID-RQ-NR',	'1',	main_service.to_i(16),	'8')}				
				  <PARAM SEMANTIC='DATA' xsi:type='VALUE'>
				    #{getTemplate_Short_Long_Name("#{r_service} NR", "#{r_service}_NR")}
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

def getTemplate_Write_Request(main_service, sub_service, did, r_service="Write")
	return "
		<REQUEST ID='_#{$id}'>
		#{getTemplate_Short_Long_Name("RQ #{did[:DID_name]} #{r_service}")}
            <PARAMS>
			  #{getTemplate_ServiceParam('SERVICE-ID',	'CODED-CONST',	'SID_RQ',		'SID-RQ',		'0',	main_service.to_i(16),	'8')}
			  #{getTemplate_ServiceParam('ID',			'CODED-CONST',	'RecordDataIdentifier',	'RecordDataIdentifier',	'1', "#{did[:DID_id]}",	'16')}
			  <PARAM SEMANTIC='DATA' xsi:type='VALUE'>
					#{getTemplate_Short_Long_Name("#{did[:DID_name]}", "#{did[:DID_name]}")}
					<BYTE-POSITION>3</BYTE-POSITION>
					 <DOP-REF ID-REF='_#{did[:DID_struct_ref_id]}'/>
			  </PARAM>
            </PARAMS>
        </REQUEST>
		"
end
def getTemplate_Write_PosResp(main_service, sub_service, did, r_service="Write")
	return "
		<POS-RESPONSE ID='_#{$id}'>
			#{getTemplate_Short_Long_Name("PR #{did[:DID_name]} #{r_service}")}
            <PARAMS>
			  #{getTemplate_ServiceParam('SERVICE-ID',	'CODED-CONST',	'SID_PR',		'SID-PR',		'0',	(main_service.to_i(16) + 64).to_s,	'8')}
			  #{getTemplate_ServiceParam('ID',			'CODED-CONST',	'RecordDataIdentifier',	'RecordDataIdentifier',	'1', "#{did[:DID_id]}",	'16')}
            </PARAMS>
          </POS-RESPONSE>
		"
end
def getTemplate_Write_NegResp(main_service, sub_service, did, r_service="Write")
	return "
		<NEG-RESPONSE ID='_#{$id}'>
			#{getTemplate_Short_Long_Name("NR #{did[:DID_name]} #{r_service}")}		
            <PARAMS>
			  #{getTemplate_ServiceParam('SERVICE-ID',	'CODED-CONST',	'SID_NR',		'SID-NR',		'0',	'127',	'8')}
			  #{getTemplate_ServiceParam('SERVICEIDRQ',	'CODED-CONST',	'SID_RQ_NR',	'SID-RQ-NR',	'1',	main_service.to_i(16),	'8')}							
              <PARAM SEMANTIC='DATA' xsi:type='VALUE'>
				#{getTemplate_Short_Long_Name("#{r_service} NR", "#{r_service}_NR")}
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

def getTemplate_Read_Request_Toyota(did, r_service="Read")
	return "
	  <REQUEST ID='_#{$id}'>
	  	#{getTemplate_Short_Long_Name("RQ #{did[:DID_name]} #{r_service}")}
		<PARAMS>
		  #{getTemplate_ServiceParam('SERVICE-ID',	'CODED-CONST',	'SID_RQ',		'SID-RQ',		'0',	'186',	'8')}
		  #{getTemplate_ServiceParam('SUBFUNCTION',	'CODED-CONST',	'Read_Data',	'Read Data',	'1',	'0',	'8')}
		  #{getTemplate_ServiceParam('ID',			'CODED-CONST',	'RecordDataIdentifier',	'RecordDataIdentifier',	'2', "#{did[:DID_id]}",	'16')}
		</PARAMS>
	  </REQUEST>
		"
end
def getTemplate_Read_PosResp_Toyota(did, r_service="Read")
	return "
			  <POS-RESPONSE ID='_#{$id}'>
			    #{getTemplate_Short_Long_Name("PR #{did[:DID_name]} #{r_service}")}
				<PARAMS>
				  #{getTemplate_ServiceParam('SERVICE-ID',	'CODED-CONST',	'SID_PR',		'SID-PR',		'0',	'250',	'8')}
				  #{getTemplate_ServiceParam('SUBFUNCTION',	'CODED-CONST',	'Read_Data',	'Read Data',	'1',	'0',	'8')}
				  #{getTemplate_ServiceParam('ID',			'CODED-CONST',	'RecordDataIdentifier',	'RecordDataIdentifier',	'2', "#{did[:DID_id]}",	'16')}
				  <PARAM SEMANTIC='DATA' xsi:type='VALUE'>
				    #{getTemplate_Short_Long_Name("#{did[:DID_name]}", "#{did[:DID_name]}")}
					<BYTE-POSITION>4</BYTE-POSITION>
					 <DOP-REF ID-REF='_#{did[:DID_struct_ref_id]}'/>
				  </PARAM>
				</PARAMS>
			  </POS-RESPONSE>
		"
end
def getTemplate_Read_NegResp_Toyota(did, r_service="Read")
	return "
			  <NEG-RESPONSE ID='_#{$id}'>
				#{getTemplate_Short_Long_Name("NR #{did[:DID_name]} #{r_service}")}
				<PARAMS>
				  #{getTemplate_ServiceParam('SERVICE-ID',	'CODED-CONST',	'SID_NR',		'SID-NR',		'0',	'127',	'8')}
				  #{getTemplate_ServiceParam('SERVICEIDRQ',	'CODED-CONST',	'SID_RQ_NR',	'SID-RQ-NR',	'1',	'186',	'8')}
				  <PARAM xsi:type='RESERVED'>
				    #{getTemplate_Short_Long_Name("#{r_service} NR", "#{r_service}_NR")}
					<BYTE-POSITION>2</BYTE-POSITION>
					<BIT-LENGTH>8</BIT-LENGTH>
				  </PARAM>
				</PARAMS>
			  </NEG-RESPONSE>
		"
end

def getTemplate_Write_Request_Toyota(did, r_service="Write")
	return "
		<REQUEST ID='_#{$id}'>
		#{getTemplate_Short_Long_Name("RQ #{did[:DID_name]} #{r_service}")}
			<PARAMS>
			   #{getTemplate_ServiceParam('SERVICE-ID',	'CODED-CONST',	'SID_RQ',		'SID-RQ',		'0',	'186',	'8')}
			   #{getTemplate_ServiceParam('SUBFUNCTION',	'CODED-CONST',	'Write_Data',	'Write Data',	'1',	'1',	'8')}
			   #{getTemplate_ServiceParam('ID',			'CODED-CONST',	'RecordDataIdentifier',	'RecordDataIdentifier',	'2', "#{did[:DID_id]}",	'16')}
			  <PARAM SEMANTIC='DATA' xsi:type='VALUE'>
					#{getTemplate_Short_Long_Name("#{did[:DID_name]}", "#{did[:DID_name]}")}
					<BYTE-POSITION>4</BYTE-POSITION>
					 <DOP-REF ID-REF='_#{did[:DID_struct_ref_id]}'/>
			  </PARAM>
            </PARAMS>
        </REQUEST>
		"
end
def getTemplate_Write_PosResp_Toyota(did, r_service="Write")
	return "
		<POS-RESPONSE ID='_#{$id}'>
			#{getTemplate_Short_Long_Name("PR #{did[:DID_name]} #{r_service}")}
            <PARAMS>
			   #{getTemplate_ServiceParam('SERVICE-ID',	'CODED-CONST',	'SID_PR',		'SID-PR',		'0',	'250',	'8')}
			   #{getTemplate_ServiceParam('SUBFUNCTION',	'CODED-CONST',	'Write_Data',	'Write Data',	'1',	'1',	'8')}
			   #{getTemplate_ServiceParam('ID',			'CODED-CONST',	'RecordDataIdentifier',	'RecordDataIdentifier',	'2', "#{did[:DID_id]}",	'16')}
            </PARAMS>
          </POS-RESPONSE>
		"
end
def getTemplate_Write_NegResp_Toyota(did, r_service="Write")
	return "
		<NEG-RESPONSE ID='_#{$id}'>
			#{getTemplate_Short_Long_Name("NR #{did[:DID_name]} #{r_service}")}		
            <PARAMS>
			#{getTemplate_ServiceParam('SERVICE-ID',	'CODED-CONST',	'SID_NR',		'SID-NR',		'0',	'127',	'8')}
			#{getTemplate_ServiceParam('SERVICEIDRQ',	'CODED-CONST',	'SID_RQ_NR',	'SID-RQ-NR',	'1',	'186',	'8')}
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



def getTemplate_Dops(did)

	prm_string = ""
	
	did[:DID_params].each{ |prm|
	
		bit_length = if prm[:PRM_isArray] then (prm[:PRM_ArrayLengthInByte]*prm[:PRM_ArrayElementLengthInBits]) else prm[:PRM_lengthinbits] end
	
		prm_string += "
			<DATA-OBJECT-PROP ID='_#{prm[:PRM_dop]}'>
              <SHORT-NAME>#{prm[:PRM_shortname]}</SHORT-NAME>
              <LONG-NAME>#{prm[:PRM_longname]}</LONG-NAME>
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
	#return "<DATA-OBJECT-PROPS>#{prm_string}</DATA-OBJECT-PROPS>"
end

def getTemplate_DiagComms(did, r_service)
	return "
			  <DIAG-SERVICE ID='_#{$id}' SEMANTIC='STOREDDATA' ADDRESSING='FUNCTIONAL-OR-PHYSICAL'>
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

def getTemplate_Params(params)

	paramsString1 = "<PARAMS>"
	paramsString2 = ""
	paramsString3 = "</PARAMS>"
	
	start_byte = 0
	
	params.each{ |prm|
		paramsString2 += "
			    <PARAM SEMANTIC='DATA' xsi:type='VALUE'>
                  <SHORT-NAME>#{prm[:PRM_shortname]}</SHORT-NAME>
                  <LONG-NAME>#{prm[:PRM_longname]}</LONG-NAME>
                  <BYTE-POSITION>#{prm[:PRM_startbyte]}</BYTE-POSITION>
				  <BIT-POSITION>#{prm[:PRM_startbit]}</BIT-POSITION>
                  <DOP-REF ID-REF='_#{prm[:PRM_dop]}'/>
                </PARAM>
		"
	}

	return paramsString1 + paramsString2 + paramsString3
	
#	return "
#              <PARAMS>
#                <PARAM SEMANTIC='DATA' xsi:type='VALUE'>
#                  <SHORT-NAME>blinker_mode</SHORT-NAME>
#                  <LONG-NAME>blinker_mode</LONG-NAME>
#                  <BYTE-POSITION>0</BYTE-POSITION>
#                  <DOP-REF ID-REF='_11'/>
#                </PARAM>
#                <PARAM SEMANTIC='DATA' xsi:type='VALUE'>
#                  <SHORT-NAME>Unused</SHORT-NAME>
#                  <LONG-NAME>Unused</LONG-NAME>
#                  <BYTE-POSITION>0</BYTE-POSITION>
#                  <BIT-POSITION>1</BIT-POSITION>
#                  <DOP-REF ID-REF='_5'/>
#                </PARAM>
#              </PARAMS>
#	"
end

def getTemplate_Structure(did)
	xml_struct = "
		<STRUCTURE ID='_#{$id}'>
		  <SHORT-NAME>#{did[:DID_name]}</SHORT-NAME>
		  <LONG-NAME>#{did[:DID_name]}</LONG-NAME>
		  <BYTE-SIZE>#{did[:DID_byte_size]}</BYTE-SIZE>
		  #{getTemplate_Params(did[:DID_params])}
		</STRUCTURE>"
		
	return xml_struct
end