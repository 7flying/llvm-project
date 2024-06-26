; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs  < %s | FileCheck --check-prefix=CHECK --check-prefix=CHECK-SELDAG  %s
; RUN: llc -verify-machineinstrs -O0 < %s | FileCheck --check-prefix=CHECK --check-prefix=CHECK-FASTISEL %s

target triple = "aarch64-unknown-linux-gnu"

;
; VECTOR_REVERSE
;

define <16 x i8> @reverse_v16i8(<16 x i8> %a) #0 {
; CHECK-LABEL: reverse_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev64 v0.16b, v0.16b
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    ret

  %res = call <16 x i8> @llvm.vector.reverse.v16i8(<16 x i8> %a)
  ret <16 x i8> %res
}

define <8 x i16> @reverse_v8i16(<8 x i16> %a) #0 {
; CHECK-LABEL: reverse_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev64 v0.8h, v0.8h
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    ret

  %res = call <8 x i16> @llvm.vector.reverse.v8i16(<8 x i16> %a)
  ret <8 x i16> %res
}

define <2 x i16> @reverse_v2i16(<2 x i16> %a) #0 {
; CHECK-LABEL: reverse_v2i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev64 v0.2s, v0.2s
; CHECK-NEXT:    ret
  %res = call <2 x i16> @llvm.vector.reverse.v2i16(<2 x i16> %a)
  ret <2 x i16> %res
}

define <2 x i32> @reverse_v2i32(<2 x i32> %a) #0 {
; CHECK-LABEL: reverse_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev64 v0.2s, v0.2s
; CHECK-NEXT:    ret
  %res = call <2 x i32> @llvm.vector.reverse.v2i32(<2 x i32> %a)
  ret <2 x i32> %res
}

define <4 x i32> @reverse_v4i32(<4 x i32> %a) #0 {
; CHECK-LABEL: reverse_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev64 v0.4s, v0.4s
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    ret

  %res = call <4 x i32> @llvm.vector.reverse.v4i32(<4 x i32> %a)
  ret <4 x i32> %res
}

define <2 x i64> @reverse_v2i64(<2 x i64> %a) #0 {
; CHECK-LABEL: reverse_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    ret

  %res = call <2 x i64> @llvm.vector.reverse.v2i64(<2 x i64> %a)
  ret <2 x i64> %res
}

define <8 x half> @reverse_v8f16(<8 x half> %a) #0 {
; CHECK-LABEL: reverse_v8f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev64 v0.8h, v0.8h
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    ret

  %res = call <8 x half> @llvm.vector.reverse.v8f16(<8 x half> %a)
  ret <8 x half> %res
}

define <2 x float> @reverse_v2f32(<2 x float> %a) #0 {
; CHECK-LABEL: reverse_v2f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev64 v0.2s, v0.2s
; CHECK-NEXT:    ret
  %res = call <2 x float> @llvm.vector.reverse.v2f32(<2 x float> %a)
  ret <2 x float> %res
}

define <4 x float> @reverse_v4f32(<4 x float> %a) #0 {
; CHECK-LABEL: reverse_v4f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev64 v0.4s, v0.4s
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    ret

  %res = call <4 x float> @llvm.vector.reverse.v4f32(<4 x float> %a)
  ret <4 x float> %res
}

define <2 x double> @reverse_v2f64(<2 x double> %a) #0 {
; CHECK-LABEL: reverse_v2f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    ret

  %res = call <2 x double> @llvm.vector.reverse.v2f64(<2 x double> %a)
  ret <2 x double> %res
}

; Verify promote type legalisation works as expected.
define <2 x i8> @reverse_v2i8(<2 x i8> %a) #0 {
; CHECK-LABEL: reverse_v2i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev64 v0.2s, v0.2s
; CHECK-NEXT:    ret

  %res = call <2 x i8> @llvm.vector.reverse.v2i8(<2 x i8> %a)
  ret <2 x i8> %res
}

; Verify splitvec type legalisation works as expected.
define <8 x i32> @reverse_v8i32(<8 x i32> %a) #0 {
; CHECK-SELDAG-LABEL: reverse_v8i32:
; CHECK-SELDAG:       // %bb.0:
; CHECK-SELDAG-NEXT:    rev64 v1.4s, v1.4s
; CHECK-SELDAG-NEXT:    rev64 v2.4s, v0.4s
; CHECK-SELDAG-NEXT:    ext v0.16b, v1.16b, v1.16b, #8
; CHECK-SELDAG-NEXT:    ext v1.16b, v2.16b, v2.16b, #8
; CHECK-SELDAG-NEXT:    ret
;
; CHECK-FASTISEL-LABEL: reverse_v8i32:
; CHECK-FASTISEL:       // %bb.0:
; CHECK-FASTISEL-NEXT:    sub sp, sp, #16
; CHECK-FASTISEL-NEXT:    str q1, [sp] // 16-byte Folded Spill
; CHECK-FASTISEL-NEXT:    mov v1.16b, v0.16b
; CHECK-FASTISEL-NEXT:    ldr q0, [sp] // 16-byte Folded Reload
; CHECK-FASTISEL-NEXT:    rev64 v0.4s, v0.4s
; CHECK-FASTISEL-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-FASTISEL-NEXT:    rev64 v1.4s, v1.4s
; CHECK-FASTISEL-NEXT:    ext v1.16b, v1.16b, v1.16b, #8
; CHECK-FASTISEL-NEXT:    add sp, sp, #16
; CHECK-FASTISEL-NEXT:    ret

  %res = call <8 x i32> @llvm.vector.reverse.v8i32(<8 x i32> %a)
  ret <8 x i32> %res
}

