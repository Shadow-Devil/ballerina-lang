// Copyright (c) 2021 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

function testUnreachableCodeWithWhile1() {
    while false {
        int _ = 1; // unreachable code
        string _ = "ABC";
    }
    int|string _ = 25;
}

function testUnreachableCodeWithWhile2() {
    while false {
        foo(); // unreachable code
        string b = "ABC";
        string _ = b + "D";
    }
    int|string _ = 25;
}

function testUnreachableCodeWithIf1() {
    if false {
        int _ = 1; // unreachable code
        string _ = "ABC";
    }
    int|string _ = 25;
}

function testUnreachableCodeWithIf2() {
    if false {
        string _ = "ABC"; // unreachable code
        foo();
        int _ = 1;
    }
    int|string _ = 25;
}

function testUnreachableCodeWithIf3() {
    if true {
        string _ = "ABC";
        return;
    }
    int|string _ = 25; // unreachable code
}

function testUnreachableCodeWithIfElse1() {
    if false {
        int _ = 1; // unreachable code
        string _ = "ABC";
    } else {
        string _ = "XYZ";
        int _ = 26;
    }
    int|string _ = 25;
}

function testUnreachableCodeWithIfElse2() {
    if true {
        int _ = 1;
        string _ = "ABC";
    } else {
        string _ = "XYZ"; // unreachable code
        int _ = 26;
    }
    int|string _ = 25;
}

function testUnreachableCodeWithIf4() {
    if true {
        int _ = 1;
        string _ = "ABC";
        return;
    }
    int|string _ = 25; // unreachable code
    int _ = 10;
}

function testUnreachableCodeWithIf5() {
    if true {
        int _ = 1;
        string _ = "ABC";
        return;
        foo(); // unreachable code
    }
    int|string _ = 25;
    int _ = 10;
}

function foo() {

}

enum E { X, Y, Z }

function testUnreachableCodeWithIfElse3() {
    E e = "Z";
    int v = 10;
    int a;

    if e is X {
        a = v * 10;
    } else if e is Y {
        a = v * 20;
    } else if e is Z { // always true
        a = v * 30;
    } else {
        foo(); // unreachable code
    }
}

function testUnreachableCodeWithIfElse4() {
    E e = "Z";
    int v = 10;
    int a;

    if e is X {
        a = v * 10;
    } else if e is Y {
        a = v * 20;
    } else if e is Z { // always true
        a = v * 30;
    } else if e is Y {
        foo(); // unreachable code
    }
}

function testUnreachableCodeWithIfElse5() {
    E e = "Z";
    int v = 10;
    int a;

    if e is X {
        a = v * 10;
    } else if e is Y {
        a = v * 20;
    } else if e is Z { // always true
        a = v * 30;
        return ();
    } else {
        a = v * 40; // unreachable code
    }
}

function testUnreachableCodeWithIfElse6(E e) returns int {
    if e is X {
        return 1;
    }
    if e is Y {
        return 2;
    }
    int _ = 12;
    // must return a result
}

function testUnreachableCodeWithIfElse7(E e) returns int {
    if e is X {
        return 1;
    } else if e is Y {
        return 2;
    }
    int _ = 12;
    // must return a result
}

function testUnreachableCodeWithWhileHavingBreakAndContinue1() {
    int a;
    while false {
        if true { // unreachable code
            continue;
        } else {
            a = 1; // unreachable code
        }
        int _ = a;
    }

    int b;
    while false {
        if true { // unreachable code
            break;
        } else {
            b = 1; // unreachable code
        }
        int _ = b;
    }
}

function testUnreachableCodeWithWhile3() returns int {
    int value = 0;
    while true {
        int|string b = 10;
        if b is int {
            value += 1;
            break;
        }
        if b is string { // always true
            value += 2;
            return value;
        }
        value += 3; // unreachable code
    }
    value += 4;
    // must return a result
}

function testUnreachableCodeWithWhile4() returns int {
    int value = 0;
    while value is int { // always true
        int|string b = 10;
        if b is int {
            value += 1;
            if false {
                break; // unreachable code
            }
            value += 2;
        }
        if b is string {
            if true {
                continue;
            }
            value += 3; // unreachable code
        }
        value += 4;
    }
    value += 4;
    // must return a result
}

