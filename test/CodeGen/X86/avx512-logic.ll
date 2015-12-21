; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-apple-darwin -mcpu=knl | FileCheck %s --check-prefix=ALL --check-prefix=KNL
; RUN: llc < %s -mtriple=x86_64-apple-darwin -mcpu=skx | FileCheck %s --check-prefix=ALL --check-prefix=SKX


define <16 x i32> @vpandd(<16 x i32> %a, <16 x i32> %b) nounwind uwtable readnone ssp {
; ALL-LABEL: vpandd:
; ALL:       ## BB#0: ## %entry
; ALL-NEXT:    vpaddd {{.*}}(%rip){1to16}, %zmm0, %zmm0
; ALL-NEXT:    vpandd %zmm1, %zmm0, %zmm0
; ALL-NEXT:    retq
entry:
  ; Force the execution domain with an add.
  %a2 = add <16 x i32> %a, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1,
                            i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %x = and <16 x i32> %a2, %b
  ret <16 x i32> %x
}

define <16 x i32> @vpord(<16 x i32> %a, <16 x i32> %b) nounwind uwtable readnone ssp {
; ALL-LABEL: vpord:
; ALL:       ## BB#0: ## %entry
; ALL-NEXT:    vpaddd {{.*}}(%rip){1to16}, %zmm0, %zmm0
; ALL-NEXT:    vpord %zmm1, %zmm0, %zmm0
; ALL-NEXT:    retq
entry:
  ; Force the execution domain with an add.
  %a2 = add <16 x i32> %a, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1,
                            i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %x = or <16 x i32> %a2, %b
  ret <16 x i32> %x
}

define <16 x i32> @vpxord(<16 x i32> %a, <16 x i32> %b) nounwind uwtable readnone ssp {
; ALL-LABEL: vpxord:
; ALL:       ## BB#0: ## %entry
; ALL-NEXT:    vpaddd {{.*}}(%rip){1to16}, %zmm0, %zmm0
; ALL-NEXT:    vpxord %zmm1, %zmm0, %zmm0
; ALL-NEXT:    retq
entry:
  ; Force the execution domain with an add.
  %a2 = add <16 x i32> %a, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1,
                            i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %x = xor <16 x i32> %a2, %b
  ret <16 x i32> %x
}

define <8 x i64> @vpandq(<8 x i64> %a, <8 x i64> %b) nounwind uwtable readnone ssp {
; ALL-LABEL: vpandq:
; ALL:       ## BB#0: ## %entry
; ALL-NEXT:    vpaddq {{.*}}(%rip){1to8}, %zmm0, %zmm0
; ALL-NEXT:    vpandq %zmm1, %zmm0, %zmm0
; ALL-NEXT:    retq
entry:
  ; Force the execution domain with an add.
  %a2 = add <8 x i64> %a, <i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1>
  %x = and <8 x i64> %a2, %b
  ret <8 x i64> %x
}

define <8 x i64> @vporq(<8 x i64> %a, <8 x i64> %b) nounwind uwtable readnone ssp {
; ALL-LABEL: vporq:
; ALL:       ## BB#0: ## %entry
; ALL-NEXT:    vpaddq {{.*}}(%rip){1to8}, %zmm0, %zmm0
; ALL-NEXT:    vporq %zmm1, %zmm0, %zmm0
; ALL-NEXT:    retq
entry:
  ; Force the execution domain with an add.
  %a2 = add <8 x i64> %a, <i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1>
  %x = or <8 x i64> %a2, %b
  ret <8 x i64> %x
}

define <8 x i64> @vpxorq(<8 x i64> %a, <8 x i64> %b) nounwind uwtable readnone ssp {
; ALL-LABEL: vpxorq:
; ALL:       ## BB#0: ## %entry
; ALL-NEXT:    vpaddq {{.*}}(%rip){1to8}, %zmm0, %zmm0
; ALL-NEXT:    vpxorq %zmm1, %zmm0, %zmm0
; ALL-NEXT:    retq
entry:
  ; Force the execution domain with an add.
  %a2 = add <8 x i64> %a, <i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1>
  %x = xor <8 x i64> %a2, %b
  ret <8 x i64> %x
}


define <8 x i64> @orq_broadcast(<8 x i64> %a) nounwind {
; ALL-LABEL: orq_broadcast:
; ALL:       ## BB#0:
; ALL-NEXT:    vporq {{.*}}(%rip){1to8}, %zmm0, %zmm0
; ALL-NEXT:    retq
  %b = or <8 x i64> %a, <i64 2, i64 2, i64 2, i64 2, i64 2, i64 2, i64 2, i64 2>
  ret <8 x i64> %b
}

