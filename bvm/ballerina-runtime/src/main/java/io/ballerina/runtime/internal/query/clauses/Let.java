/*
 * Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com)
 *
 * WSO2 LLC. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at:
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for
 * the specific language governing permissions and limitations
 * under the License.
 */

package io.ballerina.runtime.internal.query.clauses;

import io.ballerina.runtime.api.Environment;
import io.ballerina.runtime.api.values.BError;
import io.ballerina.runtime.api.values.BFunctionPointer;
import io.ballerina.runtime.api.values.BMap;
import io.ballerina.runtime.api.values.BString;
import io.ballerina.runtime.internal.query.utils.QueryException;

import java.util.stream.Stream;

/**
 * Represents a `let` clause in the query pipeline that modifies frames.
 *
 * @since 2201.13.0
 */
public class Let implements QueryClause {
    private final BFunctionPointer frameModifier;
    private final Environment env;

    /**
     * Constructor for the Let.
     *
     * @param env           The runtime environment.
     * @param frameModifier The function to modify the frame.
     */
    private Let(Environment env, BFunctionPointer frameModifier) {
        this.frameModifier = frameModifier;
        this.env = env;
    }

    /**
     * Static initializer for Let.
     *
     * @param env           The runtime environment.
     * @param frameModifier The function to modify the frame.
     * @return A new instance of Let.
     */
    public static Let initLetClause(Environment env, BFunctionPointer frameModifier) {
        return new Let(env, frameModifier);
    }

    /**
     * Processes a stream of frames by applying the modifier function to each frame.
     *
     * @param inputStream The input stream of frames.
     * @return A stream of modified frames.
     */
    @Override
    public Stream<BMap<BString, Object>> process(Stream<BMap<BString, Object>> inputStream) {
        return inputStream.map(frame -> {
            Object result = frameModifier.call(env.getRuntime(), frame);
            if (result instanceof BMap<?, ?> map) {
                return (BMap<BString, Object>) map;
            }
            throw new QueryException((BError) result);
        });
    }
}
