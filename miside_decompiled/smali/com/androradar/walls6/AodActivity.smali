.class public Lcom/androradar/walls6/AodActivity;
.super Landroid/app/Activity;
.source "AodActivity.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/androradar/walls6/AodActivity$AodView;
    }
.end annotation


# static fields
.field private static final TAG:Ljava/lang/String; = "AOD_DEBUG"

.field public static volatile sSelfSleeping:Z


# instance fields
.field private mAodView:Lcom/androradar/walls6/AodActivity$AodView;

.field private mGestureDetector:Landroid/view/GestureDetector;

.field private mHandler:Landroid/os/Handler;

.field private mSleepRunnable:Ljava/lang/Runnable;

.field private mUnlockReceiver:Landroid/content/BroadcastReceiver;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 37
    const/4 v0, 0x0

    sput-boolean v0, Lcom/androradar/walls6/AodActivity;->sSelfSleeping:Z

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 35
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method

.method static synthetic access$000(Lcom/androradar/walls6/AodActivity;)V
    .locals 0

    .line 35
    invoke-direct {p0}, Lcom/androradar/walls6/AodActivity;->resetTimer()V

    return-void
.end method

.method static synthetic access$100(Lcom/androradar/walls6/AodActivity;)Lcom/androradar/walls6/AodActivity$AodView;
    .locals 0

    .line 35
    iget-object p0, p0, Lcom/androradar/walls6/AodActivity;->mAodView:Lcom/androradar/walls6/AodActivity$AodView;

    return-object p0
.end method

.method private resetTimer()V
    .locals 4

    .line 150
    iget-object v0, p0, Lcom/androradar/walls6/AodActivity;->mHandler:Landroid/os/Handler;

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/androradar/walls6/AodActivity;->mSleepRunnable:Ljava/lang/Runnable;

    if-eqz v1, :cond_0

    .line 151
    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 152
    iget-object v0, p0, Lcom/androradar/walls6/AodActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/androradar/walls6/AodActivity;->mSleepRunnable:Ljava/lang/Runnable;

    const-wide/16 v2, 0x2710

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 154
    :cond_0
    return-void
.end method


