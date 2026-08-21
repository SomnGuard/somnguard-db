ALTER TABLE telemetry_service.evidence
    ADD CONSTRAINT fk_evidence_event
    FOREIGN KEY (event_id) REFERENCES telemetry_service.event (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE telemetry_service.evidence
    ADD CONSTRAINT fk_evidence_media_type
    FOREIGN KEY (media_type_id) REFERENCES parameterization.media_type (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT;