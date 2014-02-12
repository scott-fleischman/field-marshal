module FieldMarshal.Marshal where
import qualified FieldMarshal.CSharp as CSharp
import qualified FieldMarshal.Cpp as Cpp

data MarshalType =
    MarshalDefault Cpp.Type CSharp.Type
  | MarshalAs Cpp.Type CSharp.Type UnmanagedType
  | MarshalWrap Cpp.Type CSharp.Type [CppTypeWrapper]
  | MarshalPlatform Cpp.Type CSharp.Type [(Platform, CppTypeWrapper)]
  deriving (Eq, Show)

newtype UnmanagedType = UnmanagedType String
  deriving (Eq, Show)

data Platform = Microsoft | Mono
  deriving (Eq, Show)

data ConversionCode = ConversionCode UnmanagedType Cpp.Type [String] [String]
  deriving (Eq, Show)

data CppTypeWrapper =
    WrapToCppOwned ConversionCode
  | WrapToCppUnowned ConversionCode
  | WrapToCSharpOwned ConversionCode
  | WrapToCSharpUnowned ConversionCode
  deriving (Eq, Show)
