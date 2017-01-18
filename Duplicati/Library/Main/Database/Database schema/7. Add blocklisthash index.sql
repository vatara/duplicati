BEGIN TRANSACTION;

ALTER TABLE "BlocklistHash"
  RENAME TO "UPGRADE_BlocklistHash";

CREATE TABLE "BlocklistHash" (
    "BlocksetID" INTEGER NOT NULL,
    "Index" INTEGER NOT NULL,
    "Hash" TEXT NOT NULL,
    CONSTRAINT "BlocksetListHash_PK_IdIndex" PRIMARY KEY ("BlocksetID", "Index")
);

INSERT INTO "BlocklistHash" ("BlocksetID", "Index", "Hash")
    SELECT DISTINCT "BlocksetID", "Index", "Hash" FROM "UPGRADE_BlocklistHash";

DROP TABLE "UPGRADE_BlocklistHash";

UPDATE "Version" SET "Version" = 7;

COMMIT;