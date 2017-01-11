; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-apple-darwin -mattr=+avx512f | FileCheck %s --check-prefix=ALL --check-prefix=KNL
; RUN: llc < %s -mtriple=x86_64-apple-darwin -mattr=+avx512f -mattr=+avx512vl -mattr=+avx512bw -mattr=+avx512dq | FileCheck %s --check-prefix=ALL --check-prefix=SKX

 attributes #0 = { nounwind }

define <16 x i8> @trunc_16x32_to_16x8(<16 x i32> %i) #0 {
; ALL-LABEL: trunc_16x32_to_16x8:
; ALL:       ## BB#0:
; ALL-NEXT:    vpmovdb %zmm0, %xmm0
; ALL-NEXT:    retq
  %x = trunc <16 x i32> %i to <16 x i8>
  ret <16 x i8> %x
}

define <8 x i16> @trunc_8x64_to_8x16(<8 x i64> %i) #0 {
; ALL-LABEL: trunc_8x64_to_8x16:
; ALL:       ## BB#0:
; ALL-NEXT:    vpmovqw %zmm0, %xmm0
; ALL-NEXT:    retq
  %x = trunc <8 x i64> %i to <8 x i16>
  ret <8 x i16> %x
}

define <16 x i16> @trunc_v16i32_to_v16i16(<16 x i32> %x) #0 {
; ALL-LABEL: trunc_v16i32_to_v16i16:
; ALL:       ## BB#0:
; ALL-NEXT:    vpmovdw %zmm0, %ymm0
; ALL-NEXT:    retq
  %1 = trunc <16 x i32> %x to <16 x i16>
  ret <16 x i16> %1
}

define <8 x i8> @trunc_qb_512(<8 x i64> %i) #0 {
; ALL-LABEL: trunc_qb_512:
; ALL:       ## BB#0:
; ALL-NEXT:    vpmovqw %zmm0, %xmm0
; ALL-NEXT:    retq
  %x = trunc <8 x i64> %i to <8 x i8>
  ret <8 x i8> %x
}

define void @trunc_qb_512_mem(<8 x i64> %i, <8 x i8>* %res) #0 {
; ALL-LABEL: trunc_qb_512_mem:
; ALL:       ## BB#0:
; ALL-NEXT:    vpmovqb %zmm0, (%rdi)
; ALL-NEXT:    retq
    %x = trunc <8 x i64> %i to <8 x i8>
    store <8 x i8> %x, <8 x i8>* %res
    ret void
}

define <4 x i8> @trunc_qb_256(<4 x i64> %i) #0 {
; KNL-LABEL: trunc_qb_256:
; KNL:       ## BB#0:
; KNL-NEXT:    ## kill: %YMM0<def> %YMM0<kill> %ZMM0<def>
; KNL-NEXT:    vpmovqd %zmm0, %ymm0
; KNL-NEXT:    ## kill: %XMM0<def> %XMM0<kill> %YMM0<kill>
; KNL-NEXT:    retq
;
; SKX-LABEL: trunc_qb_256:
; SKX:       ## BB#0:
; SKX-NEXT:    vpmovqd %ymm0, %xmm0
; SKX-NEXT:    retq
  %x = trunc <4 x i64> %i to <4 x i8>
  ret <4 x i8> %x
}

define void @trunc_qb_256_mem(<4 x i64> %i, <4 x i8>* %res) #0 {
; KNL-LABEL: trunc_qb_256_mem:
; KNL:       ## BB#0:
; KNL-NEXT:    ## kill: %YMM0<def> %YMM0<kill> %ZMM0<def>
; KNL-NEXT:    vpmovqd %zmm0, %ymm0
; KNL-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u]
; KNL-NEXT:    vmovd %xmm0, (%rdi)
; KNL-NEXT:    retq
;
; SKX-LABEL: trunc_qb_256_mem:
; SKX:       ## BB#0:
; SKX-NEXT:    vpmovqb %ymm0, (%rdi)
; SKX-NEXT:    retq
    %x = trunc <4 x i64> %i to <4 x i8>
    store <4 x i8> %x, <4 x i8>* %res
    ret void
}

define <2 x i8> @trunc_qb_128(<2 x i64> %i) #0 {
; ALL-LABEL: trunc_qb_128:
; ALL:       ## BB#0:
; ALL-NEXT:    retq
  %x = trunc <2 x i64> %i to <2 x i8>
  ret <2 x i8> %x
}