define <16 x i32> @andd512fold(<16 x i32> %y, <16 x i32>* %x) {
; ALL-LABEL: andd512fold:
; ALL:       ## BB#0: ## %entry
; ALL-NEXT:    vpandd (%rdi), %zmm0, %zmm0
; ALL-NEXT:    retq
entry:
  %a = load <16 x i32>, <16 x i32>* %x, align 4
  %b = and <16 x i32> %y, %a
  ret <16 x i32> %b
}

define <8 x i64> @andqbrst(<8 x i64> %p1, i64* %ap) {
; ALL-LABEL: andqbrst:
; ALL:       ## BB#0: ## %entry
; ALL-NEXT:    vpandq (%rdi){1to8}, %zmm0, %zmm0
; ALL-NEXT:    retq
entry:
  %a = load i64, i64* %ap, align 8
  %b = insertelement <8 x i64> undef, i64 %a, i32 0
  %c = shufflevector <8 x i64> %b, <8 x i64> undef, <8 x i32> zeroinitializer
  %d = and <8 x i64> %p1, %c
  ret <8 x i64>%d
}

define <64 x i8> @and_v64i8(<64 x i8> %a, <64 x i8> %b) {
; KNL-LABEL: and_v64i8:
; KNL:       ## BB#0:
; KNL-NEXT:    vandps %ymm2, %ymm0, %ymm0
; KNL-NEXT:    vandps %ymm3, %ymm1, %ymm1
; KNL-NEXT:    retq
;
; SKX-LABEL: and_v64i8:
; SKX:       ## BB#0:
; SKX-NEXT:    vpandq %zmm1, %zmm0, %zmm0
; SKX-NEXT:    retq
  %res = and <64 x i8> %a, %b
  ret <64 x i8> %res
}

define <64 x i8> @or_v64i8(<64 x i8> %a, <64 x i8> %b) {
; KNL-LABEL: or_v64i8:
; KNL:       ## BB#0:
; KNL-NEXT:    vorps %ymm2, %ymm0, %ymm0
; KNL-NEXT:    vorps %ymm3, %ymm1, %ymm1
; KNL-NEXT:    retq
;
; SKX-LABEL: or_v64i8:
; SKX:       ## BB#0:
; SKX-NEXT:    vporq %zmm1, %zmm0, %zmm0
; SKX-NEXT:    retq
  %res = or <64 x i8> %a, %b
  ret <64 x i8> %res
}

define <64 x i8> @xor_v64i8(<64 x i8> %a, <64 x i8> %b) {
; KNL-LABEL: xor_v64i8:
; KNL:       ## BB#0:
; KNL-NEXT:    vxorps %ymm2, %ymm0, %ymm0
; KNL-NEXT:    vxorps %ymm3, %ymm1, %ymm1
; KNL-NEXT:    retq
;
; SKX-LABEL: xor_v64i8:
; SKX:       ## BB#0:
; SKX-NEXT:    vpxorq %zmm1, %zmm0, %zmm0
; SKX-NEXT:    retq
  %res = xor <64 x i8> %a, %b
  ret <64 x i8> %res
}

define <32 x i16> @and_v32i16(<32 x i16> %a, <32 x i16> %b) {
; KNL-LABEL: and_v32i16:
; KNL:       ## BB#0:
; KNL-NEXT:    vandps %ymm2, %ymm0, %ymm0
; KNL-NEXT:    vandps %ymm3, %ymm1, %ymm1
; KNL-NEXT:    retq
;
; SKX-LABEL: and_v32i16:
; SKX:       ## BB#0:
; SKX-NEXT:    vpandq %zmm1, %zmm0, %zmm0
; SKX-NEXT:    retq
  %res = and <32 x i16> %a, %b
  ret <32 x i16> %res
}

define <32 x i16> @or_v32i16(<32 x i16> %a, <32 x i16> %b) {
; KNL-LABEL: or_v32i16:
; KNL:       ## BB#0:
; KNL-NEXT:    vorps %ymm2, %ymm0, %ymm0
; KNL-NEXT:    vorps %ymm3, %ymm1, %ymm1
; KNL-NEXT:    retq
;
; SKX-LABEL: or_v32i16:
; SKX:       ## BB#0:
; SKX-NEXT:    vporq %zmm1, %zmm0, %zmm0
; SKX-NEXT:    retq
  %res = or <32 x i16> %a, %b
  ret <32 x i16> %res
}

define <32 x i16> @xor_v32i16(<32 x i16> %a, <32 x i16> %b) {
; KNL-LABEL: xor_v32i16:
; KNL:       ## BB#0:
; KNL-NEXT:    vxorps %ymm2, %ymm0, %ymm0
; KNL-NEXT:    vxorps %ymm3, %ymm1, %ymm1
; KNL-NEXT:    retq
;
; SKX-LABEL: xor_v32i16:
; SKX:       ## BB#0:
; SKX-NEXT:    vpxorq %zmm1, %zmm0, %zmm0
; SKX-NEXT:    retq
  %res = xor <32 x i16> %a, %b
  ret <32 x i16> %res
}
