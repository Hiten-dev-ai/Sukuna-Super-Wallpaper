.class Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;
.super Landroid/service/wallpaper/WallpaperService$Engine;
.source "LiveWallpaperService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/androradar/walls6/LiveWallpaperService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "WallpaperEngine"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$DeviceLockedReceiver;,
        Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;
    }
.end annotation


# instance fields
.field private mDeviceLockedReceiver:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$DeviceLockedReceiver;

.field private mGlView:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;

.field private mKeyGuardManager:Landroid/app/KeyguardManager;

.field private mLocked:Z

.field private mPowerManager:Landroid/os/PowerManager;

.field private mRenderer:Lcom/androradar/walls6/WallpaperRenderer;

.field final synthetic this$0:Lcom/androradar/walls6/LiveWallpaperService;


# direct methods
.method public constructor <init>(Lcom/androradar/walls6/LiveWallpaperService;)V
    .locals 1

    const/4 v0, 0x0

    iput-object p1, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->this$0:Lcom/androradar/walls6/LiveWallpaperService;

    invoke-direct {p0, p1}, Landroid/service/wallpaper/WallpaperService$Engine;-><init>(Landroid/service/wallpaper/WallpaperService;)V

    iput-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mGlView:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;

    iput-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mKeyGuardManager:Landroid/app/KeyguardManager;

    iput-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mPowerManager:Landroid/os/PowerManager;

    iput-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mDeviceLockedReceiver:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$DeviceLockedReceiver;

    iput-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mRenderer:Lcom/androradar/walls6/WallpaperRenderer;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mLocked:Z

    return-void
.end method