define void @trunc_qb_128_mem(<2 x i64> %i, <2 x i8>* %res) #0 {
; KNL-LABEL: trunc_qb_128_mem:
; KNL:       ## BB#0:
; KNL-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,8,u,u,u,u,u,u,u,u,u,u,u,u,u,u]
; KNL-NEXT:    vpextrw $0, %xmm0, (%rdi)
; KNL-NEXT:    retq
;
; SKX-LABEL: trunc_qb_128_mem:
; SKX:       ## BB#0:
; SKX-NEXT:    vpmovqb %xmm0, (%rdi)
; SKX-NEXT:    retq
    %x = trunc <2 x i64> %i to <2 x i8>
    store <2 x i8> %x, <2 x i8>* %res
    ret void
}

define <8 x i16> @trunc_qw_512(<8 x i64> %i) #0 {
; ALL-LABEL: trunc_qw_512:
; ALL:       ## BB#0:
; ALL-NEXT:    vpmovqw %zmm0, %xmm0
; ALL-NEXT:    retq
  %x = trunc <8 x i64> %i to <8 x i16>
  ret <8 x i16> %x
}

define void @trunc_qw_512_mem(<8 x i64> %i, <8 x i16>* %res) #0 {
; ALL-LABEL: trunc_qw_512_mem:
; ALL:       ## BB#0:
; ALL-NEXT:    vpmovqw %zmm0, (%rdi)
; ALL-NEXT:    retq
    %x = trunc <8 x i64> %i to <8 x i16>
    store <8 x i16> %x, <8 x i16>* %res
    ret void
}

define <4 x i16> @trunc_qw_256(<4 x i64> %i) #0 {
; KNL-LABEL: trunc_qw_256:
; KNL:       ## BB#0:
; KNL-NEXT:    ## kill: %YMM0<def> %YMM0<kill> %ZMM0<def>
; KNL-NEXT:    vpmovqd %zmm0, %ymm0
; KNL-NEXT:    ## kill: %XMM0<def> %XMM0<kill> %YMM0<kill>
; KNL-NEXT:    retq
;
; SKX-LABEL: trunc_qw_256:
; SKX:       ## BB#0:
; SKX-NEXT:    vpmovqd %ymm0, %xmm0
; SKX-NEXT:    retq
  %x = trunc <4 x i64> %i to <4 x i16>
  ret <4 x i16> %x
}

define void @trunc_qw_256_mem(<4 x i64> %i, <4 x i16>* %res) #0 {
; KNL-LABEL: trunc_qw_256_mem:
; KNL:       ## BB#0:
; KNL-NEXT:    ## kill: %YMM0<def> %YMM0<kill> %ZMM0<def>
; KNL-NEXT:    vpmovqd %zmm0, %ymm0
; KNL-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,1,4,5,8,9,12,13,8,9,12,13,12,13,14,15]
; KNL-NEXT:    vmovq %xmm0, (%rdi)
; KNL-NEXT:    retq
;
; SKX-LABEL: trunc_qw_256_mem:
; SKX:       ## BB#0:
; SKX-NEXT:    vpmovqw %ymm0, (%rdi)
; SKX-NEXT:    retq
    %x = trunc <4 x i64> %i to <4 x i16>
    store <4 x i16> %x, <4 x i16>* %res
    ret void
}

define <2 x i16> @trunc_qw_128(<2 x i64> %i) #0 {
; ALL-LABEL: trunc_qw_128:
; ALL:       ## BB#0:
; ALL-NEXT:    retq
  %x = trunc <2 x i64> %i to <2 x i16>
  ret <2 x i16> %x
}

define void @trunc_qw_128_mem(<2 x i64> %i, <2 x i16>* %res) #0 {
; KNL-LABEL: trunc_qw_128_mem:
; KNL:       ## BB#0:
; KNL-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; KNL-NEXT:    vpshuflw {{.*#+}} xmm0 = xmm0[0,2,2,3,4,5,6,7]
; KNL-NEXT:    vmovd %xmm0, (%rdi)
; KNL-NEXT:    retq
;
; SKX-LABEL: trunc_qw_128_mem:
; SKX:       ## BB#0:
; SKX-NEXT:    vpmovqw %xmm0, (%rdi)
; SKX-NEXT:    retq
    %x = trunc <2 x i64> %i to <2 x i16>
    store <2 x i16> %x, <2 x i16>* %res
    ret void
}

define <8 x i32> @trunc_qd_512(<8 x i64> %i) #0 {
; ALL-LABEL: trunc_qd_512:
; ALL:       ## BB#0:
; ALL-NEXT:    vpmovqd %zmm0, %ymm0
; ALL-NEXT:    retq
  %x = trunc <8 x i64> %i to <8 x i32>
  ret <8 x i32> %x
}

