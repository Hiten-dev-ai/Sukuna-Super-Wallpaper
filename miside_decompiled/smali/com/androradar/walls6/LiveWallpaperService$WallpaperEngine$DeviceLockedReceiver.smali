.class Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$DeviceLockedReceiver;
.super Landroid/content/BroadcastReceiver;
.source "LiveWallpaperService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "DeviceLockedReceiver"
.end annotation


# instance fields
.field final synthetic this$1:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;


# direct methods
.method private constructor <init>(Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;)V
    .locals 0

    iput-object p1, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$DeviceLockedReceiver;->this$1:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;Lcom/androradar/walls6/LiveWallpaperService$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$DeviceLockedReceiver;-><init>(Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;)V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 2

    if-nez p2, :cond_0

    return-void

    :cond_0
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    const-string v1, "android.intent.action.SCREEN_ON"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$DeviceLockedReceiver;->this$1:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;

    invoke-virtual {v0}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->handleScreenOn()V

    return-void

    :cond_2
    const-string v1, "android.intent.action.USER_PRESENT"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$DeviceLockedReceiver;->this$1:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;

    invoke-virtual {v0}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->handleUnlocked()V

    return-void

    :cond_3
    const-string v1, "android.intent.action.SCREEN_OFF"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    iget-object v0, p0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine$DeviceLockedReceiver;->this$1:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;

    invoke-virtual {v0}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;->handleScreenOff()V

    :cond_4
    return-void
.end method