# virtual methods
.method public dismissToLockscreen()V
    .locals 3

    .line 131
    const-string v0, "dismissToLockscreen: finishing AodActivity and waking wallpaper"

    const-string v1, "AOD_DEBUG"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 132
    iget-object v0, p0, Lcom/androradar/walls6/AodActivity;->mHandler:Landroid/os/Handler;

    if-eqz v0, :cond_0

    iget-object v2, p0, Lcom/androradar/walls6/AodActivity;->mSleepRunnable:Ljava/lang/Runnable;

    if-eqz v2, :cond_0

    .line 133
    invoke-virtual {v0, v2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 138
    :cond_0
    :try_start_0
    sget-object v0, Lcom/androradar/walls6/LiveWallpaperService;->sActiveEngine:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;

    if-eqz v0, :cond_1

    .line 139
    sget-object v0, Lcom/androradar/walls6/LiveWallpaperService;->sActiveEngine:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;

    invoke-virtual {v0}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->handleScreenOn()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 143
    :cond_1
    goto :goto_0

    .line 141
    :catchall_0
    move-exception v0

    .line 142
    const-string v2, "Error invoking handleScreenOn"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 145
    :goto_0
    invoke-virtual {p0}, Lcom/androradar/walls6/AodActivity;->finish()V

    .line 146
    const/4 v0, 0x0

    invoke-virtual {p0, v0, v0}, Lcom/androradar/walls6/AodActivity;->overridePendingTransition(II)V

    .line 147
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2

    .line 47
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 48
    const-string p1, "AOD_DEBUG"

    const-string v0, "onCreate: starting AOD"

    invoke-static {p1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 50
    const/4 p1, 0x0

    sput-boolean p1, Lcom/androradar/walls6/AodActivity;->sSelfSleeping:Z

    .line 53
    invoke-virtual {p0}, Lcom/androradar/walls6/AodActivity;->getWindow()Landroid/view/Window;

    move-result-object p1

    const v0, 0x80498

    invoke-virtual {p1, v0}, Landroid/view/Window;->addFlags(I)V

    .line 61
    sget p1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v0, 0x1b

    if-lt p1, v0, :cond_0

    .line 62
    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Lcom/androradar/walls6/AodActivity;->setShowWhenLocked(Z)V

    .line 63
    invoke-virtual {p0, p1}, Lcom/androradar/walls6/AodActivity;->setTurnScreenOn(Z)V

    .line 67
    :cond_0
    invoke-virtual {p0}, Lcom/androradar/walls6/AodActivity;->getWindow()Landroid/view/Window;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object p1

    .line 68
    const v0, 0x3c23d70a    # 0.01f

    iput v0, p1, Landroid/view/WindowManager$LayoutParams;->screenBrightness:F

    .line 69
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    if-lt v0, v1, :cond_1

    .line 70
    const/high16 v0, 0x42700000    # 60.0f

    iput v0, p1, Landroid/view/WindowManager$LayoutParams;->preferredRefreshRate:F

    .line 72
    :cond_1
    invoke-virtual {p0}, Lcom/androradar/walls6/AodActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V

    .line 75
    invoke-virtual {p0}, Lcom/androradar/walls6/AodActivity;->getWindow()Landroid/view/Window;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object p1

    const/16 v0, 0x1706

    invoke-virtual {p1, v0}, Landroid/view/View;->setSystemUiVisibility(I)V

    .line 84
    new-instance p1, Lcom/androradar/walls6/AodActivity$AodView;

    invoke-direct {p1, p0}, Lcom/androradar/walls6/AodActivity$AodView;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lcom/androradar/walls6/AodActivity;->mAodView:Lcom/androradar/walls6/AodActivity$AodView;

    .line 85
    invoke-virtual {p0, p1}, Lcom/androradar/walls6/AodActivity;->setContentView(Landroid/view/View;)V

    .line 88
    new-instance p1, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-direct {p1, v0}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object p1, p0, Lcom/androradar/walls6/AodActivity;->mHandler:Landroid/os/Handler;

    .line 89
    new-instance p1, Lcom/androradar/walls6/AodActivity$1;

    invoke-direct {p1, p0}, Lcom/androradar/walls6/AodActivity$1;-><init>(Lcom/androradar/walls6/AodActivity;)V

    iput-object p1, p0, Lcom/androradar/walls6/AodActivity;->mSleepRunnable:Ljava/lang/Runnable;

    .line 98
    invoke-direct {p0}, Lcom/androradar/walls6/AodActivity;->resetTimer()V

    .line 101
    new-instance p1, Landroid/view/GestureDetector;

    new-instance v0, Lcom/androradar/walls6/AodActivity$2;

    invoke-direct {v0, p0}, Lcom/androradar/walls6/AodActivity$2;-><init>(Lcom/androradar/walls6/AodActivity;)V

    invoke-direct {p1, p0, v0}, Landroid/view/GestureDetector;-><init>(Landroid/content/Context;Landroid/view/GestureDetector$OnGestureListener;)V

    iput-object p1, p0, Lcom/androradar/walls6/AodActivity;->mGestureDetector:Landroid/view/GestureDetector;

    .line 120
    new-instance p1, Lcom/androradar/walls6/AodActivity$3;

    invoke-direct {p1, p0}, Lcom/androradar/walls6/AodActivity$3;-><init>(Lcom/androradar/walls6/AodActivity;)V

    iput-object p1, p0, Lcom/androradar/walls6/AodActivity;->mUnlockReceiver:Landroid/content/BroadcastReceiver;

    .line 127
    new-instance v0, Landroid/content/IntentFilter;

    const-string v1, "android.intent.action.USER_PRESENT"

    invoke-direct {v0, v1}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, p1, v0}, Lcom/androradar/walls6/AodActivity;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 128
    return-void
.end method

.method protected onDestroy()V
    .locals 2

    .line 198
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    .line 199
    const-string v0, "AOD_DEBUG"

    const-string v1, "onDestroy"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 200
    iget-object v0, p0, Lcom/androradar/walls6/AodActivity;->mHandler:Landroid/os/Handler;

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/androradar/walls6/AodActivity;->mSleepRunnable:Ljava/lang/Runnable;

    if-eqz v1, :cond_0

    .line 201
    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 203
    :cond_0
    iget-object v0, p0, Lcom/androradar/walls6/AodActivity;->mUnlockReceiver:Landroid/content/BroadcastReceiver;

    if-eqz v0, :cond_1

    .line 205
    :try_start_0
    invoke-virtual {p0, v0}, Lcom/androradar/walls6/AodActivity;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 206
    :catch_0
    move-exception v0

    :goto_0
    nop

    .line 208
    :cond_1
    return-void
.end method

.method protected onResume()V
    .locals 2

    .line 187
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 188
    const-string v0, "AOD_DEBUG"

    const-string v1, "onResume: active"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 189
    const/4 v0, 0x0

    sput-boolean v0, Lcom/androradar/walls6/AodActivity;->sSelfSleeping:Z

    .line 190
    invoke-direct {p0}, Lcom/androradar/walls6/AodActivity;->resetTimer()V

    .line 191
    iget-object v0, p0, Lcom/androradar/walls6/AodActivity;->mAodView:Lcom/androradar/walls6/AodActivity$AodView;

    if-eqz v0, :cond_0

    .line 192
    invoke-virtual {v0}, Lcom/androradar/walls6/AodActivity$AodView;->invalidate()V

    .line 194
    :cond_0
    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 7

    .line 158
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    const/4 v1, 0x1

    if-nez v0, :cond_2

    .line 159
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    .line 160
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v2

    .line 161
    iget-object v3, p0, Lcom/androradar/walls6/AodActivity;->mAodView:Lcom/androradar/walls6/AodActivity$AodView;

    if-eqz v3, :cond_0

    invoke-virtual {v3}, Lcom/androradar/walls6/AodActivity$AodView;->getWidth()I

    move-result v3

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/androradar/walls6/AodActivity;->getWindow()Landroid/view/Window;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/View;->getWidth()I

    move-result v3

    .line 162
    :goto_0
    iget-object v4, p0, Lcom/androradar/walls6/AodActivity;->mAodView:Lcom/androradar/walls6/AodActivity$AodView;

    if-eqz v4, :cond_1

    invoke-virtual {v4}, Lcom/androradar/walls6/AodActivity$AodView;->getHeight()I

    move-result v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/androradar/walls6/AodActivity;->getWindow()Landroid/view/Window;

    move-result-object v4

    invoke-virtual {v4}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v4

    invoke-virtual {v4}, Landroid/view/View;->getHeight()I

    move-result v4

    .line 163
    :goto_1
    if-lez v3, :cond_2

    if-lez v4, :cond_2

    .line 166
    int-to-float v3, v3

    const/high16 v5, 0x3f000000    # 0.5f

    mul-float v5, v5, v3

    .line 167
    int-to-float v4, v4

    const v6, 0x3f660aa6    # 0.8986f

    mul-float v4, v4, v6

    .line 168
    sub-float v5, v0, v5

    .line 169
    sub-float v4, v2, v4

    .line 170
    mul-float v5, v5, v5

    mul-float v4, v4, v4

    add-float/2addr v5, v4

    .line 171
    const v4, 0x3df5c28f    # 0.12f

    mul-float v3, v3, v4

    .line 172
    mul-float v3, v3, v3

    cmpg-float v3, v5, v3

    if-gtz v3, :cond_2

    .line 173
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "FOD touch detected at ("

    invoke-virtual {p1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, ","

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "), dismissing to lockscreen"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v0, "AOD_DEBUG"

    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 174
    invoke-virtual {p0}, Lcom/androradar/walls6/AodActivity;->dismissToLockscreen()V

    .line 175
    return v1

    .line 179
    :cond_2
    iget-object v0, p0, Lcom/androradar/walls6/AodActivity;->mGestureDetector:Landroid/view/GestureDetector;

    if-eqz v0, :cond_3

    invoke-virtual {v0, p1}, Landroid/view/GestureDetector;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 180
    return v1

    .line 182
    :cond_3
    invoke-super {p0, p1}, Landroid/app/Activity;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result p1

    return p1
.end method