define void @trunc_qd_512_mem(<8 x i64> %i, <8 x i32>* %res) #0 {
; ALL-LABEL: trunc_qd_512_mem:
; ALL:       ## BB#0:
; ALL-NEXT:    vpmovqd %zmm0, (%rdi)
; ALL-NEXT:    retq
    %x = trunc <8 x i64> %i to <8 x i32>
    store <8 x i32> %x, <8 x i32>* %res
    ret void
}

define <4 x i32> @trunc_qd_256(<4 x i64> %i) #0 {
; KNL-LABEL: trunc_qd_256:
; KNL:       ## BB#0:
; KNL-NEXT:    ## kill: %YMM0<def> %YMM0<kill> %ZMM0<def>
; KNL-NEXT:    vpmovqd %zmm0, %ymm0
; KNL-NEXT:    ## kill: %XMM0<def> %XMM0<kill> %YMM0<kill>
; KNL-NEXT:    retq
;
; SKX-LABEL: trunc_qd_256:
; SKX:       ## BB#0:
; SKX-NEXT:    vpmovqd %ymm0, %xmm0
; SKX-NEXT:    retq
  %x = trunc <4 x i64> %i to <4 x i32>
  ret <4 x i32> %x
}

define void @trunc_qd_256_mem(<4 x i64> %i, <4 x i32>* %res) #0 {
; KNL-LABEL: trunc_qd_256_mem:
; KNL:       ## BB#0:
; KNL-NEXT:    ## kill: %YMM0<def> %YMM0<kill> %ZMM0<def>
; KNL-NEXT:    vpmovqd %zmm0, %ymm0
; KNL-NEXT:    vmovdqa %xmm0, (%rdi)
; KNL-NEXT:    retq
;
; SKX-LABEL: trunc_qd_256_mem:
; SKX:       ## BB#0:
; SKX-NEXT:    vpmovqd %ymm0, (%rdi)
; SKX-NEXT:    retq
    %x = trunc <4 x i64> %i to <4 x i32>
    store <4 x i32> %x, <4 x i32>* %res
    ret void
}

define <2 x i32> @trunc_qd_128(<2 x i64> %i) #0 {
; ALL-LABEL: trunc_qd_128:
; ALL:       ## BB#0:
; ALL-NEXT:    retq
  %x = trunc <2 x i64> %i to <2 x i32>
  ret <2 x i32> %x
}

define void @trunc_qd_128_mem(<2 x i64> %i, <2 x i32>* %res) #0 {
; KNL-LABEL: trunc_qd_128_mem:
; KNL:       ## BB#0:
; KNL-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; KNL-NEXT:    vmovq %xmm0, (%rdi)
; KNL-NEXT:    retq
;
; SKX-LABEL: trunc_qd_128_mem:
; SKX:       ## BB#0:
; SKX-NEXT:    vpmovqd %xmm0, (%rdi)
; SKX-NEXT:    retq
    %x = trunc <2 x i64> %i to <2 x i32>
    store <2 x i32> %x, <2 x i32>* %res
    ret void
}

define <16 x i8> @trunc_db_512(<16 x i32> %i) #0 {
; ALL-LABEL: trunc_db_512:
; ALL:       ## BB#0:
; ALL-NEXT:    vpmovdb %zmm0, %xmm0
; ALL-NEXT:    retq
  %x = trunc <16 x i32> %i to <16 x i8>
  ret <16 x i8> %x
}

define void @trunc_db_512_mem(<16 x i32> %i, <16 x i8>* %res) #0 {
; ALL-LABEL: trunc_db_512_mem:
; ALL:       ## BB#0:
; ALL-NEXT:    vpmovdb %zmm0, (%rdi)
; ALL-NEXT:    retq
    %x = trunc <16 x i32> %i to <16 x i8>
    store <16 x i8> %x, <16 x i8>* %res
    ret void
}

define <8 x i8> @trunc_db_256(<8 x i32> %i) #0 {
; KNL-LABEL: trunc_db_256:
; KNL:       ## BB#0:
; KNL-NEXT:    ## kill: %YMM0<def> %YMM0<kill> %ZMM0<def>
; KNL-NEXT:    vpmovdw %zmm0, %ymm0
; KNL-NEXT:    ## kill: %XMM0<def> %XMM0<kill> %YMM0<kill>
; KNL-NEXT:    retq
;
; SKX-LABEL: trunc_db_256:
; SKX:       ## BB#0:
; SKX-NEXT:    vpmovdw %ymm0, %xmm0
; SKX-NEXT:    retq
  %x = trunc <8 x i32> %i to <8 x i8>
  ret <8 x i8> %x
}

