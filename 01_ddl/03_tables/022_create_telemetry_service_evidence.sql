CREATE TABLE IF NOT EXISTS telemetry_service.evidence (
    id                      UUID PRIMARY KEY,
    event_id                UUID NOT NULL,
    media_type_id           UUID NOT NULL,
    minio_key               VARCHAR(500) NOT NULL,
    size_bytes              BIGINT NOT NULL,
    checksum_sha256         VARCHAR(64) NOT NULL,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by              UUID NOT NULL,
    is_active               BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT uq_evidence_event_id UNIQUE (event_id),
    CONSTRAINT ck_evidence_size_positive CHECK (size_bytes > 0),
    CONSTRAINT ck_evidence_minio_key_not_empty CHECK (minio_key <> ''),
    CONSTRAINT ck_evidence_checksum_length CHECK (LENGTH(checksum_sha256) = 64),
    CONSTRAINT ck_evidence_is_active CHECK (is_active IN (TRUE, FALSE))
);

CREATE INDEX IF NOT EXISTS idx_evidence_event_id ON telemetry_service.evidence (event_id);
CREATE INDEX IF NOT EXISTS idx_evidence_media_type ON telemetry_service.evidence (media_type_id);