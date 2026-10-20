"""Check packaged frame timing, keyframes, fallback geometry and runtime constants."""
import json
from pathlib import Path
import shutil
import subprocess
import zipfile

ROOT = Path(__file__).resolve().parents[1]


def main():
    timing = json.loads((ROOT / 'media-timing.json').read_text(encoding='utf-8'))
    ffprobe = shutil.which('ffprobe')
    assert ffprobe, 'ffprobe must be on PATH'
    assets = ROOT / 'miside_decompiled/assets'
    info = json.loads(subprocess.check_output([
        ffprobe, '-v', 'error', '-show_streams', '-show_frames', '-of', 'json', str(assets / 'unlocked.mp4'),
    ]))
    stream, = info['streams']
    assert stream['codec_name'] == 'h264'
    assert stream['width'] == timing['width'] and stream['height'] == timing['height']
    assert stream['r_frame_rate'] == f"{timing['fps']}/1"
    frames = info['frames']
    assert len(frames) == 240
    for frame_key, time_key in [('lock_hold_frame', 'lock_hold_us'), ('home_start_frame', 'home_start_us')]:
        frame = frames[timing[frame_key]]
        assert round(float(frame['pts_time']) * 1_000_000) == timing[time_key], (frame_key, frame)
    assert frames[timing['home_start_frame']]['key_frame'] == 1, 'Home start must be a sync frame'
    base = ROOT / 'miside_decompiled/smali/com/androradar/walls6'
    handler = (base / 'VideoPlayer$VideoHandler.smali').read_text(encoding='utf-8')
    for label, time_key in [('pswitch_home', 'home_start_us'), ('pswitch_lock', 'lock_hold_us')]:
        case = handler.split(':' + label + '\n', 1)[1].split('goto :segment_play', 1)[0]
        assert f"0x{timing[time_key]:x}" in case, time_key + ' disagrees with runtime'
    restore = handler.split(':pswitch_restore\n', 1)[1].split(':pswitch_data_0', 1)[0]
    assert f"0x{timing['lock_hold_us']:x}" in restore, 'Restored lock disagrees with timing contract'
    player = (base / 'VideoPlayer.smali').read_text(encoding='utf-8')
    assert f"0x{timing['home_start_us'] * 1000:x}L" in player, 'GL gate disagrees with home PTS'
    assert f"0x{timing['lock_hold_us'] * 1000:x}L" in player, 'GL gate disagrees with lock PTS'
    for image in ['backup.jpg', 'home.jpg', 'rest.jpg']:
        image_info = json.loads(subprocess.check_output([
            ffprobe, '-v', 'error', '-show_streams', '-of', 'json', str(assets / image),
        ]))['streams'][0]
        assert image_info['width'] == timing['width'] and image_info['height'] == timing['height']
    apk = ROOT / 'prebuilt' / (ROOT.name + '.apk')
    with zipfile.ZipFile(apk) as archive:
        for asset in ['unlocked.mp4', 'backup.jpg', 'home.jpg', 'rest.jpg']:
            assert archive.read('assets/' + asset) == (assets / asset).read_bytes(), 'Stale APK asset: ' + asset
        assert archive.getinfo('assets/unlocked.mp4').compress_type == zipfile.ZIP_STORED
    print(f"PASS media/APK: 240 frames, native 24 fps, lock {timing['lock_hold_us']} us, home IDR {timing['home_start_us']} us")


if __name__ == '__main__':
    main()