define void @trunc_db_256_mem(<8 x i32> %i, <8 x i8>* %res) #0 {
; KNL-LABEL: trunc_db_256_mem:
; KNL:       ## BB#0:
; KNL-NEXT:    ## kill: %YMM0<def> %YMM0<kill> %ZMM0<def>
; KNL-NEXT:    vpmovdw %zmm0, %ymm0
; KNL-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,2,4,6,8,10,12,14,u,u,u,u,u,u,u,u]
; KNL-NEXT:    vmovq %xmm0, (%rdi)
; KNL-NEXT:    retq
;
; SKX-LABEL: trunc_db_256_mem:
; SKX:       ## BB#0:
; SKX-NEXT:    vpmovdb %ymm0, (%rdi)
; SKX-NEXT:    retq
    %x = trunc <8 x i32> %i to <8 x i8>
    store <8 x i8> %x, <8 x i8>* %res
    ret void
}

define <4 x i8> @trunc_db_128(<4 x i32> %i) #0 {
; ALL-LABEL: trunc_db_128:
; ALL:       ## BB#0:
; ALL-NEXT:    retq
  %x = trunc <4 x i32> %i to <4 x i8>
  ret <4 x i8> %x
}

define void @trunc_db_128_mem(<4 x i32> %i, <4 x i8>* %res) #0 {
; KNL-LABEL: trunc_db_128_mem:
; KNL:       ## BB#0:
; KNL-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u]
; KNL-NEXT:    vmovd %xmm0, (%rdi)
; KNL-NEXT:    retq
;
; SKX-LABEL: trunc_db_128_mem:
; SKX:       ## BB#0:
; SKX-NEXT:    vpmovdb %xmm0, (%rdi)
; SKX-NEXT:    retq
    %x = trunc <4 x i32> %i to <4 x i8>
    store <4 x i8> %x, <4 x i8>* %res
    ret void
}

define <16 x i16> @trunc_dw_512(<16 x i32> %i) #0 {
; ALL-LABEL: trunc_dw_512:
; ALL:       ## BB#0:
; ALL-NEXT:    vpmovdw %zmm0, %ymm0
; ALL-NEXT:    retq
  %x = trunc <16 x i32> %i to <16 x i16>
  ret <16 x i16> %x
}

define void @trunc_dw_512_mem(<16 x i32> %i, <16 x i16>* %res) #0 {
; ALL-LABEL: trunc_dw_512_mem:
; ALL:       ## BB#0:
; ALL-NEXT:    vpmovdw %zmm0, (%rdi)
; ALL-NEXT:    retq
    %x = trunc <16 x i32> %i to <16 x i16>
    store <16 x i16> %x, <16 x i16>* %res
    ret void
}

define <8 x i16> @trunc_dw_256(<8 x i32> %i) #0 {
; KNL-LABEL: trunc_dw_256:
; KNL:       ## BB#0:
; KNL-NEXT:    ## kill: %YMM0<def> %YMM0<kill> %ZMM0<def>
; KNL-NEXT:    vpmovdw %zmm0, %ymm0
; KNL-NEXT:    ## kill: %XMM0<def> %XMM0<kill> %YMM0<kill>
; KNL-NEXT:    retq
;
; SKX-LABEL: trunc_dw_256:
; SKX:       ## BB#0:
; SKX-NEXT:    vpmovdw %ymm0, %xmm0
; SKX-NEXT:    retq
  %x = trunc <8 x i32> %i to <8 x i16>
  ret <8 x i16> %x
}

define void @trunc_dw_256_mem(<8 x i32> %i, <8 x i16>* %res) #0 {
; KNL-LABEL: trunc_dw_256_mem:
; KNL:       ## BB#0:
; KNL-NEXT:    ## kill: %YMM0<def> %YMM0<kill> %ZMM0<def>
; KNL-NEXT:    vpmovdw %zmm0, %ymm0
; KNL-NEXT:    vmovdqa %xmm0, (%rdi)
; KNL-NEXT:    retq
;
; SKX-LABEL: trunc_dw_256_mem:
; SKX:       ## BB#0:
; SKX-NEXT:    vpmovdw %ymm0, (%rdi)
; SKX-NEXT:    retq
    %x = trunc <8 x i32> %i to <8 x i16>
    store <8 x i16> %x, <8 x i16>* %res
    ret void
}

