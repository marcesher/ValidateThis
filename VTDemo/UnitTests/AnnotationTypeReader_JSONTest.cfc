<!---
	// **************************************** LICENSE INFO **************************************** \\
	
	Copyright 2010, Bob Silverberg
	
	Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in 
	compliance with the License.  You may obtain a copy of the License at 
	
		http://www.apache.org/licenses/LICENSE-2.0
	
	Unless required by applicable law or agreed to in writing, software distributed under the License is 
	distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or 
	implied.  See the License for the specific language governing permissions and limitations under the 
	License.
	
--->
<cfcomponent extends="UnitTests.BaseTestCase" output="false">
	
	<cffunction name="setUp" access="public" returntype="void">
		<cfscript>
			annotationTypeReader = CreateObject("component","ValidateThis.core.annotationTypeReaders.AnnotationTypeReader_JSON").init("frmMain");
		</cfscript>
	</cffunction>

	<cffunction name="tearDown" access="public" returntype="void">
	</cffunction>

	<cffunction name="isThisFormatReturnsTrueForJSON" access="public" returntype="void">
		<cfscript>
			assertTrue(annotationTypeReader.isThisFormat('[{"key1":"value1"}]'));
		</cfscript>  
	</cffunction>

	<cffunction name="isThisFormatReturnsFalseForNonJSONString" access="public" returntype="void">
		<cfscript>
			assertFalse(annotationTypeReader.isThisFormat('abc'));
		</cfscript>  
	</cffunction>

	<cffunction name="loadRulesReturnsCorrectPropertyDescriptions" access="public" returntype="void">
		<cfscript>
			md = getComponentMetadata("VTDemo.UnitTests.Fixture.AnnotatedBOs.User");
			PropertyDescs = annotationTypeReader.getValidations(md).PropertyDescs;
			debug(PropertyDescs);
			isPropertiesStructCorrect(PropertyDescs);
		</cfscript>  
	</cffunction>

	<cffunction name="loadRulesReturnsCorrectValidations" access="public" returntype="void">
		<cfscript>
			md = getComponentMetadata("VTDemo.UnitTests.Fixture.AnnotatedBOs.User");
			Validations = annotationTypeReader.getValidations(md).Validations;
			assertEquals(StructCount(Validations),1);
			assertEquals(StructCount(Validations.Contexts),3);
			Rules = Validations.Contexts.Register;
			assertEquals(ArrayLen(Rules),13);
			for (i = 1; i LTE ArrayLen(Rules); i = i + 1) {
				Validation = Rules[i];
				if (Validation.ValType eq "required" and Validation.PropertyName eq "LastName") {
					assertEquals(Validation.PropertyDesc,"Last Name");
					assertEquals(Validation.Parameters.DependentPropertyName,"FirstName");
					assertEquals(Validation.Parameters.DependentPropertyDesc,"First Name");
				}
				if (Validation.ValType eq "required" and Validation.PropertyName eq "UserName") {
					assertEquals(Validation.PropertyDesc,"Email Address");
				}
				if (Validation.ValType eq "email" and Validation.PropertyName eq "UserName") {
					assertEquals(Validation.PropertyDesc,"Email Address");
					assertEquals(Validation.FailureMessage,"Hey, buddy, you call that an Email Address?");
				}
				if (Validation.ValType eq "custom" and Validation.PropertyName eq "Nickname") {
					assertEquals(Validation.PropertyDesc,"Nickname");
					assertEquals(Validation.Parameters.MethodName,"CheckDupNickname");
				}
				if (Validation.ValType eq "required" and Validation.PropertyName eq "UserPass") {
					assertEquals(Validation.PropertyDesc,"Password");
				}
				if (Validation.ValType eq "rangelength" and Validation.PropertyName eq "UserPass") {
					assertEquals(Validation.PropertyDesc,"Password");
					assertEquals(Validation.Parameters.MinLength,5);
					assertEquals(Validation.Parameters.MaxLength,10);
				}
				if (Validation.ValType eq "required" and Validation.PropertyName eq "VerifyPassword") {
					assertEquals(Validation.PropertyDesc,"Verify Password");
				}
				if (Validation.ValType eq "equalTo" and Validation.PropertyName eq "VerifyPassword") {
					assertEquals(Validation.PropertyDesc,"Verify Password");
					assertEquals(Validation.Parameters.ComparePropertyName,"UserPass");
					assertEquals(Validation.Parameters.ComparePropertyDesc,"Password");
				}
				if (Validation.ValType eq "required" and Validation.PropertyName eq "UserGroup") {
					assertEquals(Validation.PropertyDesc,"User Group");
				}
				if (Validation.ValType eq "regex" and Validation.PropertyName eq "Salutation") {
					assertEquals(Validation.PropertyDesc,"Salutation");
					assertEquals(Validation.Parameters.Regex,"^(Dr|Prof|Mr|Mrs|Ms|Miss)(\.)?$");
					assertEquals(Validation.FailureMessage,"Only Dr, Prof, Mr, Mrs, Ms, or Miss (with or without a period) are allowed.");
				}
				if (Validation.ValType eq "required" and Validation.PropertyName eq "LikeOther") {
					assertEquals(Validation.PropertyDesc,"What do you like?");
					assertEquals(Validation.FailureMessage,"If you don't like Cheese and you don't like Chocolate, you must like something!");
					assertEquals(Validation.Condition.ClientTest,"$(&quot;[name='likecheese']&quot;).getvalue() == 0 && $(&quot;[name='likechocolate']&quot;).getvalue() == 0;");
					assertEquals(Validation.Condition.ServerTest,"getLikeCheese() EQ 0 AND getLikeChocolate() EQ 0");
				}
				if (Validation.ValType eq "numeric" and Validation.PropertyName eq "HowMuch") {
					assertEquals(Validation.PropertyDesc,"How much money would you like?");
				}
				if (Validation.ValType eq "required" and Validation.PropertyName eq "CommunicationMethod") {
					assertEquals(Validation.PropertyDesc,"Communication Method");
					assertEquals(Validation.Parameters.DependentPropertyDesc,"Allow Communication");
					assertEquals(Validation.Parameters.DependentPropertyName,"AllowCommunication");
					assertEquals(Validation.Parameters.DependentPropertyValue,1);
				}
			}
			Rules = Validations.Contexts.Profile;
			assertEquals(ArrayLen(Rules),15);
			for (i = 1; i LTE ArrayLen(Rules); i = i + 1) {
				Validation = Rules[i];
				if (Validation.ValType eq "required" and Validation.PropertyName eq "Salutation") {
					assertEquals(Validation.PropertyDesc,"Salutation");
				}
				if (Validation.ValType eq "required" and Validation.PropertyName eq "FirstName") {
					assertEquals(Validation.PropertyDesc,"First Name");
				}
				if (Validation.ValType eq "required" and Validation.PropertyName eq "LastName") {
					assertEquals(Validation.PropertyDesc,"Last Name");
				}
				if (Validation.ValType eq "required" and Validation.PropertyName eq "UserName") {
					assertEquals(Validation.PropertyDesc,"Email Address");
				}
				if (Validation.ValType eq "email" and Validation.PropertyName eq "UserName") {
					assertEquals(Validation.PropertyDesc,"Email Address");
					assertEquals(Validation.FailureMessage,"Hey, buddy, you call that an Email Address?");
				}
				if (Validation.ValType eq "custom" and Validation.PropertyName eq "Nickname") {
					assertEquals(Validation.PropertyDesc,"Nickname");
					assertEquals(Validation.Parameters.MethodName,"CheckDupNickname");
				}
				if (Validation.ValType eq "required" and Validation.PropertyName eq "UserPass") {
					assertEquals(Validation.PropertyDesc,"Password");
				}
				if (Validation.ValType eq "rangelength" and Validation.PropertyName eq "UserPass") {
					assertEquals(Validation.PropertyDesc,"Password");
					assertEquals(Validation.Parameters.MinLength,5);
					assertEquals(Validation.Parameters.MaxLength,10);
				}
				if (Validation.ValType eq "required" and Validation.PropertyName eq "VerifyPassword") {
					assertEquals(Validation.PropertyDesc,"Verify Password");
				}
				if (Validation.ValType eq "equalTo" and Validation.PropertyName eq "VerifyPassword") {
					assertEquals(Validation.PropertyDesc,"Verify Password");
					assertEquals(Validation.Parameters.ComparePropertyName,"UserPass");
					assertEquals(Validation.Parameters.ComparePropertyDesc,"Password");
				}
				if (Validation.ValType eq "required" and Validation.PropertyName eq "UserGroup") {
					assertEquals(Validation.PropertyDesc,"User Group");
				}
				if (Validation.ValType eq "regex" and Validation.PropertyName eq "Salutation") {
					assertEquals(Validation.PropertyDesc,"Salutation");
					assertEquals(Validation.Parameters.Regex,"^(Dr|Prof|Mr|Mrs|Ms|Miss)(\.)?$");
					assertEquals(Validation.FailureMessage,"Only Dr, Prof, Mr, Mrs, Ms, or Miss (with or without a period) are allowed.");
				}
				if (Validation.ValType eq "required" and Validation.PropertyName eq "LikeOther") {
					assertEquals(Validation.PropertyDesc,"What do you like?");
					assertEquals(Validation.FailureMessage,"If you don't like Cheese and you don't like Chocolate, you must like something!");
					assertEquals(Validation.Condition.ClientTest,"$(&quot;[name='likecheese']&quot;).getvalue() == 0 && $(&quot;[name='likechocolate']&quot;).getvalue() == 0;");
					assertEquals(Validation.Condition.ServerTest,"getLikeCheese() EQ 0 AND getLikeChocolate() EQ 0");
				}
				if (Validation.ValType eq "numeric" and Validation.PropertyName eq "HowMuch") {
					assertEquals(Validation.PropertyDesc,"How much money would you like?");
				}
				if (Validation.ValType eq "required" and Validation.PropertyName eq "CommunicationMethod") {
					assertEquals(Validation.PropertyDesc,"Communication Method");
					assertEquals(Validation.Parameters.DependentPropertyDesc,"Allow Communication");
					assertEquals(Validation.Parameters.DependentPropertyName,"AllowCommunication");
					assertEquals(Validation.Parameters.DependentPropertyValue,1);
				}
			}
		</cfscript>  
	</cffunction>
