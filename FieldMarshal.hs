data NativeType =
    PrimitiveNativeType
  | PointerNativeType
  | ReferenceNativeType
  | ConstNativeType
  | TemplateNativeType
  deriving (Eq, Show)

type PrimitiveNativeType = String

data PointerNativeType =
    Pointer PrimitiveNativeType
  | NestedPointer PointerNativeType
  | PointerToConst ConstNativeType
  deriving (Eq, Show)

data ReferenceNativeType =
    Reference PrimitiveNativeType
  | ReferenceToPointer PointerNativeType
  | ReferenceToConst ConstNativeType
  deriving (Eq, Show)

data ConstNativeType =
    Const PrimitiveNativeType
  | ConstPointer PointerNativeType
  deriving (Eq, Show)

data TemplateNativeType =
    Template String [NativeType]
  deriving (Eq, Show)