define void @trunc_dw_128_mem(<4 x i32> %i, <4 x i16>* %res) #0 {
; KNL-LABEL: trunc_dw_128_mem:
; KNL:       ## BB#0:
; KNL-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,1,4,5,8,9,12,13,8,9,12,13,12,13,14,15]
; KNL-NEXT:    vmovq %xmm0, (%rdi)
; KNL-NEXT:    retq
;
; SKX-LABEL: trunc_dw_128_mem:
; SKX:       ## BB#0:
; SKX-NEXT:    vpmovdw %xmm0, (%rdi)
; SKX-NEXT:    retq
    %x = trunc <4 x i32> %i to <4 x i16>
    store <4 x i16> %x, <4 x i16>* %res
    ret void
}

define <32 x i8> @trunc_wb_512(<32 x i16> %i) #0 {
; KNL-LABEL: trunc_wb_512:
; KNL:       ## BB#0:
; KNL-NEXT:    vpmovsxwd %ymm0, %zmm0
; KNL-NEXT:    vpmovdb %zmm0, %xmm0
; KNL-NEXT:    vpmovsxwd %ymm1, %zmm1
; KNL-NEXT:    vpmovdb %zmm1, %xmm1
; KNL-NEXT:    vinserti128 $1, %xmm1, %ymm0, %ymm0
; KNL-NEXT:    retq
;
; SKX-LABEL: trunc_wb_512:
; SKX:       ## BB#0:
; SKX-NEXT:    vpmovwb %zmm0, %ymm0
; SKX-NEXT:    retq
  %x = trunc <32 x i16> %i to <32 x i8>
  ret <32 x i8> %x
}

define void @trunc_wb_512_mem(<32 x i16> %i, <32 x i8>* %res) #0 {
; KNL-LABEL: trunc_wb_512_mem:
; KNL:       ## BB#0:
; KNL-NEXT:    vpmovsxwd %ymm0, %zmm0
; KNL-NEXT:    vpmovdb %zmm0, %xmm0
; KNL-NEXT:    vpmovsxwd %ymm1, %zmm1
; KNL-NEXT:    vpmovdb %zmm1, %xmm1
; KNL-NEXT:    vinserti128 $1, %xmm1, %ymm0, %ymm0
; KNL-NEXT:    vmovdqa %ymm0, (%rdi)
; KNL-NEXT:    retq
;
; SKX-LABEL: trunc_wb_512_mem:
; SKX:       ## BB#0:
; SKX-NEXT:    vpmovwb %zmm0, (%rdi)
; SKX-NEXT:    retq
    %x = trunc <32 x i16> %i to <32 x i8>
    store <32 x i8> %x, <32 x i8>* %res
    ret void
}

define <16 x i8> @trunc_wb_256(<16 x i16> %i) #0 {
; KNL-LABEL: trunc_wb_256:
; KNL:       ## BB#0:
; KNL-NEXT:    vpmovsxwd %ymm0, %zmm0
; KNL-NEXT:    vpmovdb %zmm0, %xmm0
; KNL-NEXT:    retq
;
; SKX-LABEL: trunc_wb_256:
; SKX:       ## BB#0:
; SKX-NEXT:    vpmovwb %ymm0, %xmm0
; SKX-NEXT:    retq
  %x = trunc <16 x i16> %i to <16 x i8>
  ret <16 x i8> %x
}

define void @trunc_wb_256_mem(<16 x i16> %i, <16 x i8>* %res) #0 {
; KNL-LABEL: trunc_wb_256_mem:
; KNL:       ## BB#0:
; KNL-NEXT:    vpmovsxwd %ymm0, %zmm0
; KNL-NEXT:    vpmovdb %zmm0, %xmm0
; KNL-NEXT:    vmovdqa %xmm0, (%rdi)
; KNL-NEXT:    retq
;
; SKX-LABEL: trunc_wb_256_mem:
; SKX:       ## BB#0:
; SKX-NEXT:    vpmovwb %ymm0, (%rdi)
; SKX-NEXT:    retq
    %x = trunc <16 x i16> %i to <16 x i8>
    store <16 x i8> %x, <16 x i8>* %res
    ret void
}

define <8 x i8> @trunc_wb_128(<8 x i16> %i) #0 {
; ALL-LABEL: trunc_wb_128:
; ALL:       ## BB#0:
; ALL-NEXT:    retq
  %x = trunc <8 x i16> %i to <8 x i8>
  ret <8 x i8> %x
}