<!---

	<cffunction name="loadRulesFromAnnotationsThrowsWithInvalidJSONInFile" access="public" returntype="void" mxunit:expectedException="ValidateThis.core.fileReaders.Filereader_JSON.invalidJSON">
		<cfscript>
			defPath = getDirectoryFromPath(getCurrentTemplatePath()) & "Fixture/Rules/json";
			annotationReader.loadRulesFromAnnotations("invalid",defPath);
		</cfscript>  
	</cffunction>

	<cffunction name="loadRulesFromAnnotationsReturnsCorrectStructWithMappedPathLookingForXMLExtension" access="public" returntype="void">
		<cfscript>
			defPath = "/UnitTests/Fixture";
			PropertyDescs = annotationReader.loadRulesFromAnnotations(className,defPath).PropertyDescs;
			isPropertiesStructCorrect(PropertyDescs);
		</cfscript>  
	</cffunction>

	<cffunction name="loadRulesFromAnnotationsReturnsCorrectStructWithPhysicalPathLookingForXMLExtension" access="public" returntype="void">
		<cfscript>
			defPath = getDirectoryFromPath(getCurrentTemplatePath()) & "Fixture";
			PropertyDescs = annotationReader.loadRulesFromAnnotations(className,defPath).PropertyDescs;
			isPropertiesStructCorrect(PropertyDescs);
		</cfscript>  
	</cffunction>

	<cffunction name="loadRulesFromAnnotationsReturnsCorrectStructWithMappedPathLookingForXMLCFMExtension" access="public" returntype="void">
		<cfscript>
			defPath = "/UnitTests/Fixture";
			PropertyDescs = annotationReader.loadRulesFromAnnotations("user_cfm",defPath).PropertyDescs;
			isPropertiesStructCorrect(PropertyDescs);
		</cfscript>  
	</cffunction>

	<cffunction name="loadRulesFromAnnotationsReturnsCorrectStructWithPhysicalPathLookingForXMLCFMExtension" access="public" returntype="void">
		<cfscript>
			defPath = getDirectoryFromPath(getCurrentTemplatePath()) & "Fixture";
			PropertyDescs = annotationReader.loadRulesFromAnnotations("user_cfm",defPath).PropertyDescs;
			isPropertiesStructCorrect(PropertyDescs);
		</cfscript>  
	</cffunction>

	<cffunction name="loadRulesFromAnnotationsReturnsCorrectStructLookingForXMLExtensionInFolder" access="public" returntype="void">
		<cfscript>
			defPath = "/UnitTests/Fixture";
			PropertyDescs = annotationReader.loadRulesFromAnnotations("user.user_folder",defPath).PropertyDescs;
			isPropertiesStructCorrect(PropertyDescs);
		</cfscript>  
	</cffunction>

	<cffunction name="loadRulesFromAnnotationsReturnsCorrectStructLookingForXMLCFMExtensionInFolder" access="public" returntype="void">
		<cfscript>
			defPath = "/UnitTests/Fixture";
			PropertyDescs = annotationReader.loadRulesFromAnnotations("user_cfm.user_cfm_folder",defPath).PropertyDescs;
			isPropertiesStructCorrect(PropertyDescs);
		</cfscript>  
	</cffunction>

	<cffunction name="loadRulesFromAnnotationsReturnsCorrectStructLookingForFileInSecondFolderInList" access="public" returntype="void">
		<cfscript>
			defPath = "/UnitTests/Fixture,/UnitTests/Fixture/aSecondFolderToTest";
			PropertyDescs = annotationReader.loadRulesFromAnnotations("user.user_secondfolder",defPath).PropertyDescs;
			isPropertiesStructCorrect(PropertyDescs);
		</cfscript>  
	</cffunction>

	<cffunction name="loadRulesFromAnnotationsThrowsWithBadMappedPath" access="public" returntype="void" mxunit:expectedException="ValidateThis.core.annotationReader.definitionPathNotFound">
		<cfscript>
			defPath = "/UnitTests/Fixture/Model_Doesnt_Exist/";
			PropertyDescs = annotationReader.loadRulesFromAnnotations(className,defPath).PropertyDescs;
			isPropertiesStructCorrect(PropertyDescs);
		</cfscript>  
	</cffunction>

	<cffunction name="loadRulesFromAnnotationsThrowsWithBadPhysicalPath" access="public" returntype="void" mxunit:expectedException="ValidateThis.core.annotationReader.definitionPathNotFound">
		<cfscript>
			defPath = getDirectoryFromPath(getCurrentTemplatePath()) & "Fixture" & "Doesnt_Exist/";
			PropertyDescs = annotationReader.loadRulesFromAnnotations(className,defPath).PropertyDescs;
			isPropertiesStructCorrect(PropertyDescs);
		</cfscript>  
	</cffunction>

	<cffunction name="loadRulesFromAnnotationsReturnsCorrectStructWithMappedPathWithoutTrailingSlash" access="public" returntype="void">
		<cfscript>
			defPath = "/UnitTests/Fixture";
			PropertyDescs = annotationReader.loadRulesFromAnnotations(className,defPath).PropertyDescs;
			isPropertiesStructCorrect(PropertyDescs);
		</cfscript>  
	</cffunction>

	<cffunction name="loadRulesFromAnnotationsReturnsCorrectStructWithMappedPathWithTrailingSlash" access="public" returntype="void">
		<cfscript>
			defPath = "/UnitTests/Fixture/";
			PropertyDescs = annotationReader.loadRulesFromAnnotations(className,defPath).PropertyDescs;
			isPropertiesStructCorrect(PropertyDescs);
		</cfscript>  
	</cffunction>

	<cffunction name="loadRulesFromAnnotationsReturnsCorrectPropertyDescs" access="public" returntype="void">
		<cfscript>
			className = "user";
			definitionPath = getDirectoryFromPath(getCurrentTemplatePath()) & "Fixture";
			PropertyDescs = annotationReader.loadRulesFromAnnotations(className,definitionPath).PropertyDescs;
			isPropertiesStructCorrect(PropertyDescs);
		</cfscript>  
	</cffunction>

	<cffunction name="loadRulesFromAnnotationsReturnsCorrectValidations" access="public" returntype="void">
		<cfscript>
			className = "user";
			definitionPath = getDirectoryFromPath(getCurrentTemplatePath()) & "Fixture";
			Validations = annotationReader.loadRulesFromAnnotations(className,definitionPath).Validations;
			debug(Validations);
			assertEquals(StructCount(Validations),1);
			assertEquals(StructCount(Validations.Contexts),3);
			Rules = Validations.Contexts.Register;
			assertEquals(ArrayLen(Rules),13);
			Validation = Rules[1];
			assertEquals(Validation.ValType,"required");
			assertEquals(Validation.PropertyName,"LastName");
			assertEquals(Validation.PropertyDesc,"Last Name");
			assertEquals(Validation.Parameters.DependentPropertyName,"FirstName");
			assertEquals(Validation.Parameters.DependentPropertyDesc,"First Name");
			Validation = Rules[2];
			assertEquals(Validation.ValType,"required");
			assertEquals(Validation.PropertyName,"UserName");
			assertEquals(Validation.PropertyDesc,"Email Address");
			Validation = Rules[3];
			assertEquals(Validation.ValType,"email");
			assertEquals(Validation.PropertyName,"UserName");
			assertEquals(Validation.PropertyDesc,"Email Address");
			assertEquals(Validation.FailureMessage,"Hey, buddy, you call that an Email Address?");
			Validation = Rules[4];
			assertEquals(Validation.ValType,"custom");
			assertEquals(Validation.PropertyName,"Nickname");
			assertEquals(Validation.PropertyDesc,"Nickname");
			assertEquals(Validation.Parameters.MethodName,"CheckDupNickname");
			Validation = Rules[5];
			assertEquals(Validation.ValType,"required");
			assertEquals(Validation.PropertyName,"UserPass");
			assertEquals(Validation.PropertyDesc,"Password");
			Validation = Rules[6];
			assertEquals(Validation.ValType,"rangelength");
			assertEquals(Validation.PropertyName,"UserPass");
			assertEquals(Validation.PropertyDesc,"Password");
			assertEquals(Validation.Parameters.MinLength,5);
			assertEquals(Validation.Parameters.MaxLength,10);
			Validation = Rules[7];
			assertEquals(Validation.ValType,"required");
			assertEquals(Validation.PropertyName,"VerifyPassword");
			assertEquals(Validation.PropertyDesc,"Verify Password");
			Validation = Rules[8];
			assertEquals(Validation.ValType,"equalTo");
			assertEquals(Validation.PropertyName,"VerifyPassword");
			assertEquals(Validation.PropertyDesc,"Verify Password");
			assertEquals(Validation.Parameters.ComparePropertyName,"UserPass");
			assertEquals(Validation.Parameters.ComparePropertyDesc,"Password");
			Validation = Rules[9];
			assertEquals(Validation.ValType,"required");
			assertEquals(Validation.PropertyName,"UserGroup");
			assertEquals(Validation.PropertyDesc,"User Group");
			Validation = Rules[10];
			assertEquals(Validation.ValType,"regex");
			assertEquals(Validation.PropertyName,"Salutation");
			assertEquals(Validation.PropertyDesc,"Salutation");
			assertEquals(Validation.Parameters.Regex,"^(Dr|Prof|Mr|Mrs|Ms|Miss)(\.)?$");
			assertEquals(Validation.FailureMessage,"Only Dr, Prof, Mr, Mrs, Ms, or Miss (with or without a period) are allowed.");
			Validation = Rules[11];
			assertEquals(Validation.ValType,"required");
			assertEquals(Validation.PropertyName,"LikeOther");
			assertEquals(Validation.PropertyDesc,"What do you like?");
			assertEquals(Validation.FailureMessage,"If you don't like Cheese and you don't like Chocolate, you must like something!");
			assertEquals(Validation.Condition.ClientTest,"$(""[name='LikeCheese']"").getValue() == 0 && $(""[name='LikeChocolate']"").getValue() == 0;");
			assertEquals(Validation.Condition.ServerTest,"getLikeCheese() EQ 0 AND getLikeChocolate() EQ 0");
			Validation = Rules[12];
			assertEquals(Validation.ValType,"numeric");
			assertEquals(Validation.PropertyName,"HowMuch");
			assertEquals(Validation.PropertyDesc,"How much money would you like?");
			Validation = Rules[13];
			assertEquals(Validation.ValType,"required");
			assertEquals(Validation.PropertyName,"CommunicationMethod");
			assertEquals(Validation.PropertyDesc,"Communication Method");
			assertEquals(Validation.Parameters.DependentPropertyDesc,"Allow Communication");
			assertEquals(Validation.Parameters.DependentPropertyName,"AllowCommunication");
			assertEquals(Validation.Parameters.DependentPropertyValue,1);
			Rules = Validations.Contexts.Profile;
			assertEquals(ArrayLen(Rules),15);
			Validation = Rules[1];
			assertEquals(Validation.ValType,"required");
			assertEquals(Validation.PropertyName,"Salutation");
			assertEquals(Validation.PropertyDesc,"Salutation");
			Validation = Rules[2];
			assertEquals(Validation.ValType,"required");
			assertEquals(Validation.PropertyName,"FirstName");
			assertEquals(Validation.PropertyDesc,"First Name");
			Validation = Rules[3];
			assertEquals(Validation.ValType,"required");
			assertEquals(Validation.PropertyName,"LastName");
			assertEquals(Validation.PropertyDesc,"Last Name");
			Validation = Rules[4];
			assertEquals(Validation.ValType,"required");
			assertEquals(Validation.PropertyName,"UserName");
			assertEquals(Validation.PropertyDesc,"Email Address");
			Validation = Rules[5];
			assertEquals(Validation.ValType,"email");
			assertEquals(Validation.PropertyName,"UserName");
			assertEquals(Validation.PropertyDesc,"Email Address");
			assertEquals(Validation.FailureMessage,"Hey, buddy, you call that an Email Address?");
			Validation = Rules[6];
			assertEquals(Validation.ValType,"custom");
			assertEquals(Validation.PropertyName,"Nickname");
			assertEquals(Validation.PropertyDesc,"Nickname");
			assertEquals(Validation.Parameters.MethodName,"CheckDupNickname");
			Validation = Rules[7];
			assertEquals(Validation.ValType,"required");
			assertEquals(Validation.PropertyName,"UserPass");
			assertEquals(Validation.PropertyDesc,"Password");
			Validation = Rules[8];
			assertEquals(Validation.ValType,"rangelength");
			assertEquals(Validation.PropertyName,"UserPass");
			assertEquals(Validation.PropertyDesc,"Password");
			assertEquals(Validation.Parameters.MinLength,5);
			assertEquals(Validation.Parameters.MaxLength,10);
			Validation = Rules[9];
			assertEquals(Validation.ValType,"required");
			assertEquals(Validation.PropertyName,"VerifyPassword");
			assertEquals(Validation.PropertyDesc,"Verify Password");
			Validation = Rules[10];
			assertEquals(Validation.ValType,"equalTo");
			assertEquals(Validation.PropertyName,"VerifyPassword");
			assertEquals(Validation.PropertyDesc,"Verify Password");
			assertEquals(Validation.Parameters.ComparePropertyName,"UserPass");
			assertEquals(Validation.Parameters.ComparePropertyDesc,"Password");
			Validation = Rules[11];
			assertEquals(Validation.ValType,"required");
			assertEquals(Validation.PropertyName,"UserGroup");
			assertEquals(Validation.PropertyDesc,"User Group");
			Validation = Rules[12];
			assertEquals(Validation.ValType,"regex");
			assertEquals(Validation.PropertyName,"Salutation");
			assertEquals(Validation.PropertyDesc,"Salutation");
			assertEquals(Validation.Parameters.Regex,"^(Dr|Prof|Mr|Mrs|Ms|Miss)(\.)?$");
			assertEquals(Validation.FailureMessage,"Only Dr, Prof, Mr, Mrs, Ms, or Miss (with or without a period) are allowed.");
			Validation = Rules[13];
			assertEquals(Validation.ValType,"required");
			assertEquals(Validation.PropertyName,"LikeOther");
			assertEquals(Validation.PropertyDesc,"What do you like?");
			assertEquals(Validation.FailureMessage,"If you don't like Cheese and you don't like Chocolate, you must like something!");
			assertEquals(Validation.Condition.ClientTest,"$(""[name='LikeCheese']"").getValue() == 0 && $(""[name='LikeChocolate']"").getValue() == 0;");
			assertEquals(Validation.Condition.ServerTest,"getLikeCheese() EQ 0 AND getLikeChocolate() EQ 0");
			Validation = Rules[14];
			assertEquals(Validation.ValType,"numeric");
			assertEquals(Validation.PropertyName,"HowMuch");
			assertEquals(Validation.PropertyDesc,"How much money would you like?");
			Validation = Rules[15];
			assertEquals(Validation.ValType,"required");
			assertEquals(Validation.PropertyName,"CommunicationMethod");
			assertEquals(Validation.PropertyDesc,"Communication Method");
			assertEquals(Validation.Parameters.DependentPropertyDesc,"Allow Communication");
			assertEquals(Validation.Parameters.DependentPropertyName,"AllowCommunication");
			assertEquals(Validation.Parameters.DependentPropertyValue,1);
		</cfscript>  
	</cffunction>

--->

	<cffunction name="isPropertiesStructCorrect" access="private" returntype="void">
		<cfargument type="Any" name="PropertyDescs" required="true" />
		<cfscript>
			assertEquals(arguments.PropertyDescs.AllowCommunication,"Allow Communication");
			assertEquals(arguments.PropertyDescs.CommunicationMethod,"Communication Method");
			assertEquals(arguments.PropertyDescs.FirstName,"First Name");
			assertEquals(arguments.PropertyDescs.HowMuch,"How much money would you like?");
			assertEquals(arguments.PropertyDescs.LastName,"Last Name");
			assertEquals(arguments.PropertyDescs.LikeOther,"What do you like?");
			assertEquals(arguments.PropertyDescs.UserGroup,"User Group");
			assertEquals(arguments.PropertyDescs.UserName,"Email Address");
			assertEquals(arguments.PropertyDescs.UserPass,"Password");
			assertEquals(arguments.PropertyDescs.VerifyPassword,"Verify Password");
		</cfscript>  
	</cffunction>

</cfcomponent>
