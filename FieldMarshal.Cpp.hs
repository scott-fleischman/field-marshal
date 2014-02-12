module FieldMarshal.Cpp where
import Data.List

data Name = Name [String] String
  deriving Eq

instance Show Name where
  show (Name namespaces name) = concat $ intersperse "::" $ namespaces ++ [name]

data Pointer = Pointer Name
  | NestedPointer Pointer
  | PointerToConst Const
  deriving Eq

instance Show Pointer where
  show (Pointer name) = show name ++ " *"
  show (NestedPointer pointer) = show pointer ++ " *"
  show (PointerToConst const) = show const ++ " *"

data Const = Const Name
  | ConstPointer Pointer
  deriving Eq

instance Show Const where
  show (Const name) = "const " ++ show name
  show (ConstPointer pointer) = show pointer ++ " const"

data Reference = Reference Name
  | ReferenceToPointer Pointer
  | ReferenceToConst Const
  deriving Eq

instance Show Reference where
  show (Reference name) = show name ++ " &"
  show (ReferenceToPointer pointer) = show pointer ++ " &"
  show (ReferenceToConst const) = show const ++ " &"

data Template = Template Name Type [Type]
  deriving Eq

showTypes :: [Type] -> String
showTypes types = concat $ intersperse ", " $ map show $ types

instance Show Template where
  show (Template name typ types) = show name ++ "<" ++ showTypes (typ:types) ++ ">"

data Type = NameType Name
  | PointerType Pointer
  | ConstType Const
  | ReferenceType Reference
  | TemplateType Template
  deriving Eq

instance Show Type where
  show (NameType name) = show name
  show (PointerType pointer) = show pointer
  show (ConstType const) = show const
  show (ReferenceType reference) = show reference
  show (TemplateType template) = show template

data MaybeVoidType = NotVoid Type | Void
  deriving Eq

instance Show MaybeVoidType where
  show (NotVoid typ) = show typ
  show Void = "void"

data Variable = Variable Type String
  deriving Eq

instance Show Variable where
  show (Variable typ name) = show typ ++ " " ++ name

data Function = Function Name [Variable] MaybeVoidType
  | TemplateFunction Name Type [Type] [Variable] MaybeVoidType
  deriving Eq

showParameters :: [Variable] -> String
showParameters parameters = concat $ intersperse ", " $ map show parameters

instance Show Function where
  show (Function name parameters return) = show return ++ " " ++ show name ++ "(" ++ showParameters parameters ++ ")"
  show (TemplateFunction name firstType types parameters return) = show return ++ " " ++ show name ++ "<" ++ showTypes (firstType:types) ++ ">(" ++ showParameters parameters ++ ")"

newtype FunctionPointer = FunctionPointer Function
  deriving Eq

instance Show FunctionPointer where
  show (FunctionPointer (Function name parameters return)) = show return ++ " (* " ++ show name ++ ")(" ++ showParameters parameters ++ ")"