function testUnreachableCodeWithWhile5() returns int {
    int value = 0;
    while false {
        value += 1; // unreachable code
        foo();
        return value;
    }
    value += 2;
    // must return a result
}

function testUnreachableCodeWithFail() returns error? {
    boolean? v = false;
    int i = 0;
    string str = "";
    while i < 5 {
        i += 1;
        do {
            int|string a = "ABC";
            if a is string {
                if v is boolean {
                    break;
                } else if v is () { // always true
                    continue;
                }
                string _ = "A"; // unreachable code
            }
            if a is int { // always true
                if true {
                    fail getError();
                }
            }
        }
    }
    string _ = "A";
}

function testUnreachableCodeWithFail2() returns error {
    while true {
        int|string a = 12;
        if a is int {
            fail getError();
        }
        string _ = a;
        if a is string { // always true
            panic error("Error");
        }
    }
    string _ = "ABC"; // unreachable code
}

function testUnreachableCodeWithCallStmtFuncReturningNever() {
    impossible();
    string _ = "ABC"; // unreachable code
}

function testUnreachableCodeWithWhile6() {
    string str = "";
    int i = 1;
    while i < 5 {
        int|string a = 12;
        if a is int {
            str += "a is int -> ";
            panic getError();
        }
        string _ = a;
        if a is string { // always true
            str += "a is string";
            impossible();
        }
        string _ = "ABC"; // unreachable code
        i += 1;
    }
    string _ = "ABC";
}

function getError() returns error {
    error err = error("Custom Error");
    return err;
}

function testConstTrueConditionWihLogicalAndInIfElse() {
    if true && true {
        return;
    } else {
        int _ = 10; // unreachable code
    }
}

function testConstTrueConditionWihLogicalAndInIf() {
    if true && true {
        return;
    }
    int _ = 10; // unreachable code
}

function testConstTrueConditionWihLogicalAndInIfElse2() {
    if true && true {
        int _ = 10;
    } else {
        int _ = 10; // unreachable code
    }
    int _ = 10;
}

function testConstTrueConditionWihLogicalAndInIfElse3() {
    if true {
        int _ = 10;
    } else if true && true {
        int _ = 10; // unreachable code
    }
    int _ = 10;
}

function testConstFalseConditionWihLogicalAndInIfElse1() {
    if false && false {
        int _ = 10; // unreachable code
    } else {
        int _ = 10;
    }
    int _ = 10;
}

function testConstTrueConditionWihLogicalAndInWhile1() {
    while true && true {
        if true && true {
            int _ = 12;
        } else if true {
            int _ = 10; // unreachable code
        }
    }
    int _ = 10;
}

function testConstFalseConditionWihTypeTestInIfElse1() {
    int a = 10;
    if a !is int {
        int _ = 10; // unreachable code
    } else {
        int _ = 10;
    }
    int _ = 10;
}

function testConstFalseConditionWihTypeTestInWhile1() {
    int a = 10;
    while a !is int {
        int _ = 10; // unreachable code
    }
    int _ = 10;
}

function impossible() returns never {
    panic error("Something impossible happened.");
}

function testConstFalseWithIf() {
    if false {
        int a = 10; // unreachable code
    } else {
        int a = 20;
    }
    int|string _ = 25;
}

function testUnreachabilitywithIfElse(E e) returns int {
    if e is X {
        return 1;
    }
    if e is Y {
        return 2;
    }
    if e is Z { // always true
        return 3;
    }
    return 4; // unreachable code
}

function testConstFalseWithWhile() {
    while false {
        int _ = 10; // unreachable code
    }
    int|string _ = 25;
}

function testUnreachableCodeWithWhileConstTrue() {
    while true {
        string _ = "A";
        return;
    }
    int _ = 12; // unreachable code
}

function testUnreachableCodeWithWhileConstTrue2() returns int {
    while true {
        string? a = "A";
        if a is string {
            return 1;
        } else if a is () { // always true
            return 2;
        } else {
            return 3; // unreachable code
        }
    }
    return 4; // unreachable code
}

