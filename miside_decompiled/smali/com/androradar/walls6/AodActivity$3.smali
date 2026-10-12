.class Lcom/androradar/walls6/AodActivity$3;
.super Landroid/content/BroadcastReceiver;
.source "AodActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/androradar/walls6/AodActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/androradar/walls6/AodActivity;


# direct methods
.method constructor <init>(Lcom/androradar/walls6/AodActivity;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010
        }
        names = {
            null
        }
    .end annotation

    .line 120
    iput-object p1, p0, Lcom/androradar/walls6/AodActivity$3;->this$0:Lcom/androradar/walls6/AodActivity;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 0

    .line 123
    const-string p1, "AOD_DEBUG"

    const-string p2, "USER_PRESENT received! Dismissing AOD"

    invoke-static {p1, p2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 124
    iget-object p1, p0, Lcom/androradar/walls6/AodActivity$3;->this$0:Lcom/androradar/walls6/AodActivity;

    invoke-virtual {p1}, Lcom/androradar/walls6/AodActivity;->dismissToLockscreen()V

    .line 125
    return-void
.end method
