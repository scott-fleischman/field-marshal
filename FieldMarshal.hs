module Native (Name, Pointer, Const, Reference) where

data Name = Name [String] String
  deriving Eq

instance (Show Name) where
  show (Name namespaces name) = (concat $ map (++ "::") namespaces) ++ name

data Pointer = Pointer Name
  | NestedPointer Pointer
  | PointerToConst Const
  deriving Eq

instance (Show Pointer) where
  show (Pointer name) = show name ++ " *"
  show (NestedPointer pointer) = show pointer ++ " *"
  show (PointerToConst const) = show const ++ " *"

data Const = Const Name
  | ConstPointer Pointer
  deriving Eq

instance (Show Const) where
  show (Const name) = "const " ++ show name
  show (ConstPointer pointer) = show pointer ++ " const"

data Reference = Reference Name
  | ReferenceToPointer Pointer
  | ReferenceToConst Const
  deriving Eq

instance (Show Reference) where
  show (Reference name) = show name ++ " &"
  show (ReferenceToPointer pointer) = show pointer ++ " &"
  show (ReferenceToConst const) = show const ++ " &"

data Type = NameType Name
  | PointerType Pointer
  | ConstType Const
  | ReferenceType Reference
  deriving (Eq, Show)