function testUnreachableCodeWithWhileConstTrue3() returns int {
    int|boolean v = true;
    int res = 0;
    while v is boolean {
        string? a = "A";
        if a is string {
            string|int b = "B";
            if b is string {
                if true {
                    return 1;
                }
                return 10; // unreachable code
            }
            if b is int { // always true
                break;
            }
            return 20; // unreachable code
        } else {
            return 2;
        }
        return 3; // unreachable code
    }
    return 4;
}

function testUnreachableCodeWithWhileConstTrue4(string p) returns string {
    string str = "";
    while true {
        int|string a = 12;
        if a is int {
            str += "a is int";
            break;
        }
        string _ = a;
        if a is string { // always true
            str += "a is string";
            panic error("Error");
        }
        str += " -> final"; // unreachable code
    }
    string x = " -> end.";
    return str + x + " -> parameter:" + p;
}

const TRUE = true;
const FALSE = false;

function testUnreachableCodeWithConstRef1() {
    if TRUE {
        return;
    }
    int _ = 1; // unreachable code
}

function testUnreachableCodeWithConstRef2() {
    if FALSE {
        return; // unreachable code
    }
    int _ = 1;
}

function testUnreachableCodeWithConstRef3() {
    while TRUE {
        return;
    }
    int x = 1; // unreachable code
}

function testUnreachableCodeWithConstRef4() {
    while FALSE {
        return; // unreachable code
    }
    int _ = 1;
}

type TRUE1 true;
type FALSE1 false;

function testUnreachableCodeWithConstRef5() {
    TRUE1 b = true;

    if b {
        return;
    }

    int _ = 1; // unreachable code
}

function testUnreachableCodeWithConstRef6() {
    FALSE1 b = false;

    if b {
        return; // unreachable code
    }

    int _ = 1;
}

function testUnreachableCodeWithConstRef7() {
    TRUE1 b = true;

    while b {
        return;
    }

    int _ = 1; // unreachable code
}

function testUnreachableCodeWithConstRef8() {
    FALSE1 b = false;

    while b {
        return; // unreachable code
    }

    int _ = 1;
}

function testUnreachableCodeWithUnaryCondition() {
    if !true {
        int _ = 1; // unreachable code
    } else {
        int _ = 2;
    }
}

function testUnreachableCodeWithUnaryCondition2() {
    while !true {
        int _ = 1; // unreachable code
    }
    int _ = 2;
}

function testUnreachableCodeWithBinaryCondition() {
    int x = 1;
    if true || x < 2 {
        int _ = 1;
    } else {
        int _ = 1; // unreachable code
    }
}

function testUnreachableCodeWithBinaryCondition2() {
    int x = 1;
    if x < 2 || true {
        int _ = 1;
    } else {
        int _ = 1; // unreachable code
    }
}

function testUnreachableCodeWithBinaryCondition3() {
    int x = 1;
    if true || true {
        int _ = 1;
    } else {
        int _ = 1; // unreachable code
    }
}

function testUnreachableCodeWithBinaryCondition4() {
    int _ = 1;
    if false || false {
        int _ = 1; // unreachable code
    } else {
        int _ = 1;
    }
}

function testUnreachableCodeWithUnaryCondition3() {
    if !false {
        int _ = 1;
    } else {
        int _ = 2; // unreachable code
    }
}

function testUnreachableCodeWithUnaryCondition4() {
    while !false {
        int _ = 1;
        return;
    }
    int _ = 2; // unreachable code
}

function testUnreachableCodeWithUnaryCondition6() {
    if true == true {
        return;
    }
    int _ = 10; // unreachable code
}

function testUnreachableCodeWithUnaryCondition7() {
    if !true == true {
        int _ = 10; // unreachable code
    }
    int _ = 10;
}

function testUnreachableCodeWithUnaryCondition8() {
    if false == true {
        int _ = 10; // unreachable code
    }
    int _ = 10;
}

function testUnreachableCodeWithUnaryCondition9() {
    while true == true {
        return;
    }
    int _ = 10; // unreachable code
}

function testUnreachableCodeWithUnaryCondition10() {
    while !true == true {
        int _ = 10; // unreachable code
    }
    int _ = 10;
}

function testUnreachableCodeWithUnaryCondition11() {
    while false == true {
        int _ = 10; // unreachable code
    }
    int _ = 10;
}