define void @trunc_wb_128_mem(<8 x i16> %i, <8 x i8>* %res) #0 {
; KNL-LABEL: trunc_wb_128_mem:
; KNL:       ## BB#0:
; KNL-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,2,4,6,8,10,12,14,u,u,u,u,u,u,u,u]
; KNL-NEXT:    vmovq %xmm0, (%rdi)
; KNL-NEXT:    retq
;
; SKX-LABEL: trunc_wb_128_mem:
; SKX:       ## BB#0:
; SKX-NEXT:    vpmovwb %xmm0, (%rdi)
; SKX-NEXT:    retq
    %x = trunc <8 x i16> %i to <8 x i8>
    store <8 x i8> %x, <8 x i8>* %res
    ret void
}


define void @usat_trunc_wb_256_mem(<16 x i16> %i, <16 x i8>* %res) {
; KNL-LABEL: usat_trunc_wb_256_mem:
; KNL:       ## BB#0:
; KNL-NEXT:    vextracti128 $1, %ymm0, %xmm1
; KNL-NEXT:    vpackuswb %xmm1, %xmm0, %xmm0
; KNL-NEXT:    vmovdqu %xmm0, (%rdi)
; KNL-NEXT:    retq
;
; SKX-LABEL: usat_trunc_wb_256_mem:
; SKX:       ## BB#0:
; SKX-NEXT:    vpmovuswb %ymm0, (%rdi)
; SKX-NEXT:    retq
  %x3 = icmp ult <16 x i16> %i, <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  %x5 = select <16 x i1> %x3, <16 x i16> %i, <16 x i16> <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  %x6 = trunc <16 x i16> %x5 to <16 x i8>
  store <16 x i8> %x6, <16 x i8>* %res, align 1
  ret void
}

define <16 x i8> @usat_trunc_wb_256(<16 x i16> %i) {
; KNL-LABEL: usat_trunc_wb_256:
; KNL:       ## BB#0:
; KNL-NEXT:    vextracti128 $1, %ymm0, %xmm1
; KNL-NEXT:    vpackuswb %xmm1, %xmm0, %xmm0
; KNL-NEXT:    retq
;
; SKX-LABEL: usat_trunc_wb_256:
; SKX:       ## BB#0:
; SKX-NEXT:    vpmovuswb %ymm0, %xmm0
; SKX-NEXT:    retq
  %x3 = icmp ult <16 x i16> %i, <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  %x5 = select <16 x i1> %x3, <16 x i16> %i, <16 x i16> <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  %x6 = trunc <16 x i16> %x5 to <16 x i8>
  ret <16 x i8> %x6
}

define void @usat_trunc_wb_128_mem(<8 x i16> %i, <8 x i8>* %res) {
; KNL-LABEL: usat_trunc_wb_128_mem:
; KNL:       ## BB#0:
; KNL-NEXT:    vpminuw {{.*}}(%rip), %xmm0, %xmm0
; KNL-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,2,4,6,8,10,12,14,u,u,u,u,u,u,u,u]
; KNL-NEXT:    vmovq %xmm0, (%rdi)
; KNL-NEXT:    retq
;
; SKX-LABEL: usat_trunc_wb_128_mem:
; SKX:       ## BB#0:
; SKX-NEXT:    vpmovuswb %xmm0, (%rdi)
; SKX-NEXT:    retq
  %x3 = icmp ult <8 x i16> %i, <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  %x5 = select <8 x i1> %x3, <8 x i16> %i, <8 x i16> <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  %x6 = trunc <8 x i16> %x5 to <8 x i8>
  store <8 x i8> %x6, <8 x i8>* %res, align 1
  ret void
}

define void @usat_trunc_db_512_mem(<16 x i32> %i, <16 x i8>* %res) {
; ALL-LABEL: usat_trunc_db_512_mem:
; ALL:       ## BB#0:
; ALL-NEXT:    vpmovusdb %zmm0, (%rdi)
; ALL-NEXT:    retq
  %x3 = icmp ult <16 x i32> %i, <i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255>
  %x5 = select <16 x i1> %x3, <16 x i32> %i, <16 x i32> <i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255>
  %x6 = trunc <16 x i32> %x5 to <16 x i8>
  store <16 x i8> %x6, <16 x i8>* %res, align 1
  ret void
}

