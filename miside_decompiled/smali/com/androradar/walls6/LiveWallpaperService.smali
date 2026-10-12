.class public Lcom/androradar/walls6/LiveWallpaperService;
.super Landroid/service/wallpaper/WallpaperService;
.source "LiveWallpaperService.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;
    }
.end annotation


# static fields
.field public static sActiveEngine:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/service/wallpaper/WallpaperService;-><init>()V

    return-void
.end method


# virtual methods
.method public onCreateEngine()Landroid/service/wallpaper/WallpaperService$Engine;
    .locals 1

    new-instance v0, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;

    invoke-direct {v0, p0}, Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;-><init>(Lcom/androradar/walls6/LiveWallpaperService;)V

    sput-object v0, Lcom/androradar/walls6/LiveWallpaperService;->sActiveEngine:Lcom/androradar/walls6/LiveWallpaperService$WallpaperEngine;

    return-object v0
.end method