function testReachableCodeWithBinaryCondition12() returns int {
    10 b = 10;

    if b != 10 {
        return 10; // unreachable code
    }
    // must return a result
}

function testReachableCodeWithBinaryCondition13() {
    10 b = 10;

    if b == 10 {
        return;
    }
    int _ = 10; // unreachable code
}

function testReachableCodeWithBinaryCondition14() {
    10|20 b = 10;

    if b == 10 {
        return;
    }

    if b == 20 {
        return;
    }

    int _ = 10; // unreachable code
}

function testReachableCodeWithBinaryCondition15() {
    10|20 b = 10;

    if b != 10 {
        return;
    }

    10 _ = b;

    if b != 20 {
        return;
    }

    int _ = 10; // unreachable code
}

type Type1 10|20;
type Type2 10;

function testReachableCodeWithBinaryCondition16() returns int {
    Type2 b = 10;

    if b != 10 {
        return 10; // unreachable code
    }
    // must return a result
}

function testReachableCodeWithBinaryCondition17() {
    Type2 b = 10;

    if b == 10 {
        return;
    }
    int _ = 10; // unreachable code
}

function testReachableCodeWithBinaryCondition18() {
    Type1 b = 10;

    if b == 10 {
        return;
    }

    if b == 20 {
        return;
    }

    int _ = 10; // unreachable code
}

function testReachableCodeWithBinaryCondition19() {
    Type1 b = 10;

    if b != 10 {
        return;
    }

    10 _ = b;

    if b != 20 {
        return;
    }

    int _ = 10; // unreachable code
}

function testUnreachabilityWithIfElseStmts1(E e) {
    if e is X {
        int _ = 10;
    } else if e is Y {
        int _ = 20;
    } else if e is Z {
        int _ = 30;
    } else {
        never _ = e; // unreachable code
    }
}

function testUnreachabilityWithIfElseStmts2(E e) {
    if e is X {
        int _ = 10;
    } else if e is Y {
        int _ = 20;
    } else if e is Z {
        int _ = 30;
    } else if e is Y {
        never _ = e; // unreachable code
    }
}

function testUnreachabilityWithIfElseStmts3(int|string|float e) {
    if e is int {
        int _ = 10;
    } else if e is string {
        int _ = 20;
    } else if e is float {
        int _ = 30;
    } else {
        never _ = e; // unreachable code
    }
}

function testUnreachabilityWithIfElseStmts4(int|string|float e) {
    if e is int {
        int _ = 10;
    } else if e is string {
        int _ = 20;
    } else if e is float {
        int _ = 30;
    } else if e is int {
        never _ = e; // unreachable code
    }
}

function testUnreachabilityWithIfElseStmts5() {
    10|20 e = 10;
    if e == 10 {
        int _ = 10;
    } else if e == 20 {
        int _ = 20;
    } else {
        never _ = e; // unreachable code
    }
}

function testUnreachabilityWithIfElseStmts6() {
    10|20 e = 10;
    if e == 10 {
        int _ = 10;
    } else if e == 20 {
        int _ = 20;
    } else {
        never _ = e; // unreachable code
    }
}

function testUnreachableCodeWithTypeNarrowing1() {
    int|string|boolean i = 1;

    if i is int|string {
        panic error("Error");
    }
    if i is boolean {
        return;
    }
    int _ = i; // unreachable code
}

function testUnreachableCodeWithTypeNarrowing2() {
    int|string a = 1;
    if a is int|string {
        a = 2;
        return;
    }

    string _ = a; // unreachable code
}

function testUnreachableCodeWithTypeNarrowing3() {
    10 b = 10;

    if b == 10 {
        return;
    }

    string _ = b; // unreachable code
}

function testUnreachableCodeWithTypeNarrowing4() {
    Type2 b = 10;

    if b == 10 {
        return;
    }

    string _ = b; // unreachable code
}

function testUnreachableCodeWithTypeNarrowing5() {
    int|string x = 5;
    if x is int|string {

    } else {
        never _ = x; // unreachable code
    }
}

function testUnreachableCodeWithTypeNarrowing6() {
    int|string|float a = 10;
    if a is int {
        int _ = 10;
    } else if a is string {
        int _ = 20;
    } else if a is float {
        int _ = 30;
    } else if a is string {
        never _ = a; // unreachable code
    }
}

