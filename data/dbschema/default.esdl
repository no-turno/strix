module default {
    abstract type Auditable {
        property created_at -> datetime {
            readonly := true;
            default := datetime_current();
        }
    }
    # User type definition
    type User extending Auditable  {
        required property username -> str;
        required property email -> str;
        multi link sessions -> UserSession;
        index pg::spgist on (.username);
    }

    # File type definition
    type File extending Auditable  {
        required property name -> str;
        required property content -> str;
        required property format -> str;
    }

    # Task type definition
    type Task extending Auditable  {
        required property content -> str;
        multi link files -> File;
        required link author -> User;
    }

    # Session type definition
    type UserSession extending Auditable  {
        overloaded required property id -> uuid;
        required link user -> User;
        multi link tokens -> Token;
    }

    # Token type definition
    type Token extending Auditable {
        required property value -> str;
        required property expires_at -> datetime;
    }

    # Bucket type definition
    type Bucket extending Auditable {
        required property name -> str;
        multi link subpaths -> Subpath;
    }

    # Subpath type definition
    type Subpath extending Auditable {
        required property name -> str;
        multi link files -> File;
    }

    # FileSystem type definition
    type FileSystem extending Auditable {
        multi link paths -> Directory;
    }

    # Directory type definition
    type Directory extending Auditable {
        required property name -> str;
        multi link files -> File;
        multi link subdirectories -> Subdirectory;
    }

    # Subdirectory type definition
    type Subdirectory extending Auditable {
        required property name -> str;
        link directory -> Directory;
    }
}