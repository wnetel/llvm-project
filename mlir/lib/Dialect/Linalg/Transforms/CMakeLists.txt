add_mlir_dialect_library(MLIRLinalgTransforms
  Fusion.cpp
  Interchange.cpp
  Loops.cpp
  Promotion.cpp
  TensorsToBuffers.cpp
  Tiling.cpp
  Transforms.cpp
  Vectorization.cpp

  ADDITIONAL_HEADER_DIRS
  ${MLIR_MAIN_INCLUDE_DIR}/mlir/Dialect/Linalg

  DEPENDS
  MLIRLinalgPassIncGen

  LINK_LIBS PUBLIC
  MLIRAffineOps
  MLIRAnalysis
  MLIREDSC
  MLIRIR
  MLIRLinalgAnalysis
  MLIRLinalgEDSC
  MLIRLinalgOps
  MLIRLinalgUtils
  MLIRSCF
  MLIRPass
  MLIRStandardOps
  MLIRStandardToLLVM
  MLIRTransformUtils
  MLIRVector
  )