.method static synthetic access$100(Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->syncLockedState(Z)V

    return-void
.end method

.method private isDeviceLocked()Z
    .locals 1

    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mKeyGuardManager:Landroid/app/KeyguardManager;

    invoke-virtual {v0}, Landroid/app/KeyguardManager;->isKeyguardLocked()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mPowerManager:Landroid/os/PowerManager;

    invoke-virtual {v0}, Landroid/os/PowerManager;->isInteractive()Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private syncLockedState(Z)V
    .locals 2

    invoke-direct {p0}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->isDeviceLocked()Z

    move-result v0

    iget-boolean v1, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mLocked:Z

    if-ne v1, v0, :cond_0

    if-eqz p1, :cond_1

    :cond_0
    iget-object v1, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mRenderer:Lcom/androradar/walls6/WallpaperRenderer;

    invoke-virtual {v1, v0}, Lcom/androradar/walls6/WallpaperRenderer;->onLocked(Z)V

    iput-boolean v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mLocked:Z

    :cond_1
    return-void
.end method

.method public handleScreenOn()V
    .locals 1

    invoke-direct {p0}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->isDeviceLocked()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mRenderer:Lcom/androradar/walls6/WallpaperRenderer;

    invoke-virtual {v0}, Lcom/androradar/walls6/WallpaperRenderer;->onScreenOn()V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mRenderer:Lcom/androradar/walls6/WallpaperRenderer;

    invoke-virtual {v0}, Lcom/androradar/walls6/WallpaperRenderer;->onUnlocked()V

    :goto_0
    return-void
.end method

.method public handleUnlocked()V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mLocked:Z

    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mRenderer:Lcom/androradar/walls6/WallpaperRenderer;

    invoke-virtual {v0}, Lcom/androradar/walls6/WallpaperRenderer;->onUnlocked()V

    return-void
.end method

.method public handleScreenOff()V
    .locals 1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mLocked:Z

    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mRenderer:Lcom/androradar/walls6/WallpaperRenderer;

    invoke-virtual {v0}, Lcom/androradar/walls6/WallpaperRenderer;->onScreenOff()V

    return-void
.end method



# virtual methods
.method public onCreate(Landroid/view/SurfaceHolder;)V
    .locals 5

    invoke-super {p0, p1}, Landroid/service/wallpaper/WallpaperService$Engine;->onCreate(Landroid/view/SurfaceHolder;)V

    :try_start_0
    new-instance v2, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;

    iget-object v3, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->this$0:Lcom/androradar/walls6/LiveWallpaperService;

    invoke-direct {v2, p0, v3}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;-><init>(Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;Landroid/content/Context;)V

    iput-object v2, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mGlView:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;

    new-instance v2, Lcom/androradar/walls6/WallpaperRenderer;

    iget-object v3, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->this$0:Lcom/androradar/walls6/LiveWallpaperService;

    iget-object v4, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mGlView:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;

    invoke-direct {v2, v3, v4}, Lcom/androradar/walls6/WallpaperRenderer;-><init>(Landroid/content/Context;Landroid/opengl/GLSurfaceView;)V

    iput-object v2, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mRenderer:Lcom/androradar/walls6/WallpaperRenderer;

    iget-object v2, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mGlView:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;

    iget-object v3, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mRenderer:Lcom/androradar/walls6/WallpaperRenderer;

    invoke-virtual {v2, v3}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;->setRenderer(Landroid/opengl/GLSurfaceView$Renderer;)V

    iget-object v2, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->this$0:Lcom/androradar/walls6/LiveWallpaperService;

    const-string v3, "keyguard"

    invoke-virtual {v2, v3}, Lcom/androradar/walls6/LiveWallpaperService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/app/KeyguardManager;

    iput-object v2, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mKeyGuardManager:Landroid/app/KeyguardManager;

    iget-object v2, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->this$0:Lcom/androradar/walls6/LiveWallpaperService;

    const-string v3, "power"

    invoke-virtual {v2, v3}, Lcom/androradar/walls6/LiveWallpaperService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/os/PowerManager;

    iput-object v2, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mPowerManager:Landroid/os/PowerManager;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v2, 0x1

    invoke-direct {p0, v2}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->syncLockedState(Z)V

    invoke-virtual {p0}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->isPreview()Z

    move-result v2

    if-nez v2, :cond_0

    new-instance v1, Landroid/content/IntentFilter;

    invoke-direct {v1}, Landroid/content/IntentFilter;-><init>()V

    const-string v2, "android.intent.action.USER_PRESENT"

    invoke-virtual {v1, v2}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v2, "android.intent.action.SCREEN_OFF"

    invoke-virtual {v1, v2}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v2, "android.intent.action.SCREEN_ON"

    invoke-virtual {v1, v2}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const/16 v2, 0x3e7

    invoke-virtual {v1, v2}, Landroid/content/IntentFilter;->setPriority(I)V

    new-instance v2, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$DeviceLockedReceiver;

    const/4 v3, 0x0

    invoke-direct {v2, p0, v3}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$DeviceLockedReceiver;-><init>(Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;Lcom/androradar/walls6/LiveWallpaperService$1;)V

    iput-object v2, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mDeviceLockedReceiver:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$DeviceLockedReceiver;

    iget-object v2, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->this$0:Lcom/androradar/walls6/LiveWallpaperService;

    iget-object v3, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mDeviceLockedReceiver:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$DeviceLockedReceiver;

    invoke-virtual {v2, v3, v1}, Lcom/androradar/walls6/LiveWallpaperService;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    :cond_0
    return-void

    :catch_0
    move-exception v0

    new-instance v2, Ljava/lang/RuntimeException;

    invoke-direct {v2, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v2
.end method

.method public onDestroy()V
    .locals 2

    invoke-super {p0}, Landroid/service/wallpaper/WallpaperService$Engine;->onDestroy()V

    const/4 v0, 0x0

    sput-object v0, Lcom/androradar/walls6/LiveWallpaperService;->sActiveEngine:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;

    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mDeviceLockedReceiver:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$DeviceLockedReceiver;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->this$0:Lcom/androradar/walls6/LiveWallpaperService;

    iget-object v1, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mDeviceLockedReceiver:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$DeviceLockedReceiver;

    invoke-virtual {v0, v1}, Lcom/androradar/walls6/LiveWallpaperService;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    :cond_0
    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mGlView:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;

    invoke-virtual {v0}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;->onDestroy()V

    return-void
.end method

.method public onSurfaceDestroyed(Landroid/view/SurfaceHolder;)V
    .locals 1

    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mRenderer:Lcom/androradar/walls6/WallpaperRenderer;

    invoke-virtual {v0}, Lcom/androradar/walls6/WallpaperRenderer;->clean()V

    invoke-super {p0, p1}, Landroid/service/wallpaper/WallpaperService$Engine;->onSurfaceDestroyed(Landroid/view/SurfaceHolder;)V

    return-void
.end method

.method public onVisibilityChanged(Z)V
    .locals 1

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mGlView:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;

    invoke-virtual {v0}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;->onResume()V

    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mGlView:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;

    invoke-virtual {v0}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;->requestRender()V

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->mGlView:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;

    invoke-virtual {v0}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView;->onPause()V

    goto :goto_0
.end method
