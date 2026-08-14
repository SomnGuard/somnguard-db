INSERT INTO parameterization.media_type (name, code, extension)
VALUES
    ('Audio WAV', 'audio_wav', '.wav'),
    ('Audio MP3', 'audio_mp3', '.mp3'),
    ('Video MP4', 'video_mp4', '.mp4'),
    ('Imagen JPEG', 'image_jpeg', '.jpg')
ON CONFLICT (code) DO NOTHING;