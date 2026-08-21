INSERT INTO parameterization.media_type (code, name, is_active)
VALUES
    ('audio_wav', 'Audio WAV', TRUE),
    ('audio_mp3', 'Audio MP3', TRUE),
    ('video_mp4', 'Video MP4', TRUE),
    ('image_jpeg', 'Imagen JPEG', TRUE)
ON CONFLICT (code) DO NOTHING;