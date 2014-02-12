module FieldMarshal.Marshal where
import FieldMarshal.CSharp as CSharp
import FieldMarshal.Cpp as Cpp

data MarshalType =
    MarshalDefault Cpp.Type CSharp.Type
  | MarshalAs Cpp.Type CSharp.Type String
  | MarshalWrap Cpp.Type CSharp.Type [CppTypeWrapper]
  | MarshalPlatform Cpp.Type CSharp.Type [(Platform, CppTypeWrapper)]
  deriving (Eq, Show)

data Platform = Microsoft | Mono
  deriving (Eq, Show)

data ConversionCode = ConversionCode Cpp.Type [String] [String]
  deriving (Eq, Show)

data CppTypeWrapper =
    WrapToCppOwned ConversionCode
  | WrapToCppUnowned ConversionCode
  | WrapToCSharpOwned ConversionCode
  | WrapToCSharpUnowned ConversionCode
  deriving (Eq, Show)