define void @usat_trunc_qb_512_mem(<8 x i64> %i, <8 x i8>* %res) {
; ALL-LABEL: usat_trunc_qb_512_mem:
; ALL:       ## BB#0:
; ALL-NEXT:    vpmovusqb %zmm0, (%rdi)
; ALL-NEXT:    retq
  %x3 = icmp ult <8 x i64> %i, <i64 255, i64 255, i64 255, i64 255, i64 255, i64 255, i64 255, i64 255>
  %x5 = select <8 x i1> %x3, <8 x i64> %i, <8 x i64> <i64 255, i64 255, i64 255, i64 255, i64 255, i64 255, i64 255, i64 255>
  %x6 = trunc <8 x i64> %x5 to <8 x i8>
  store <8 x i8> %x6, <8 x i8>* %res, align 1
  ret void
}

define void @usat_trunc_qd_512_mem(<8 x i64> %i, <8 x i32>* %res) {
; ALL-LABEL: usat_trunc_qd_512_mem:
; ALL:       ## BB#0:
; ALL-NEXT:    vpmovusqd %zmm0, (%rdi)
; ALL-NEXT:    retq
  %x3 = icmp ult <8 x i64> %i, <i64 4294967295, i64 4294967295, i64 4294967295, i64 4294967295, i64 4294967295, i64 4294967295, i64 4294967295, i64 4294967295>
  %x5 = select <8 x i1> %x3, <8 x i64> %i, <8 x i64> <i64 4294967295, i64 4294967295, i64 4294967295, i64 4294967295, i64 4294967295, i64 4294967295, i64 4294967295, i64 4294967295>
  %x6 = trunc <8 x i64> %x5 to <8 x i32>
  store <8 x i32> %x6, <8 x i32>* %res, align 1
  ret void
}

define void @usat_trunc_qw_512_mem(<8 x i64> %i, <8 x i16>* %res) {
; ALL-LABEL: usat_trunc_qw_512_mem:
; ALL:       ## BB#0:
; ALL-NEXT:    vpmovusqw %zmm0, (%rdi)
; ALL-NEXT:    retq
  %x3 = icmp ult <8 x i64> %i, <i64 65535, i64 65535, i64 65535, i64 65535, i64 65535, i64 65535, i64 65535, i64 65535>
  %x5 = select <8 x i1> %x3, <8 x i64> %i, <8 x i64> <i64 65535, i64 65535, i64 65535, i64 65535, i64 65535, i64 65535, i64 65535, i64 65535>
  %x6 = trunc <8 x i64> %x5 to <8 x i16>
  store <8 x i16> %x6, <8 x i16>* %res, align 1
  ret void
}

define <32 x i8> @usat_trunc_db_1024(<32 x i32> %i) {
; KNL-LABEL: usat_trunc_db_1024:
; KNL:       ## BB#0:
; KNL-NEXT:    vpmovusdb %zmm0, %xmm0
; KNL-NEXT:    vpmovusdb %zmm1, %xmm1
; KNL-NEXT:    vinserti128 $1, %xmm1, %ymm0, %ymm0
; KNL-NEXT:    retq
;
; SKX-LABEL: usat_trunc_db_1024:
; SKX:       ## BB#0:
; SKX-NEXT:    vpbroadcastd {{.*}}(%rip), %zmm2
; SKX-NEXT:    vpminud %zmm2, %zmm1, %zmm1
; SKX-NEXT:    vpminud %zmm2, %zmm0, %zmm0
; SKX-NEXT:    vpmovdw %zmm0, %ymm0
; SKX-NEXT:    vpmovdw %zmm1, %ymm1
; SKX-NEXT:    vinserti64x4 $1, %ymm1, %zmm0, %zmm0
; SKX-NEXT:    vpmovwb %zmm0, %ymm0
; SKX-NEXT:    retq
  %x3 = icmp ult <32 x i32> %i, <i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255>
  %x5 = select <32 x i1> %x3, <32 x i32> %i, <32 x i32> <i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255>
  %x6 = trunc <32 x i32> %x5 to <32 x i8>
  ret <32 x i8> %x6
}