function testUnreachableCodeWithTypeNarrowing7() {
    int|string|float a = 10;
    if a is int {
        int _ = 10;
    } else if a is string {
        int _ = 20;
    } else if a is float {
        int _ = 30;
    } else if a is string {
        never _ = a;
    } else if a is float {
        never _ = a; // unreachable code
    }
}

function testUnreachableCodeWithTypeNarrowing8() {
    int|string|float a = 10;
    if a is int {
        int _ = 10;
    } else if a is string {
        int _ = 20;
    } else if a is float {
        int _ = 30;
    } else {
        never _ = a; // unreachable code
    }
}

public function testUnreachableCodeWithTypeNarrowing9() {
    int? a = 10;
    string b = "A";
    if b == "" || a == 0 {
        int? _ = a;
    } else if a is int || a is () {
        int? _ = a;
    } else if a is () {
        never _ = a; // unreachable code
    }
}

public function testUnreachableCodeWithTypeNarrowing10() {
    10|20 a = 10;
    if a == 10 || a == 20 {
        int _ = a;
    } else if a is 20 {
        never _ = a; // unreachable code
    }
}

public function testUnreachableCodeWithTypeNarrowing11() {
    10 a = 10;
    20 b = 20;
    if a == 10 && b == 20 {
        int _ = a;
    } else if a is 20 {
        never _ = a;
    }
}

public function testUnreachableCodeWithTypeNarrowing12() {
    10 a = 10;
    20 b = 20;
    if a == 10 && b == 20 {
        int _ = a;
    } else {
        never _ = a;
    }
}

public function testUnreachableCodeWithTypeNarrowing13() {
    10|20 a = 10;
    if a == 10 || a == 20 {
        int _ = a;
    } else {
        never _ = a; // unreachable code
    }
}

function testUnreachableCodeWithNonTerminatingLoop1() {
    int a = 10;
    while true {
        if a == 10 {
            return;
        }
    }
    foo(); // unreachable code
}

function testUnreachableCodeWithNonTerminatingLoop2() {
    int a = 10;
    while true {
        if a == 10 {
            continue;
        }
    }
    int _ = a; // unreachable code
}

function testReturnValueWithTerminatingLoop1() returns boolean? {
    int a = 10;
    while true {
        if a == 10 {
            break;
        }
    }
    int _ = a;
}

function testReturnValueWithTerminatingLoop2() returns boolean? {
    int a = 10;
    while true {
        if a == 10 {
            break;
        }
        return true;
    }
    int _ = a;
}

function testUnreachableStmt(any a) {
    while true {
        return;
    }
    match a { // unreachable code
        1 => {
        }
    }
}

function testUnreachableStatementInQueryAction() {
    error? n = from int i in 0 ... 2
    do {
        return;
        int _ = 1; // unreachable
    };

    _ = n is error; // reachable
}

function testUnreachableStatementInQueryAction2() returns error? {
    from var item in 1 ... 5
    where false
    do {
        int _ = 10; // unreachable code
    };
}

function testUnreachableStatementInQueryAction3() returns error? {
    checkpanic from var _ in new IterableWithError()
        where false
        do {
            int _ = 10; // unreachable code
        };
}

function testUnreachableStatementInQueryAction4() returns error? {
    error? a = from var item in 1 ... 5
        where false
        do {
            int _ = 10; // unreachable code
        };

    return a;
}

function testUnreachableStatementInQueryAction5() returns error? {
    error? a = trap from var item in 1 ... 5
        where false
        do {
            int _ = 10; // unreachable code
        };

    return a;
}

function testUnreachableStatementInQueryAction6() returns error? {
    error? a = <error?> from var item in 1 ... 5
        where false
        do {
            int _ = 10; // unreachable code
        };

    return a;
}

function testUnreachableStatementInQueryAction7() returns error? {
    return from var item in 1 ... 5
        where false
        do {
            int _ = 10; // unreachable code
        };
}

function testUnreachableStatementInQueryAction8() returns error? {
    checkpanic from var _ in new IterableWithError()
        where false
        do {
            int _ = 10; // unreachable code
        };
}

function testUnreachableStatementInQueryAction9() returns error? {
    return from var item in 1 ... 5
        where false
        do {
            int _ = 10; // unreachable code
        };
}

function testUnreachableStatementInQueryAction10() returns error? {
    return trap from var item in 1 ... 5
        where false
        do {
            int _ = 10; // unreachable code
        };
}

function testUnreachableStatementInQueryAction11() returns error? {
    return <error?> from var item in 1 ... 5
        where false
        do {
            int _ = 10; // unreachable code
        };
}

function testUnreachableStatementInQueryAction12() returns error? {
    error? a = (from var item in 1 ... 5
        where false
        do {
            int _ = 10; // unreachable code
        });

    return a;
}

function testUnreachableStatementInQueryAction13() returns error? {
    return (trap from var item in 1 ... 5
        where false
        do {
            int _ = 10; // unreachable code
        });
}

function testUnreachableStatementInQueryAction14() returns error? {
    error? a;
    a = (from var item in 1 ... 5
        where false
        do {
            int _ = 10; // unreachable code
        });

    return a;
}

function testUnreachableStatementInQueryAction15() {
    match from var item in 1 ... 5
        where false
        do {
            int _ = 10; // unreachable code
        } {
        () => {
        }
    }
}

function testUnreachableStatementInQueryAction16() returns error? {
    match from var item in 1 ... 5
        where false
        do {
            int _ = 10; // unreachable code
        } {
        () => {
        }
    }
}

function testUnreachableStatementInQueryAction17() {
    match (from var item in 1 ... 5
        where false
        do {
            int _ = 10; // unreachable code
        }) {
        () => {
        }
    }
}

function testUnreachableStatementInQueryAction18() returns error? {
    error? a = from var item in 1 ... 5
        where false
        where item < 2
        do {
            int _ = 10; // unreachable code
        };

    return a;
}

function testUnreachableStatementInQueryAction19() returns error? {
    return trap (from var item in 1 ... 5
        where false
        where item < 2
        do {
            int _ = 10; // unreachable code
        });
}

function testUnreachableStatementInQueryAction20() returns error? {
    error? a = ();
    from var item in 1 ... 5
    where item < 2
    do {
        a = (from var value in 1 ... 5
            where false
            where value < 2
            do {
                int _ = 10; // unreachable code
            });
    };

    return a;
}

function testUnreachableStatementInQueryAction21() returns error? {
    from var item in 1 ... 5
    where false
    do {
        int _ = 1; // unreachable code
    };
}

function testUnreachableTupleVarDef() {
    [int, string] arr = [1, "A"];
    while false {
        var [a, b] = arr; // unreachable code
    }
}

type Record record {|
    int a;
    string b;
|};

function testUnreachableRecordVarDef() {
    Record rec = {a: 1, b: "A"};
    while false {
        var {a: val1, b: val2} = rec; // unreachable code
    }
}

function testUnreachableStatementInQueryAction23() {
    error? x = from var item in 1 ... 5
        where false
        do {
            error? y = from var item2 in 1 ...2 // unreachable code
            where true
            do {
                int _ = 1;
                int _ = 1;
            };
        };
}

function testUnreachableStatementInQueryAction24() {
    error? x = from var item in 1 ... 5
        where true
        do {
            error? y = from var item2 in 1 ...2
            where false
            do {
                int _ = 1; // unreachable code
                int _ = 1;
            };
        };
}

function testLoggingExpectedUnreachableErrors1() {
    if true {
        return;
    } else if true {
        int _ = 10; // unreachable code
    }
}

function testLoggingExpectedUnreachableErrors2() returns error? {
    if true {
        fail error("fail msg");
    } else {
        int _ = 10; // unreachable code
    }
    int _ = 10;
}

function testLoggingExpectedUnreachableErrors3() returns error? {
    if true {
        return;
    } else {
        int _ = 10; // unreachable code
    }
    int _ = 10;
}

function testLoggingExpectedUnreachableErrors4() {
    if true {
        panic error("fail msg");
    } else {
        int _ = 10; // unreachable code
    }
    int _ = 10;
}

function testLoggingExpectedUnreachableErrors5() {
    while false {
        continue; // unreachable code
        int _ = 10;
        string _ = "A";
    }
}

function testLoggingExpectedUnreachableErrors6() {
    while false {
        return; // unreachable code
        int _ = 10;
        string _ = "A";
    }
}

