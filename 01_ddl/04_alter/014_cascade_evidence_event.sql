ALTER TABLE telemetry_service.evidence
    DROP CONSTRAINT fk_evidence_event;

ALTER TABLE telemetry_service.evidence
    ADD CONSTRAINT fk_evidence_event
    FOREIGN KEY (event_id) REFERENCES telemetry_service.event (id)
    ON UPDATE RESTRICT ON DELETE CASCADE;