define void @usat_trunc_db_1024_mem(<32 x i32> %i, <32 x i8>* %p) {
; KNL-LABEL: usat_trunc_db_1024_mem:
; KNL:       ## BB#0:
; KNL-NEXT:    vpmovusdb %zmm0, %xmm0
; KNL-NEXT:    vpmovusdb %zmm1, %xmm1
; KNL-NEXT:    vinserti128 $1, %xmm1, %ymm0, %ymm0
; KNL-NEXT:    vmovdqu %ymm0, (%rdi)
; KNL-NEXT:    retq
;
; SKX-LABEL: usat_trunc_db_1024_mem:
; SKX:       ## BB#0:
; SKX-NEXT:    vpbroadcastd {{.*}}(%rip), %zmm2
; SKX-NEXT:    vpminud %zmm2, %zmm1, %zmm1
; SKX-NEXT:    vpminud %zmm2, %zmm0, %zmm0
; SKX-NEXT:    vpmovdw %zmm0, %ymm0
; SKX-NEXT:    vpmovdw %zmm1, %ymm1
; SKX-NEXT:    vinserti64x4 $1, %ymm1, %zmm0, %zmm0
; SKX-NEXT:    vpmovwb %zmm0, (%rdi)
; SKX-NEXT:    retq
  %x3 = icmp ult <32 x i32> %i, <i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255>
  %x5 = select <32 x i1> %x3, <32 x i32> %i, <32 x i32> <i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255>
  %x6 = trunc <32 x i32> %x5 to <32 x i8>
  store <32 x i8>%x6, <32 x i8>* %p, align 1
  ret void
}

define <16 x i16> @usat_trunc_dw_512(<16 x i32> %i) {
; ALL-LABEL: usat_trunc_dw_512:
; ALL:       ## BB#0:
; ALL-NEXT:    vpmovusdw %zmm0, %ymm0
; ALL-NEXT:    retq
  %x3 = icmp ult <16 x i32> %i, <i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535>
  %x5 = select <16 x i1> %x3, <16 x i32> %i, <16 x i32> <i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535>
  %x6 = trunc <16 x i32> %x5 to <16 x i16>
  ret <16 x i16> %x6
}

define <8 x i8> @usat_trunc_wb_128(<8 x i16> %i) {
; ALL-LABEL: usat_trunc_wb_128:
; ALL:       ## BB#0:
; ALL-NEXT:    vpminuw {{.*}}(%rip), %xmm0, %xmm0
; ALL-NEXT:    retq
  %x3 = icmp ult <8 x i16> %i, <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  %x5 = select <8 x i1> %x3, <8 x i16> %i, <8 x i16> <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  %x6 = trunc <8 x i16> %x5 to <8 x i8>
  ret <8 x i8>%x6
}

define <16 x i16> @usat_trunc_qw_1024(<16 x i64> %i) {
; KNL-LABEL: usat_trunc_qw_1024:
; KNL:       ## BB#0:
; KNL-NEXT:    vpbroadcastq {{.*}}(%rip), %zmm2
; KNL-NEXT:    vpminuq %zmm2, %zmm1, %zmm1
; KNL-NEXT:    vpminuq %zmm2, %zmm0, %zmm0
; KNL-NEXT:    vpmovqd %zmm0, %ymm0
; KNL-NEXT:    vpmovqd %zmm1, %ymm1
; KNL-NEXT:    vinserti64x4 $1, %ymm1, %zmm0, %zmm0
; KNL-NEXT:    vpmovdw %zmm0, %ymm0
; KNL-NEXT:    retq
;
; SKX-LABEL: usat_trunc_qw_1024:
; SKX:       ## BB#0:
; SKX-NEXT:    vpbroadcastq {{.*}}(%rip), %zmm2
; SKX-NEXT:    vpminuq %zmm2, %zmm1, %zmm1
; SKX-NEXT:    vpminuq %zmm2, %zmm0, %zmm0
; SKX-NEXT:    vpmovqd %zmm0, %ymm0
; SKX-NEXT:    vpmovqd %zmm1, %ymm1
; SKX-NEXT:    vinserti32x8 $1, %ymm1, %zmm0, %zmm0
; SKX-NEXT:    vpmovdw %zmm0, %ymm0
; SKX-NEXT:    retq
  %x3 = icmp ult <16 x i64> %i, <i64 65535, i64 65535, i64 65535, i64 65535, i64 65535, i64 65535, i64 65535, i64 65535, i64 65535, i64 65535, i64 65535, i64 65535, i64 65535, i64 65535, i64 65535, i64 65535>
  %x5 = select <16 x i1> %x3, <16 x i64> %i, <16 x i64> <i64 65535, i64 65535, i64 65535, i64 65535, i64 65535, i64 65535, i64 65535, i64 65535, i64 65535, i64 65535, i64 65535, i64 65535, i64 65535, i64 65535, i64 65535, i64 65535>
  %x6 = trunc <16 x i64> %x5 to <16 x i16>
  ret <16 x i16> %x6
}