; Verify splitvec type legalisation works as expected.
define <16 x float> @reverse_v16f32(<16 x float> %a) #0 {
; CHECK-SELDAG-LABEL: reverse_v16f32:
; CHECK-SELDAG:       // %bb.0:
; CHECK-SELDAG-NEXT:    rev64 v3.4s, v3.4s
; CHECK-SELDAG-NEXT:    rev64 v2.4s, v2.4s
; CHECK-SELDAG-NEXT:    rev64 v4.4s, v1.4s
; CHECK-SELDAG-NEXT:    rev64 v5.4s, v0.4s
; CHECK-SELDAG-NEXT:    ext v0.16b, v3.16b, v3.16b, #8
; CHECK-SELDAG-NEXT:    ext v1.16b, v2.16b, v2.16b, #8
; CHECK-SELDAG-NEXT:    ext v2.16b, v4.16b, v4.16b, #8
; CHECK-SELDAG-NEXT:    ext v3.16b, v5.16b, v5.16b, #8
; CHECK-SELDAG-NEXT:    ret
;
; CHECK-FASTISEL-LABEL: reverse_v16f32:
; CHECK-FASTISEL:       // %bb.0:
; CHECK-FASTISEL-NEXT:    sub sp, sp, #32
; CHECK-FASTISEL-NEXT:    str q3, [sp, #16] // 16-byte Folded Spill
; CHECK-FASTISEL-NEXT:    str q2, [sp] // 16-byte Folded Spill
; CHECK-FASTISEL-NEXT:    mov v2.16b, v1.16b
; CHECK-FASTISEL-NEXT:    ldr q1, [sp] // 16-byte Folded Reload
; CHECK-FASTISEL-NEXT:    mov v3.16b, v0.16b
; CHECK-FASTISEL-NEXT:    ldr q0, [sp, #16] // 16-byte Folded Reload
; CHECK-FASTISEL-NEXT:    rev64 v0.4s, v0.4s
; CHECK-FASTISEL-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-FASTISEL-NEXT:    rev64 v1.4s, v1.4s
; CHECK-FASTISEL-NEXT:    ext v1.16b, v1.16b, v1.16b, #8
; CHECK-FASTISEL-NEXT:    rev64 v2.4s, v2.4s
; CHECK-FASTISEL-NEXT:    ext v2.16b, v2.16b, v2.16b, #8
; CHECK-FASTISEL-NEXT:    rev64 v3.4s, v3.4s
; CHECK-FASTISEL-NEXT:    ext v3.16b, v3.16b, v3.16b, #8
; CHECK-FASTISEL-NEXT:    add sp, sp, #32
; CHECK-FASTISEL-NEXT:    ret

  %res = call <16 x float> @llvm.vector.reverse.v16f32(<16 x float> %a)
  ret <16 x float> %res
}


declare <2 x i8> @llvm.vector.reverse.v2i8(<2 x i8>)
declare <16 x i8> @llvm.vector.reverse.v16i8(<16 x i8>)
declare <8 x i16> @llvm.vector.reverse.v8i16(<8 x i16>)
declare <2 x i16> @llvm.vector.reverse.v2i16(<2 x i16>)
declare <2 x i32> @llvm.vector.reverse.v2i32(<2 x i32>)
declare <4 x i32> @llvm.vector.reverse.v4i32(<4 x i32>)
declare <8 x i32> @llvm.vector.reverse.v8i32(<8 x i32>)
declare <2 x i64> @llvm.vector.reverse.v2i64(<2 x i64>)
declare <8 x half> @llvm.vector.reverse.v8f16(<8 x half>)
declare <2 x float> @llvm.vector.reverse.v2f32(<2 x float>)
declare <4 x float> @llvm.vector.reverse.v4f32(<4 x float>)
declare <16 x float> @llvm.vector.reverse.v16f32(<16 x float>)
declare <2 x double> @llvm.vector.reverse.v2f64(<2 x double>)

attributes #0 = { nounwind "target-features"="+neon" }
