.class Lcom/androradar/walls6/AodActivity$1;
.super Ljava/lang/Object;
.source "AodActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


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

    .line 89
    iput-object p1, p0, Lcom/androradar/walls6/AodActivity$1;->this$0:Lcom/androradar/walls6/AodActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .line 92
    const-string v0, "AOD_DEBUG"

    const-string v1, "mSleepRunnable: 10s expired, putting screen to sleep"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 93
    const/4 v0, 0x1

    sput-boolean v0, Lcom/androradar/walls6/AodActivity;->sSelfSleeping:Z

    .line 94
    iget-object v0, p0, Lcom/androradar/walls6/AodActivity$1;->this$0:Lcom/androradar/walls6/AodActivity;

    invoke-virtual {v0}, Lcom/androradar/walls6/AodActivity;->finish()V

    .line 95
    iget-object v0, p0, Lcom/androradar/walls6/AodActivity$1;->this$0:Lcom/androradar/walls6/AodActivity;

    const/4 v1, 0x0

    invoke-virtual {v0, v1, v1}, Lcom/androradar/walls6/AodActivity;->overridePendingTransition(II)V

    .line 96
    return-void
.end method
