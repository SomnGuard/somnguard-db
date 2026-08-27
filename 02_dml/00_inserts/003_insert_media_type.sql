INSERT INTO parameterization.media_type (id, code, name, mime_type, max_size_mb, is_active, created_at, created_by, updated_at, updated_by)
VALUES
    (gen_random_uuid(), 'image_jpeg', 'Imagen JPEG', 'image/jpeg', 10, TRUE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000'),
    (gen_random_uuid(), 'video_mp4', 'Video MP4', 'video/mp4', 50, TRUE, NOW(), '00000000-0000-0000-0000-000000000000', NOW(), '00000000-0000-0000-0000-000000000000')
ON CONFLICT (code) DO UPDATE SET
    name = EXCLUDED.name,
    mime_type = EXCLUDED.mime_type,
    max_size_mb = EXCLUDED.max_size_mb,
    is_active = EXCLUDED.is_active,
    updated_at = NOW(),
    updated_by = '00000000-0000-0000-0000-000000000000';