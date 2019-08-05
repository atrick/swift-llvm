//===- llvm/unittest/ADT/PointerUnionTest.cpp - Optional unit tests -------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include "llvm/ADT/PointerUnion.h"
#include "gtest/gtest.h"
using namespace llvm;

namespace {

typedef PointerUnion<int *, float *> PU;
typedef PointerUnion3<int *, float *, long long *> PU3;
typedef PointerUnion4<int *, float *, long long *, double *> PU4;

struct PointerUnionTest : public testing::Test {
  float f;
  int i;
  double d;
  long long l;

  PU a, b, c, n;
  PU3 i3, f3, l3;
  PU4 i4, f4, l4, d4;
  PU4 i4null, f4null, l4null, d4null;

  PointerUnion<PU *, PU> nestedPU, nestedDefault, nestedPtrPU;

  PointerUnionTest() : f(3.14f), i(42), d(3.14), l(42),
                       a(&f), b(&i), c(&i), n(),
                       i3(&i), f3(&f), l3(&l),
                       i4(&i), f4(&f), l4(&l), d4(&d),
                       i4null((int *)nullptr), f4null((float *)nullptr),
                       l4null((long long *) nullptr),
                       d4null((double *)nullptr),
                       nestedPU(a), nestedDefault(), nestedPtrPU(&a)
  {}
};

TEST_F(PointerUnionTest, Comparison) {
  EXPECT_TRUE(a == a);
  EXPECT_FALSE(a != a);
  EXPECT_TRUE(a != b);
  EXPECT_FALSE(a == b);
  EXPECT_TRUE(b == c);
  EXPECT_FALSE(b != c);
  EXPECT_TRUE(b != n);
  EXPECT_FALSE(b == n);
  EXPECT_TRUE(i3 == i3);
  EXPECT_FALSE(i3 != i3);
  EXPECT_TRUE(i3 != f3);
  EXPECT_TRUE(f3 != l3);
  EXPECT_TRUE(i4 == i4);
  EXPECT_FALSE(i4 != i4);
  EXPECT_TRUE(i4 != f4);
  EXPECT_TRUE(i4 != l4);
  EXPECT_TRUE(f4 != l4);
  EXPECT_TRUE(l4 != d4);
  EXPECT_TRUE(i4null != f4null);
  EXPECT_TRUE(i4null != l4null);
  EXPECT_TRUE(i4null != d4null);
  EXPECT_TRUE(nestedPU == nestedPU);
  EXPECT_TRUE(nestedPU != nestedDefault);
  EXPECT_TRUE(nestedPU.get<PU>() == a);
}

TEST_F(PointerUnionTest, Null) {
  EXPECT_FALSE(a.isNull());
  EXPECT_FALSE(b.isNull());
  EXPECT_TRUE(n.isNull());
  EXPECT_FALSE(!a);
  EXPECT_FALSE(!b);
  EXPECT_TRUE(!n);
  // workaround an issue with EXPECT macros and explicit bool
  EXPECT_TRUE((bool)a);
  EXPECT_TRUE((bool)b);
  EXPECT_FALSE(n);

  EXPECT_NE(n, b);
  EXPECT_EQ(b, c);
  b = nullptr;
  EXPECT_EQ(n, b);
  EXPECT_NE(b, c);
  EXPECT_FALSE(i3.isNull());
  EXPECT_FALSE(f3.isNull());
  EXPECT_FALSE(l3.isNull());
  EXPECT_FALSE(i4.isNull());
  EXPECT_FALSE(f4.isNull());
  EXPECT_FALSE(l4.isNull());
  EXPECT_FALSE(d4.isNull());
  EXPECT_TRUE(i4null.isNull());
  EXPECT_TRUE(f4null.isNull());
  EXPECT_TRUE(l4null.isNull());
  EXPECT_TRUE(d4null.isNull());
  EXPECT_TRUE(nestedPU);
  EXPECT_TRUE(!nestedDefault);
  EXPECT_TRUE(!nestedDefault);
}

TEST_F(PointerUnionTest, Is) {
  EXPECT_FALSE(a.is<int *>());
  EXPECT_TRUE(a.is<float *>());
  EXPECT_TRUE(b.is<int *>());
  EXPECT_FALSE(b.is<float *>());
  EXPECT_TRUE(n.is<int *>());
  EXPECT_FALSE(n.is<float *>());
  EXPECT_TRUE(i3.is<int *>());
  EXPECT_TRUE(f3.is<float *>());
  EXPECT_TRUE(l3.is<long long *>());
  EXPECT_TRUE(i4.is<int *>());
  EXPECT_TRUE(f4.is<float *>());
  EXPECT_TRUE(l4.is<long long *>());
  EXPECT_TRUE(d4.is<double *>());
  EXPECT_TRUE(i4null.is<int *>());
  EXPECT_TRUE(f4null.is<float *>());
  EXPECT_TRUE(l4null.is<long long *>());
  EXPECT_TRUE(d4null.is<double *>());
  EXPECT_TRUE(nestedPU.is<PU>());
  EXPECT_FALSE(nestedPU.is<PU *>());
  EXPECT_TRUE(nestedDefault.is<PU *>());
  EXPECT_FALSE(nestedDefault.is<PU>());
  EXPECT_FALSE(nestedPtrPU.is<PU>());
  EXPECT_TRUE(nestedPtrPU.is<PU *>());
}

TEST_F(PointerUnionTest, Get) {
  EXPECT_EQ(a.get<float *>(), &f);
  EXPECT_EQ(b.get<int *>(), &i);
  EXPECT_EQ(n.get<int *>(), (int *)nullptr);
}

TEST_F(PointerUnionTest, GetAddrOfPtr1) {
  EXPECT_TRUE((void *)b.getAddrOfPtr1() == (void *)&b);
  EXPECT_TRUE((void *)n.getAddrOfPtr1() == (void *)&n);
  EXPECT_TRUE((void *)nestedDefault.getAddrOfPtr1() == (void *)&nestedDefault);
  EXPECT_TRUE((void *)nestedPtrPU.getAddrOfPtr1() == (void *)&nestedPtrPU);
}

} // end anonymous namespace