function testLoggingExpectedUnreachableErrors7() returns error? {
    while true {
        fail error("fail msg");
    }
    string _ = "ballerina"; // unreachable code
    string _ = "ballerina";
}

function testLoggingExpectedUnreachableErrors8() {
    while true {
        panic error("fail msg");
    }
    string _ = "ballerina"; // unreachable code
    string _ = "ballerina";
}

function testLoggingExpectedUnreachableErrors9() {
    while true {
        return;
    }
    string _ = "ballerina"; // unreachable code
    string _ = "ballerina";
}

function testLoggingExpectedUnreachableErrors10() {
    int a = 10;
    string b = "A";
    if a is int {
        return;
    } else if b is string {
        int _ = 10; // unreachable code
    }
}

function testLoggingExpectedUnreachableErrors11() returns error? {
    int i = 0;
    while i > 10 {
        fail error("Error");
        i = i + 1; // unreachable code
    }
    i = 7; // unreachable code
    return;
}

function testLoggingExpectedUnreachableErrors12() returns error? {
    while true {
        fail error("Error");
        int _ = 10; // unreachable code
    }
    int _ = 10; // unreachable code
    return;
}

function testLoggingExpectedUnreachableErrors13() returns error? {
    while false {
        fail error("Error"); // unreachable code
        int _ = 10;
    }
    int _ = 10;
    return;
}

function testLoggingExpectedUnreachableErrors14() {
    int i = 0;
    while i > 10 {
        panic error("Error");
        i = i + 1; // unreachable code
    }
    return;
    i = 7; // unreachable code
}

function testLoggingExpectedUnreachableErrors15() {
    while true {
        panic error("Error");
        int _ = 10; // unreachable code
    }
    return; // unreachable code
    //int _ = 10;
}

function testLoggingExpectedUnreachableErrors16() {
    while false {
        panic error("Error");
        int _ = 10; // unreachable code
    }
    panic error("error");
    int _ = 10; // unreachable code
}

function testUnreachableStatementInQueryAction25() returns error? {
    from var item in 1 ... 5
    where true
    do {
        while true {
            int _ = 3;
        }
        int _ = 2; // unreachable code
    };
}

function testUnreachableStatementInQueryAction26() returns error? {
    string m;
    from var item in 1 ... 5
    where true
    do {
        m = "Error";
        while m is string {
            int _ = 3;
        }
        int _ = 2; // unreachable code
    };
}

function testUnreachableStatementInQueryAction27() returns error? {
    from var item in 1 ... 5
    where true
    do {
        if true {
            return;
        }
        int _ = 2; // unreachable code
    };
}

function testUnreachableStatementInQueryAction28() returns error? {
    from var item in 1 ... 5
    where false
    do {
        panic error("Panic!");
        int _ = 2; // unreachable code
    };
}

function testUnreachableStatementInQueryAction29() returns error? {
    from var item in 1 ... 5
    where true
    do {
        while true {
            int _ = 3;
        }
        panic error("Panic!");
        int _ = 2; // unreachable code
    };
}

function testUnreachableStatementInQueryAction30() returns error? {
    from var item in 1 ... 5
    where true
    do {
        if true {
            return;
        }
        panic error("Panic!");
        int _ = 2; // unreachable code
    };
}

function testUnreachabilityWithIfElseHavingUnreachablePanic(float? v) returns int {
    int y = 0;

    if v is () {
        return 1;
    } else if v is float {
        return 2;
    } else {
        panic error("err!");
    }

    return y; // unreachable code
}

function testUnreachabilityWithIfElseHavingUnreachablePanic2(float? v) returns int {
    int y = 0;

    if v is float? {
        return 1;
    } else {
        panic error("err!");
    }

    return y; // unreachable code
}

function testUnreachabilityWithIfElseHavingUnreachablePanic3(float? v) returns int|error {
    int y = 0;

    if v is () {
        fail error("Err");
    } else if v is float {
        return 1;
    } else {
        panic error("err!");
    }

    return y; // unreachable code
}

function testUnreachabilityWithIfElseHavingUnreachablePanic4(float? v) returns int {
    int y = 0;

    if v is () {
        panic error("Error");
    } else if v is float {
        return 1;
    } else {
        panic error("err!");
    }

    return y; // unreachable code
}

