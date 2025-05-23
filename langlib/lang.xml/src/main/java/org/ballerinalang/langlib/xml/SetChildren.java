/**
 * Copyright (c) 2017, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 * <p>
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p>
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 **/

package org.ballerinalang.langlib.xml;

import io.ballerina.runtime.api.creators.TypeCreator;
import io.ballerina.runtime.api.flags.TypeFlags;
import io.ballerina.runtime.api.types.PredefinedTypes;
import io.ballerina.runtime.api.types.Type;
import io.ballerina.runtime.api.types.TypeTags;
import io.ballerina.runtime.api.utils.TypeUtils;
import io.ballerina.runtime.api.values.BString;
import io.ballerina.runtime.api.values.BXml;
import io.ballerina.runtime.internal.TypeChecker;
import io.ballerina.runtime.internal.errors.ErrorCodes;
import io.ballerina.runtime.internal.errors.ErrorHelper;
import io.ballerina.runtime.internal.xml.XmlFactory;

import java.util.Arrays;

/**
 * Set the children of an XML if its a singleton. Error otherwise.
 * Any existing children will be removed.
 * 
 * @since 0.88
 */
public class SetChildren {

    private static final String OPERATION = "set children to xml element";

    private SetChildren() {
    }

    public static void setChildren(BXml xml, Object children) {
        if (!IsElement.isElement(xml)) {
            throw ErrorHelper.getRuntimeException(ErrorCodes.XML_FUNC_TYPE_ERROR, "setChildren", "element");
        }

        Type childrenType = TypeUtils.getImpliedType(TypeChecker.getType(children));
        if (childrenType.getTag() == TypeTags.STRING_TAG) {
            BXml xmlText = XmlFactory.createXMLText((BString) children);
            children = xmlText;
        } else if (TypeTags.isXMLTypeTag(childrenType.getTag())) {
            ErrorHelper.getRuntimeException(ErrorCodes.INCOMPATIBLE_TYPE,
                                                     TypeCreator.createUnionType(
                                                             Arrays.asList(PredefinedTypes.TYPE_XML,
                                                                           PredefinedTypes.TYPE_STRING),
                                                             TypeFlags.asMask(TypeFlags.ANYDATA, TypeFlags.PURETYPE)),
                                                     childrenType);
        }

        try {
            xml.setChildren((BXml) children);
        } catch (Throwable e) {
            ErrorHelper.handleXMLException(OPERATION, e);
        }
    }
}
