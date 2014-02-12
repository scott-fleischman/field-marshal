module FieldMarshal.CSharp where
import Data.List

data Name = Name [String] String
  deriving Eq

instance Show Name where
  show (Name namespaces name) = concat $ intersperse "." $ namespaces ++ [name]

data Generic = Generic Name Type [Type]
  deriving Eq

instance Show Generic where
  show (Generic name typ types) = show name ++ "<" ++ typeList ++ ">" where
    typeList = concat $ intersperse ", " $ map show (typ:types)

data Type = NameType Name
  | GenericType Generic
  deriving Eq

instance Show Type where
  show (NameType name) = show name
  show (GenericType generic) = show generic