function testUnreachabilityWithIfElseHavingUnreachablePanic5(float? v) returns int {
    if v is () {
        return 1;
    } else if v is float {
        return 2;
    } else {
        string message = "err!"; // unreachable code
        panic error(message);
    }
}

function testVariableInitializationWithIfElseHavingUnreachablePanic(float? v) returns int {
    int y;

    if v is () {

    } else if v is float {
        y = 2;
    } else {
        panic error("err!");
    }

    return y; // variable 'y' may not have been initialized
}

function testUnreachabilityWithCombinationOfBreakAndContinue(float? v) {
    int y = 0;

    while y > 2 {
        if v is () {
            break;
        } else {
            continue;
        }
        int _ = 1; // unreachable code
    }

    int _ = 1; // Ok
}

function testUnreachabilityWithCombinationOfBreakAndContinue2(float? v) {
    int y = 0;

    while y > 2 {
        if v is () {
            return;
        } else {
            continue;
        }
        int _ = 1; // unreachable code
    }

    int _ = 1; // Ok
}

function testUnreachabilityWithCombinationOfBreakAndContinue3(float? v) {
    int y = 0;

    while y > 2 {
        if v is () {
            continue;
        } else {
            break;
        }
        int _ = 1; // unreachable code
    }

    int _ = 1; // Ok
}

function testUnreachabilityWithCombinationOfBreakAndContinue4(float? v) {
    int y = 0;

    while y > 2 {
        if v is () {
            return;
        } else {
            break;
        }
        int _ = 1; // unreachable code
    }

    int _ = 1; // Ok
}

function testUnreachabilityWithCombinationOfBreakAndContinue5(float? v) {
    int y = 0;

    while y > 2 {
        if v is () {
            break;
        } else {
            panic error("Err");
        }
        int _ = 1; // unreachable code
    }

    int _ = 1; // Ok
}

function testUnreachabilityWithCombinationOfBreakAndContinue6(float? v) {
    int y = 0;

    while y > 2 {
        if v is () {
            continue;
        } else {
            panic error("Err");
        }
        int _ = 1; // unreachable code
    }

    int _ = 1; // Ok
}

function testUnreachabilityWithCombinationOfBreakAndContinue7(float? v) {
    int y = 0;

    while y > 2 {
        foreach var i in 1...3 {
            if v is () {
                continue;
            } else {
                break;
            }
            int _ = 1; // unreachable code
        }

        int _ = 1; // Ok

        if v is () {
            continue;
        } else {
            panic error("Err");
        }
        int _ = 1; // unreachable code
    }

    int _ = 1; // Ok
}

function testUnreachabilityWithCombinationOfBreakAndContinue8() returns int {
    int|boolean v = true;
    while v is boolean {
        string? a = "A";
        if a is string {
            string|int b = "B";
            if b is string {
                if true {
                    return 1;
                }
            }

            if b is int { // always true
                break;
            }

            int _ = 1; // unreachable code
        } else {
            return 2;
        }
    }
    return 4;
}

function testUnreachabilityWithCombinationOfBreakAndContinue9() returns int {
    int|boolean v = true;
    while v is boolean {
        string? a = "A";
        if a is string {
            string|int b = "B";
            if b is string {
                return 1;
            } else if b is int {
                break;
            }
        } else {
            break;
        }
        int _ = 1; // unreachable code
    }
    return 4;
}

function testUnreachabilityWithCombinationOfBreakAndContinue10() returns int {
    int|boolean v = true;
    while v is boolean {
        string? a = "A";
        if a is string {
            string|int? b = "B";
            if b is string {
                return 1;
            } else if b is int {
                break;
            } else {
                continue;
            }
            int _ = 1; // unreachable code
        } else {
            string|int? c = "C";
            if c is string {
                return 1;
            } else if c is int {
                break;
            } else {
                continue;
            }
            int _ = 1; // unreachable code
        }
    }
    return 4;
}

class IterableWithError {
    *object:Iterable;
    public function iterator() returns object {

        public isolated function next() returns record {|int value;|}|error?;
    } {
        return object {
            public isolated function next() returns record {|int value;|}|error? {
               return error("Custom error thrown.");
            }
        };
    }
}
