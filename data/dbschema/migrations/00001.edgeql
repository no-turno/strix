CREATE MIGRATION m1jtwy7n24spoqstujhoziufsm5vbxq3cfmpsyp2biwnwfevnh6iua
    ONTO initial
{
  CREATE ABSTRACT TYPE default::Auditable {
      CREATE PROPERTY created_at: std::datetime {
          SET default := (std::datetime_current());
          SET readonly := true;
      };
  };
  CREATE TYPE default::File EXTENDING default::Auditable {
      CREATE REQUIRED PROPERTY content: std::str;
      CREATE REQUIRED PROPERTY format: std::str;
      CREATE REQUIRED PROPERTY name: std::str;
  };
  CREATE TYPE default::Subpath EXTENDING default::Auditable {
      CREATE MULTI LINK files: default::File;
      CREATE REQUIRED PROPERTY name: std::str;
  };
  CREATE TYPE default::Bucket EXTENDING default::Auditable {
      CREATE MULTI LINK subpaths: default::Subpath;
      CREATE REQUIRED PROPERTY name: std::str;
  };
  CREATE TYPE default::Directory EXTENDING default::Auditable {
      CREATE MULTI LINK files: default::File;
      CREATE REQUIRED PROPERTY name: std::str;
  };
  CREATE TYPE default::FileSystem EXTENDING default::Auditable {
      CREATE MULTI LINK paths: default::Directory;
  };
  CREATE TYPE default::Subdirectory EXTENDING default::Auditable {
      CREATE LINK directory: default::Directory;
      CREATE REQUIRED PROPERTY name: std::str;
  };
  CREATE TYPE default::Token EXTENDING default::Auditable {
      CREATE REQUIRED PROPERTY expires_at: std::datetime;
      CREATE REQUIRED PROPERTY value: std::str;
  };
  CREATE TYPE default::Task EXTENDING default::Auditable {
      CREATE MULTI LINK files: default::File;
      CREATE REQUIRED PROPERTY content: std::str;
  };
  CREATE TYPE default::User EXTENDING default::Auditable {
      CREATE REQUIRED PROPERTY username: std::str;
      CREATE INDEX pg::spgist ON (.username);
      CREATE REQUIRED PROPERTY email: std::str;
  };
  CREATE TYPE default::UserSession EXTENDING default::Auditable {
      ALTER PROPERTY id {
          SET OWNED;
          SET REQUIRED;
          SET TYPE std::uuid;
      };
      CREATE MULTI LINK tokens: default::Token;
      CREATE REQUIRED LINK user: default::User;
  };
  ALTER TYPE default::Directory {
      CREATE MULTI LINK subdirectories: default::Subdirectory;
  };
  ALTER TYPE default::Task {
      CREATE REQUIRED LINK author: default::User;
  };
  ALTER TYPE default::User {
      CREATE MULTI LINK sessions: default::UserSession;
  };
};
