"""Rebuild wallpaper media from the supplied clip without stretching its aspect ratio."""
import argparse
import hashlib
import json
from pathlib import Path
import shutil
import subprocess

ROOT = Path(__file__).resolve().parents[1]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('source', type=Path)
    args = parser.parse_args()
    timing = json.loads((ROOT / 'media-timing.json').read_text(encoding='utf-8'))
    digest = hashlib.sha256(args.source.read_bytes()).hexdigest()
    if digest != timing['source_sha256']:
        parser.error('Source SHA-256 differs from the reviewed clip in media-timing.json')
    ffmpeg = shutil.which('ffmpeg')
    if not ffmpeg:
        parser.error('ffmpeg must be on PATH')
    assets = ROOT / 'miside_decompiled/assets'
    video = assets / 'unlocked.mp4'
    # Keep source cadence. A forced IDR at the first home frame permits an exact seek.
    subprocess.run([
        ffmpeg, '-v', 'error', '-y', '-i', str(args.source), '-an',
        '-vf', 'scale=-2:2712,crop=1220:2712', '-c:v', 'libx264',
        '-preset', 'fast', '-crf', '18', '-pix_fmt', 'yuv420p', '-bf', '0',
        '-g', '24', '-keyint_min', '1', '-sc_threshold', '0',
        '-force_key_frames', f"expr:eq(n,{timing['home_start_frame']})",
        '-video_track_timescale', '1000000', '-movflags', '+faststart', str(video),
    ], check=True)
    for frame, name in [(0, 'backup.jpg'), (timing['home_start_frame'], 'home.jpg')]:
        subprocess.run([
            ffmpeg, '-v', 'error', '-y', '-i', str(video),
            '-vf', f'select=eq(n\\,{frame})', '-frames:v', '1', '-q:v', '2', str(assets / name),
        ], check=True)
    for name in ['preview.jpg', 'banner.jpg']:
        shutil.copyfile(assets / 'home.jpg', ROOT / 'miside_decompiled/res/drawable-xxhdpi-v4' / name)
    print(f"Built {video.name}: lock hold {timing['lock_hold_us']} us; home start {timing['home_start_us']} us")


if __name__ == '__main__':
    main()
