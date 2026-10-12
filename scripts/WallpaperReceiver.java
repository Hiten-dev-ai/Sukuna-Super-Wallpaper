package com.androradar.walls6;

import android.app.WallpaperManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

public class WallpaperReceiver extends BroadcastReceiver {
    private static final String TAG = "WallpaperReceiver";

    public static void applyLockWallpaper(Context context) {
        new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    WallpaperManager wm = WallpaperManager.getInstance(context);
                    InputStream is = context.getAssets().open("backup.jpg");
                    wm.setStream(is, null, false, 2); // 2 = FLAG_LOCK
                    is.close();
                    Log.i(TAG, "applyLockWallpaper: successfully applied lock wallpaper from backup.jpg");
                } catch (Throwable t) {
                    Log.e(TAG, "applyLockWallpaper: failed", t);
                }
            }
        }).start();
    }

    public static void applyWallpaper(Context context, int which, String customPath) {
        try {
            WallpaperManager wm = WallpaperManager.getInstance(context);
            InputStream is;
            if (customPath != null && new File(customPath).exists()) {
                is = new FileInputStream(customPath);
            } else {
                is = context.getAssets().open("backup.jpg");
            }
            wm.setStream(is, null, false, which);
            is.close();
            Log.i(TAG, "applyWallpaper: successfully applied which=" + which);
        } catch (Throwable t) {
            Log.e(TAG, "applyWallpaper: failed", t);
        }
    }

    @Override
    public void onReceive(final Context context, final Intent intent) {
        new Thread(new Runnable() {
            @Override
            public void run() {
                int which = intent.getIntExtra("which", 2); // default FLAG_LOCK = 2
                String path = intent.getStringExtra("path");
                applyWallpaper(context, which, path);
            }
        }).start();
    }
}
